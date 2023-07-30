# Use the no-vnc-base image from the local/m2aia repository as the base image
FROM local/m2aia:no-vnc-base

# Add labels to identify the image and its version
LABEL IMAGE="qupath"
LABEL VERSION="0.4.3"

# Replace the #Title# placeholder in the index.html file with "QuPath Online"
RUN sed -i 's/#Title#/QuPath Online/' /usr/local/lib/web/frontend/index.html

# Create directories for the source code and QuPath installation
RUN mkdir -p /src /qupath

# Download the QuPath installation package from GitHub and extract it to the /qupath directory
RUN wget https://github.com/qupath/qupath/releases/download/v0.4.3/QuPath-0.4.3-Linux.tar.xz -O /src/qupath.tar.xz && \
    tar -xvf /src/qupath.tar.xz --strip 1 -C /qupath/ && rm -rf /src/qupath.tar.xz

# Make the QuPath executable files executable
RUN chmod +x /qupath/bin/QuPath*

# Copy a shell script that starts the application to the Desktop folder and make it executable
COPY files/startQuPath.sh /root/Desktop/
RUN chmod 0777 /root/Desktop/startQuPath.sh

# Set the working directory to /data
WORKDIR /data

# Copy a supervisord config file that manages the application
COPY files/supervisord.conf /etc/supervisor/conf.d/