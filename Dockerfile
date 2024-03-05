#Use an official python runtime as a parent image
#FROM python:3.8-alpine
FROM python:3.12-alpine 

#Set the working directory in the container
WORKDIR /code

#Copy the files into the container
COPY . .

RUN pip install Flask

#Expose the port your app will run on (replace port 3000 with your desired port)
EXPOSE 5000

#Define the command to run your Flask application
CMD ["python", "app.py"]
