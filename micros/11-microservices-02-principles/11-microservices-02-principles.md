
# Домашнее задание к занятию «Микросервисы: принципы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.

## Задача 1: API Gateway 

| Решение | Маршрутизация запросов | Проверка при аутентификации | Терминация HTTPS | Производительность | Сложность настройки |
|:---:|:---:|:---:|:---:|:---:|:---:|
| Apache APISIX | Да | Да | Да | ++++ | +++ |
| Azure API Gateway | Да | Да | Да | ++++ | +++ |
| Envoy | Да | Да | Да | +++++ | ++++ |
| Kong | Да | Да | Да | ++++ | +++ |
| Traefik | Да | Да | Да | ++++ | ++ |
| NGINX Plus | Да | Да | Да | +++++ | ++ |

Выбор: NGINX
Обоснование:
Он соответствует главным требованиям: маршрутизация(location + proxy_pass в конфиге), аутентификация(auth_request + внешний сервис или Lua-скрипты), HTTPS(встроенная поддержка SSL, Let's Encrypt). Его преимущества, что минимальные расходы, легко версионировать, проверен в продакшене десятилетиями, можно расширять.
Альтернативы не выбраны потому что:
 - Kong избыточен для локальной разработки, требует PostgreSQL/Redis
 - Traefik идеален для Kubernetes, но сложнее для ручного конфига
 - Envoy мощно, но высокий порог входа (xDS, complex config)
 - APISIX: молодой проект, меньше документации на русском
---
## Задача 2: Брокер сообщений

|Критерий | RabbitMQ | Apache Kafka | NATS | Redis Streams | Apache Pulsar|
|:---:|:---:|:---:|:---:|:---:|:---:|
| Кластеризация | Mirrored Queues / Quorum | Native (KRaft/ZooKeeper) | NATS JetStream | Sentinel/Cluster | Native |
| Хранение на диске | Persistent queues | Log-based storage | JetStream File Store | AOF/RDB | Tiered Storage |
| Скорость | ⭐⭐⭐⭐ (10-50K msg/s) | ⭐⭐⭐⭐⭐ (1M+ msg/s) | ⭐⭐⭐⭐⭐ (in-memory) | ⭐⭐⭐⭐⭐ (in-memory) | ⭐⭐⭐⭐⭐|
|Форматы сообщений | ✅ Любой (binary/JSON/XML) | ✅ Любой (binary) | ✅ Любой | ✅ Любой | ✅ Любой
|Разделение прав (RBAC) | ✅ Vhosts + Users + Permissions | ✅ ACL + SASL | ✅ Users + Permissions | ⚠️ Limited (AUTH) | ✅ Tenants + Roles|
|Простота эксплуатации | ⭐⭐⭐⭐ | ⭐⭐ (сложный) | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐|
|Протоколы | "AMQP 0.9.1 |  MQTT |  STOMP" | Kafka Protocol | "NATS |  JetStream" | RESP | "Pulsar Protocol |  Kafka-compatible"|
|Сообщество | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐|
|Лицензия | MPL 2.0 / Commercial | Apache 2.0 | Apache 2.0 | BSD 3-clause | Apache 2.0|
###
## Задача 3: API Gateway * (необязательная)

### Есть три сервиса:

**minio**
- хранит загруженные файлы в бакете images,
- S3 протокол,

**uploader**
- принимает файл, если картинка сжимает и загружает его в minio,
- POST /v1/upload,

**security**
- регистрация пользователя POST /v1/user,
- получение информации о пользователе GET /v1/user,
- логин пользователя POST /v1/token,
- проверка токена GET /v1/token/validation.

### Необходимо воспользоваться любым балансировщиком и сделать API Gateway:

**POST /v1/register**
1. Анонимный доступ.
2. Запрос направляется в сервис security POST /v1/user.

**POST /v1/token**
1. Анонимный доступ.
2. Запрос направляется в сервис security POST /v1/token.

**GET /v1/user**
1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис security GET /v1/user.

**POST /v1/upload**
1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис uploader POST /v1/upload.

**GET /v1/user/{image}**
1. Проверка токена. Токен ожидается в заголовке Authorization. Токен проверяется через вызов сервиса security GET /v1/token/validation/.
2. Запрос направляется в сервис minio GET /images/{image}.

### Ожидаемый результат

Результатом выполнения задачи должен быть docker compose файл, запустив который можно локально выполнить следующие команды с успешным результатом.
Предполагается, что для реализации API Gateway будет написан конфиг для NGinx или другого балансировщика нагрузки, который будет запущен как сервис через docker-compose и будет обеспечивать балансировку и проверку аутентификации входящих запросов.
Авторизация
curl -X POST -H 'Content-Type: application/json' -d '{"login":"bob", "password":"qwe123"}' http://localhost/token

**Загрузка файла**

curl -X POST -H 'Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJib2IifQ.hiMVLmssoTsy1MqbmIoviDeFPvo-nCd92d4UFiN2O2I' -H 'Content-Type: octet/stream' --data-binary @yourfilename.jpg http://localhost/upload

**Получение файла**
curl -X GET http://localhost/images/4e6df220-295e-4231-82bc-45e4b1484430.jpg

---

#### [Дополнительные материалы: как запускать, как тестировать, как проверить](https://github.com/netology-code/devkub-homeworks/tree/main/11-microservices-02-principles)

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
