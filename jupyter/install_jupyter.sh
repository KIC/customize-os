#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# install jupyther notebook
sudo apt-get install python3-pip
sudo apt-get install jupyter-nbextension-jupyter-js-widgets python3-jupyter-console python3-jupyter-core
sudo pip3 install ipywidgets jupyterlab jupyterlab-extensions jupyterlab-widgets
jupyter nbextension enable --py widgetsnbextension
jupyter-notebook --generate-config

echo "c.NotebookApp.token='kic'" >> ~/.jupyter/jupyter_notebook_config.py 
install -D "$DIR/custom.css" ~/.jupyter/custom/custom.css

sudo cp "$DIR/jupyter.service" /etc/systemd/system/
sudo systemctl enable jupyter.service 
sudo service jupyter start

