resource "aws_ecr_repository" "patient_service" {
  name = "patient-service-repository"

  tags = {
    Name = "patient-service-repository"
  }
}

resource "aws_ecr_repository" "appointment_service" {
  name = "appointment-service-repository"

  tags = {
    Name = "appointment-service-repository"
  }
}
