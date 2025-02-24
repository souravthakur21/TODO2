# Use a stable Python version (3.11) to avoid distutils issues
FROM python:3.11

# Set the working directory inside the container
WORKDIR /data

# Install setuptools (includes distutils)
RUN pip install --upgrade pip setuptools

# Copy requirements file first to leverage Docker caching
COPY requirements.txt /data/

# Install all dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . /data/

# Run database migrations
RUN python manage.py migrate

# Expose port 8000 for Django
EXPOSE 8000

# Start the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

