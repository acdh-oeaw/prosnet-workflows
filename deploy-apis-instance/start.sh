#!/bin/bash

red() {
	echo -e "\e[0;31m Running> $@ \e[0m"
	$@
	echo -e "\e[0;31m Done> $@ \e[0m"
}
red django-admin migrate
red django-admin collectstatic
[[ $CREATE_RELATIONSHIPS == "True" ]] && red django-admin create_relationships
gunicorn wsgi -b 0.0.0.0:5000 --timeout 120 --workers=3 --threads=3 --worker-connections=1000
