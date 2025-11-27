#!/bin/bash 

source "./secrets.sh"

# Polku virtuaaliympäristöön 
VENV_DIR="venv" 

# Luo virtuaaliympäristö, jos ei ole olemassa 
if [ ! -d "$VENV_DIR" ]; then 
	echo "Luodaan virtuaaliympäristö..." 
	python3 -m venv $VENV_DIR 
fi 

# Aktivoi virtuaaliympäristö 
source $VENV_DIR/bin/activate 

# Asenna riippuvuudet requirements.txt-tiedostosta 
if [ -f "requirements.txt" ]; then 
	echo "Asennetaan riippuvuudet..." 
	pip install --upgrade pip 
	pip install -r requirements.txt 
else 
	echo "requirements.txt ei löytynyt!" 
fi 

if [ -f "mqtt_logger.py" ]; then 
	echo "Suoritetaan mqtt_logger.py..." 
	uvicorn main:app --host 0.0.0.0 --port 1213
else 
	echo "mqtt_logger.py ei löytynyt!" 
fi 

echo "Valmis!"
