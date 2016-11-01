#!/bin/sh

BASEDIR=/var/lib/reprepro
OUTDIR=/repository/debian

reprepro -V --basedir $BASEDIR --outdir $OUTDIR createsymlinks stable
reprepro -V --basedir $BASEDIR --outdir $OUTDIR createsymlinks jessie

# Import packages from incoming dir
reprepro -V --basedir $BASEDIR \
         --outdir $OUTDIR \
         processincoming incoming

chown -R www-data:www-data $OUTDIR
