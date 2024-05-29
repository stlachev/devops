FROM library/postgres
ENV POSTGRES_USER=demouser
ENV POSTGRES_PASSWORD=example
ENV POSTGRES_DB=rails-app_development
ENV DATABASE_URL=postgres://demouser:example@db:5432/rails-app_development
ENV CONTENT_API_URL=http://content-api:4567/image_url.json
EXPOSE 5432
COPY init.sql /docker-entrypoint-initdb.d/
