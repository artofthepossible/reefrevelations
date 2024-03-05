# Use an official Python runtime as a parent image
#worse image
#FROM python:3.8-alpine as builder
#better image
FROM python:3.12-alpine as builder


# Create a new user and group with the ID 1000
RUN addgroup -S appgroup && adduser -S -g appgroup appuser

# Set the working directory in the container
WORKDIR /code

# Copy the requirements file
COPY requirements.txt requirements.txt

# Install Flask and other dependencies
RUN pip install -r requirements.txt

# Copy the rest of the files into the container
COPY . .

# Set the ownership of the working directory to the non-root user
RUN chown -R appuser:appgroup /code

# Create a smaller, final image that only contains the necessary runtime dependencies
#worse image
#FROM python:3.8-alpine
#better image
FROM python:3.12-alpine


# Create a new user and group with the same ID as the builder stage
RUN addgroup -S appgroup && adduser -S -g appgroup appuser

# Set the working directory in the container
WORKDIR /code

# Copy only the installed packages from the builder stage
#worse
#COPY --from=builder /usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages
#better
COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages

# Copy the application code
COPY . .

# Set the ownership of the working directory to the non-root user
RUN chown -R appuser:appgroup /code

# Expose the port your app will run on
EXPOSE 5000

# Switch to the non-root user
USER appuser

# Define the command to run your Flask application
CMD ["python", "app.py"]
