#!/bin/sh

cname="ora12";
volnm="-v ./copy_files:/data";

podman run -itd --name $cname --hostname $cname $volnm $cname

