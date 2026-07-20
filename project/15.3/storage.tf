resource "yandex_iam_service_account" "sa" {
  name        = "ig-storage-sa"
  description = "Service account for Instance Group and Storage"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_storage" {
  folder_id = var.yc_folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_compute" {
  folder_id = var.yc_folder_id
  role      = "compute.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_vpc_public" {
  folder_id = var.yc_folder_id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_vpc_user" {
  folder_id = var.yc_folder_id
  role      = "vpc.user"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "sa_admin" {
  folder_id = var.yc_folder_id
  role      = "admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
} 
resource "yandex_iam_service_account_static_access_key" "sa_keys" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "Static access keys for Object Storage"
}

resource "yandex_storage_bucket" "bucket" {
  bucket     = var.bucket_name
  access_key = yandex_iam_service_account_static_access_key.sa_keys.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_keys.secret_key
  acl        = "public-read"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.storage_key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  depends_on = [
    yandex_resourcemanager_folder_iam_member.sa_storage,
    yandex_resourcemanager_folder_iam_member.sa_kms_encrypter # <-- ДОБАВЛЕНО
  ]
}

resource "yandex_storage_object" "image" {
  bucket       = yandex_storage_bucket.bucket.id
  access_key   = yandex_iam_service_account_static_access_key.sa_keys.access_key
  secret_key   = yandex_iam_service_account_static_access_key.sa_keys.secret_key
  key          = "image.jpg"
  source       = "${path.module}/image.jpg"
  acl          = "public-read"
  content_type = "image/jpeg"

  depends_on = [yandex_storage_bucket.bucket]
}