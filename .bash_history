cd backend/
source venv/bin/activate
ls
nano requirements.txt 
pip install -r requirements.txt
pip show phonenumbers
sudo -u postgres psql
psql -U profi_user -d profi_db -f init.sql
sudo nano /etc/postgresql/12/main/pg_hba.conf
sudo systemctl reload postgresql
psql -U profi_user -d profi_db -f init.sql
psql -U profi_user -d profi_db
curl http://localhost:8000/api/users/
clean
clear
cd backend/
source venv/bin/activate
ls
cd core/
nano models.py 
cd ../
python manage.py makemigrations
python manage.py migrate --fake core
python manage.py runserver 0.0.0.0:8000
curl http://localhost:8000/api/users/
curl -X POST http://localhost:8000/api/register/ -H "Content-Type: application/json" -d '{"phone": "+1234567892"}'
curl -X POST http://localhost:8000/api/verify-code/ -H "Content-Type: application/json" -d '{"phone": "+1234567892", "code": "123456"}'
git init
git add .
git commit -m "first commit"
git config --global user.email "takprostotakprostotak@gmail.com"
git config --global user.name "Prostotatik"
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/Prostotatik/Django.git
git push -u origin main
cd backend/
python manage.py migrate
source venv/bin/activate
python manage.py migrate
python manage.py runserver 0.0.0.0:8000
curl http://localhost:8000/api/users/
curl -X POST http://localhost:8000/api/register/ -H "Content-Type: application/json" -d '{"phone": "+1234567893"}'
curl -X POST http://localhost:8000/api/verify-code/ -H "Content-Type: application/json" -d '{"phone": "+1234567893", "code": "800288"}'
curl http://localhost:8000/api/categories/
curl http://localhost:8000/api/services/
curl http://localhost:8000/api/orders/
curl http://localhost:8000/api/payments/
ls
cd backend/
ls
source venv/bin/activate
nano core/views.py 
python manage.py runserver 0.0.0.0:8000
curl -X POST http://localhost:8000/api/verify-code/ -H "Content-Type: application/json" -d '{"phone": "+1234567893", "code": "800288"}'
curl http://localhost:8000/api/users/
curl http://localhost:8000/api/categories/
clear
ls
git status
git remote -v
git add .
git commit "second commit"
git commit -m "second commit"
git push -u origin main
ды
ls
cd backend/
ls
cd core/
nano models.py 
cd ../
cd django_project/
nano settings.py 
nano urls.py 
python manage.py createsuperuser
cd ../
source venv/bin/activate
ls 
nano core/models.py 
nano core/admin.py 
python manage.py createsuperuser
from django.contrib.auth.models import Group, User
group, created = Group.objects.get_or_create(name='Developer')
user = User.objects.get(username='your_superuser')  # Replace with your superuser username
user.groups.add(group)
user.is_staff = True  # Required for admin access
user.is_superuser = True  # Optional: full admin access
user.save() exit
python manage.py shell
python manage.py runserver 0.0.0.0:8000
ls
mkdir backend
cd backend/
python3 -m venv venv
source venv/bin/activate
nano requirements.txt
pip install -r requirements.txt
django-admin startproject django_project .
python manage.py startapp core
ls
cd django_project/
ls
nano settings.py 
cd ../
nano init.sql
ls
cd core/
nano models.py
ls
nano serializers.py
nano views.py 
nano urls.py
cd ../
ls
cd django_project/
ls
nano urls.py 
cd ../
python manage.py runserver 0.0.0.0:8000
cd django_project/
nano settings.py 
cd ../
python manage.py runserver 0.0.0.0:8000
cd backend/
ls
tree -L 3
cd ../
tree -L 3
sudo apt update
sudo apt install -y nginx
tree -L 3
tree -L 4
tree 
tree -L 5
ls /etc
sudo nano /etc/systemd/system/gunicorn.service
sudo systemctl daemon-reload
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
sudo mkdir -p /etc/ssl/local
sudo openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/local/key.pem -out /etc/ssl/local/cert.pem -days 365 -nodes
sudo nano /etc/nginx/sites-available/django
sudo rm /etc/nginx/sites-enabled/default  # Optional, if it exists
sudo ln -s /etc/nginx/sites-available/django /etc/nginx/sites-enabled
sudo nginx -t
sudo systemctl restart nginx
ipconf
ip addr
sudo nginx -t
sudo systemctl status gunicorn
sudo systemctl stop gunicorn
sudo nano /etc/systemd/system/gunicorn.service
sudo systemctl daemon-reload
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
sudo systemctl daemon-reload
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
sudo systemctl status gunicorn
sudo nano /etc/systemd/system/gunicorn.service
sudo systemctl daemon-reload
sudo systemctl restart gunicorn
sudo systemctl status gunicorn
ls -l /home/vagrant/backend/gunicorn.sock
ls -l /etc/nginx/sites-available/django
ls -l /etc/nginx/sites-enabled/
sudo nano /etc/nginx/sites-available/django
sudo nginx -t
sudo systemctl restart nginx
exit
cd Django REST framework
Api Root
GET 
json
api
OPTIONS
Api Root
The default basic root view for DefaultRouter
GET /
HTTP 200 OK
Allow: GET, HEAD, OPTIONS
Content-Type: application/json
Vary: Accept
{     "api/users": "http://localhost:8000/api/users/",;     "api/categories": "http://localhost:8000/api/categories/",;     "api/services": "http://localhost:8000/api/services/",;     "api/orders": "http://localhost:8000/api/orders/",;     "api/payments": "http://localhost:8000/api/payments/" exit; /q; ;
nano ~/backend/django_project/settings.py
cd backend/
source venv/bin/activate
gunicorn --bind 0.0.0.0:8000 django_project.wsgi:application
sudo apt update && sudo apt upgrade -y
sudo apt install -y nginx
source venv/bin/activate
ls
cd backend/
source venv/bin/activate
pip install gunicorn
cd ../
tree
apt install tree
sudo apt install tree
tree
tree -L 3
nano ~/backend/django_project/settings.py
mkdir -p ~/backend/static ~/backend/media
python ~/backend/manage.py collectstatic
gunicorn --bind 0.0.0.0:8000 django_project.wsgi:application
cat ~/backend/django_project/settings.py
tree -L 3
cd ~/backend
gunicorn --bind 0.0.0.0:8000 django_project.wsgi:application
sudo nginx -T | grep server_name
ps aux | grep gunicorn
sudo ufw allow 80
sudo ufw allow 443
sudo ufw status
sudo netstat -tuln | grep :80
sudo apt update
sudo apt install -y net-tools
sudo netstat -tuln | grep :80
sudo systemctl status nginx
ls -l /etc/nginx/sites-enabled/
sudo nginx -T
sudo cat /etc/nginx/sites-available/django
exit
netstat -a -n -o | grep :8080
exit
sudo nano /etc/nginx/sites-available/django
sudo nginx -t
sudo systemctl restart nginx
exit
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/access.log
ls -l /etc/nginx/sites-enabled/
exit
sudo cat /etc/nginx/sites-available/django
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl status nginx
curl -v http://localhost
exit
