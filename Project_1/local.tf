
/* Grabbing the user names from the users.csv file and 
storing them in a local variable */

locals {
  users = csvdecode(file("users.csv"))
}