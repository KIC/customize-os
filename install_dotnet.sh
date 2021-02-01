#!/bin/bash

sudo snap install dotnet-sdk --classic
sudo snap alias dotnet-sdk.dotnet dotnet
wget -qO- https://aka.ms/install-artifacts-credprovider.sh | bash
echo "export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1" >> ~/.bashrc
