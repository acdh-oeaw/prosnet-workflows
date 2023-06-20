#!/bin/bash
gunicorn wsgi -b 0.0.0.0:5000 --timeout 120 --workers=3 --threads=3 --worker-connections=1000
