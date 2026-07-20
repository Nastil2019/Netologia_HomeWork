# 1. Симметричный ключ KMS
resource "yandex_kms_symmetric_key" "storage_key" {
  name              = "storage-encryption-key"
  description       = "KMS key for encrypting Object Storage bucket"
  default_algorithm = "AES_256"
}

# 2. право на ключ
resource "yandex_resourcemanager_folder_iam_member" "sa_kms_encrypter" {
  folder_id = var.yc_folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}