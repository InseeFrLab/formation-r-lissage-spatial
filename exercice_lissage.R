install.packages("sf")
install.packages("aws.s3", repos = "https://cloud.R-project.org")

Sys.setenv("AWS_ACCESS_KEY_ID" = "MM690I86ANS6YV24IPF4",
           "AWS_SECRET_ACCESS_KEY" = "ANFRLRYHopd388Tsd8KTbC5PQgFosMFOVe3xzV9u",
           "AWS_DEFAULT_REGION" = "us-east-1",
           "AWS_SESSION_TOKEN" = "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJhY2Nlc3NLZXkiOiJNTTY5MEk4NkFOUzZZVjI0SVBGNCIsImFjciI6IjAiLCJhbGxvd2VkLW9yaWdpbnMiOlsiKiJdLCJhdWQiOlsibWluaW8tZGF0YW5vZGUiLCJvbnl4aWEiLCJhY2NvdW50Il0sImF1dGhfdGltZSI6MTY0MjYwMTI1OCwiYXpwIjoib255eGlhIiwiZW1haWwiOiJqdWxpZW4ucHJhbWlsQGluc2VlLmZyIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImV4cCI6MTY0MzIwNjA1OCwiZmFtaWx5X25hbWUiOiJQUkFNSUwiLCJnaXZlbl9uYW1lIjoiSnVsaWVuIiwiZ3JvdXBzIjpbXSwiaWF0IjoxNjQyNjAxMjYwLCJpc3MiOiJodHRwczovL2F1dGgubGFiLnNzcGNsb3VkLmZyL2F1dGgvcmVhbG1zL3NzcGNsb3VkIiwianRpIjoiNGJhNzRhY2MtODg2OS00MTdhLTk3N2EtYmQxNmM1Nzk0MDNiIiwibG9jYWxlIjoiZW4iLCJuYW1lIjoiSnVsaWVuIFBSQU1JTCIsIm5vbmNlIjoiNjU5YjFjMGItMjVjMy00Mjg5LTg1ZjEtMGZmNDVhMmMzMjIxIiwicG9saWN5Ijoic3Rzb25seSIsInByZWZlcnJlZF91c2VybmFtZSI6ImpwcmFtaWwiLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiIsImRlZmF1bHQtcm9sZXMtc3NwY2xvdWQiXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6Im9wZW5pZCBwcm9maWxlIGdyb3VwcyBlbWFpbCIsInNlc3Npb25fc3RhdGUiOiJmNGQ3N2ZjYi00MGNjLTQ1ZWUtOGQ2Yy00MDMyZTdiOTFmMDMiLCJzaWQiOiJmNGQ3N2ZjYi00MGNjLTQ1ZWUtOGQ2Yy00MDMyZTdiOTFmMDMiLCJzdWIiOiI3MzNiNDhkNi04NWFjLTQyZDQtYjQ3NS0zY2U5MDJlMjEyMTYiLCJ0eXAiOiJCZWFyZXIifQ.nVdKp-e-Gl1Py04lh7d-rIKdXpD_ZgO6rRFTwbHSaO81SdXDCltQJXzzALVlE-JjSz-0xevc3dVMI7FSCvDejg",
           "AWS_S3_ENDPOINT"= "minio.lab.sspcloud.fr")

library("aws.s3")
bucketlist(region="")

sfBordeauxCentre <- 
  aws.s3::s3read_using(
    FUN = sf::st_read,
    object = "bordeaux_centre.gpkg",
    bucket = "jpramil"
    ,
    opts = list("region" = "")
  )

dfParkings <- 
  aws.s3::s3read_using(
    FUN = base::readRDS,
    object = "parking.RDS",
    bucket = "jpramil"
    ,
    opts = list("region" = "")
  )

