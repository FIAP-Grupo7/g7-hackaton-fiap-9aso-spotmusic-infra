resource "google_artifact_registry_repository" "frontend-repo" {
  location = var.region
  repository_id = "frontend"
  description = "Frontend Imagens Docker"
  format = "DOCKER"
}

resource "google_artifact_registry_repository" "backend-repo" {
  location = var.region
  repository_id = "backend"
  description = " Backend Imagens Docker"
  format = "DOCKER"
}

resource "google_sql_database_instance" "main" {
  name             = "main-instance"
  database_version = "MYSQL_8_0"
  region           = var.region

  settings {
    tier = "db-f1-micro"
  }
}

data "google_secret_manager_secret_version" "mysql_password" {
 secret   = "MYSQL_PASSWORD"
}

resource "google_sql_user" "users" {
  name     = "playuser"
  instance = google_sql_database_instance.main.name
  password = data.google_secret_manager_secret_version.mysql_password.secret_data
}