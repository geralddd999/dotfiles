#!/bin/bash

#start the container
docker start matlab-vnc

#launch tigervnc and connect to the container
vncviewer localhost:5901

#on vnc close, stop the container
docker stop matlab-vnc
