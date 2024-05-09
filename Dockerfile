# # this is my base image
# FROM alpine:3.5

# # Install python and pip
# RUN apk add --update py2-pip

# # Install curl
# RUN apk --no-cache add curl

# # install Python modules needed by the Python app
# COPY requirements.txt /usr/src/app/
# RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

# # copy files required for the app to run
# COPY app.py /usr/src/app/
# COPY templates/index.html /usr/src/app/templates/

# # tell the port number the container should expose
# EXPOSE 5000

# # run the application
# CMD ["python", "/usr/src/app/app.py"]


FROM amazonlinux:3

WORKDIR /usr/src/app
COPY nodeapp/* /
RUN amazon-linux-extras enable nodejs && yum install -y nodejs

# Install dependencies
RUN npm install

EXPOSE 3000

# Install Apache httpd
RUN yum install -y httpd httpd-tools
RUN yum install -y docker 

RUN systemctl start httpd
RUN systemctl start docker

# Open port 80 in the firewall (adjust firewall command based on your system)
RUN firewall-cmd --permanent --add-port=80/tcp
RUN firewall-cmd --reload  # Reload firewall rules

# **Note:** Opening port 80 exposes your server to potential attacks. Ensure proper security measures are in place before running this command in a production environment.

CMD [ "npm", "start" ]
