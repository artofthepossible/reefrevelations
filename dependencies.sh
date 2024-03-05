#!/bin/bash
# Install the required packages
pip3 install --upgrade pip
pip3 install requests psycopg pytest testcontainers boto3 flask flask_restful

# Freeze the installed packages to a requirements.txt file
pip3 freeze > requirements.txt

