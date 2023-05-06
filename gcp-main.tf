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