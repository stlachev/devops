# Example (AWS/Azure)
 
 * Docker containers ware build and pushed
 * Kubernetes used for deployments, services etc.
 * Terraform used for infrastructure
 * Helm used for final deployment as was specified from Kubernetes


Start point was [Multi-container demo application](https://github.com/ministryofjustice/cloud-platform-multi-container-demo-app.git)

The components are:

* An API server
* A Postgres database
* A worker process which periodically updates the database
* A Ruby on Rails application which serves content from the database, and also data returned by the API

Each of these components runs in its own container. The Ruby on Rails application reads a record from the database and displays its contents, along with an image supplied via the content API. The worker process periodically updates the database record, and the content API responds to requests (with the URL of a random cat image).

![Architecture Diagram](https://raw.githubusercontent.com/ministryofjustice/cloud-platform-multi-container-demo-app/main/docs/architecture-diagram.png)

After the application is started, visit `http://localhost:3000` in your browser, and you should see something similar to this:

![Screenshot](https://raw.githubusercontent.com/ministryofjustice/cloud-platform-multi-container-demo-app/main/docs/screenshot.png)

If you refresh the page, you should see a different cat picture (the URL of which the rails-app fetches from the content-api component).

Every ten seconds, the displayed message should change (you will need to refresh the browser to see the change), when the worker updates the information in the database.

