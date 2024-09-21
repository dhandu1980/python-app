# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container
COPY . .

# Install dependencies
RUN pip install -r requirements.txt

# Expose the port on which the app runs
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]