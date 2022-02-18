### 1)
```
Google Cloud SDK 369.0.0
alpha 2022.01.14
beta 2022.01.14
bq 2.0.72
core 2022.01.14
gsutil 5.6
minikube 1.24.0
skaffold 1.35.1
```

### 2)
```
var.project
  Your GCP Project ID - dtc-de-338713

  Enter a value: dtc-de-338713


Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_bigquery_dataset.dataset will be created
  + resource "google_bigquery_dataset" "dataset" {
      + creation_time              = (known after apply)
      + dataset_id                 = "trips_data_all"
      + delete_contents_on_destroy = false
      + etag                       = (known after apply)
      + id                         = (known after apply)
      + last_modified_time         = (known after apply)
      + location                   = "europe-west1"
      + project                    = "dtc-de-338713"
      + self_link                  = (known after apply)

      + access {
          + domain         = (known after apply)
          + group_by_email = (known after apply)
          + role           = (known after apply)
          + special_group  = (known after apply)
          + user_by_email  = (known after apply)

          + view {
              + dataset_id = (known after apply)
              + project_id = (known after apply)
              + table_id   = (known after apply)
            }
        }
    }

  # google_storage_bucket.data-lake-bucket will be created
  + resource "google_storage_bucket" "data-lake-bucket" {
      + force_destroy               = true
      + id                          = (known after apply)
      + location                    = "EUROPE-WEST1"
      + name                        = "dtc_data_lake_dtc-de-338713"
      + project                     = (known after apply)
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + uniform_bucket_level_access = true
      + url                         = (known after apply)

      + lifecycle_rule {
          + action {
              + type = "Delete"
            }

          + condition {
              + age                   = 30
              + matches_storage_class = []
              + with_state            = (known after apply)
            }
        }

      + versioning {
          + enabled = true
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_bigquery_dataset.dataset: Creating...
google_storage_bucket.data-lake-bucket: Creating...
google_bigquery_dataset.dataset: Creation complete after 1s [id=projects/dtc-de-338713/datasets/trips_data_all]
google_storage_bucket.data-lake-bucket: Creation complete after 1s [id=dtc_data_lake_dtc-de-338713]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```


### 3)
```
select count(*) as trips_count
from yellow_taxi_data
where date(tpep_pickup_datetime) = '2021-01-15'
```

### 4)
```
select date(tpep_pickup_datetime) as date, max(Tip_amount) as max_tip_amount
from yellow_taxi_data
group by 1
order by 2 desc
limit 1
```

### 5)
```
select coalesce(c."Zone",'Unknown') as zone, count(*) as trips_count
from yellow_taxi_data as a
left join zones as b on a."PULocationID" = b."LocationID"
left join zones as c on a."DOLocationID" = c."LocationID"
where date(tpep_pickup_datetime) = '2021-01-14'
and lower(b."Zone") = 'central park'
group by 1
order by 2 desc
limit 1
```

### 6)
```
select concat(b."Zone",' / ',coalesce(c."Zone",'Unknown')) as route, avg(total_amount) as total_amount
from yellow_taxi_data as a
left join zones as b on a."PULocationID" = b."LocationID"
left join zones as c on a."DOLocationID" = c."LocationID"
group by 1
order by 2 desc
limit 1
```

### 7)
https://github.com/dl-ao/de-course.git
