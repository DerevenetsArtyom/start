
run:
	python $(NAMEDIR)/manage.py runserver 0.0.0.0:8000

messages:
	python $(NAMEDIR)/python manage.py makemessages -l en-us
