
run:
	python $(NAMEDIR)/manage.py runserver 0.0.0.0:8000

messages:
	cd $(NAMEDIR)/ && python manage.py makemessages -l en
	cd $(NAMEDIR)/ && python manage.py makemessages -d djangojs -l en

	cd $(NAMEDIR)/ && python manage.py compilemessages
