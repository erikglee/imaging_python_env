# Use the official Python base image
FROM python:3.9

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    JUPYTER_TOKEN='' \
    JUPYTER_PORT=8888

# Install necessary system packages
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install Jupyter Notebook and essential Python packages
RUN pip install --upgrade pip \
    && pip install jupyter \
    && pip install numpy pandas matplotlib

# Set up a working directory
WORKDIR /workspace

# Expose the port for Jupyter Notebook
EXPOSE $JUPYTER_PORT

#Set up the kernel
RUN python3 -m ipykernel install --user --name imaging_python_env --display-name "imaging python env"



# Define the command to run Jupyter Notebook
CMD ["jupyter", "notebook", "--no-browser", "--ip=0.0.0.0", "--port=${JUPYTER_PORT}", "--allow-root", "--NotebookApp.token=${JUPYTER_TOKEN}"]
