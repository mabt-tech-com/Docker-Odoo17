# Use your pulled Docker image as the base image
FROM iifast2/odoo17-img:1.0

#COPY everthing, cloud be like this: ./odoo-code /opt/odoo17
COPY ./odoo-config/odoo17.conf /etc/odoo17.conf

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    postgresql \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Copy your custom supervisor configuration file if you have one
# COPY odoo17.conf /etc/supervisor/conf.d/odoo17.conf

# Expose the necessary port
EXPOSE 8069

# Command to start all necessary services when the container is run
CMD service postgresql start && \
    service supervisor start && \
    supervisorctl start odoo17 && \
    tail -f /var/log/odoo17/odoo17.log