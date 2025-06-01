# Building the image
FROM python:3-alpine
LABEL author="Mmatovski" description="Docker Image for Python Greetings"

WORKDIR /app
COPY . .
RUN pip install --no-cache-dir -r requirements.txt

# After the image is built/Post build
EXPOSE 3000
ENTRYPOINT ["python", "app.py"]
