echo "Starting Hospitium..."
service postgres start;
su - postgres;
cd /usr/src/app;
su postgres -c 'bundle exec rails server Puma -b 0.0.0.0 -p 3000;'
