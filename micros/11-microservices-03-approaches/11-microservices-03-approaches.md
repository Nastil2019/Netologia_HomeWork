# Домашнее задание к занятию «Микросервисы: подходы»

Вы работаете в крупной компании, которая строит систему на основе микросервисной архитектуры.
Вам как DevOps-специалисту необходимо выдвинуть предложение по организации инфраструктуры для разработки и эксплуатации.


## Задача 1: Обеспечить разработку

| Критерий | GitHub Actions | GitLab CI/CD | Yandex Cloud CI/CD |
|:---:|:---:|:---:|:---:|
| Облачная система |  GitHub Cloud |  GitLab.com | Yandex Cloud |
| Git VCS |  Native |  Native |  Plugin |
| Репозиторий на сервис |  + | + | + | + | + |
| Сборка по событию |  push/pull_request |  |  Plugin |  VCS Root | |
| Manual trigger with params |  workflow_dispatch + inputs |  Manual + variables |  Parameters |  Build parameters |  Manual + params|
| Build-specific settings | " env |  secrets |  matrix" |  Variables per job |  Parameters |  Configuration parameters |  Contexts|
| Reusable templates |  reusable workflows |  includes/templates |  Shared libraries |  Templates/Kotlin DSL |  Orbs|
| Secrets management |  Encrypted secrets + OIDC |  CI/CD variables (masked) |  Credentials plugin |  Passwords/credentials |  Context secrets|
| Multiple configs per repo |  workflows/ + matrix |  .gitlab-ci.yml stages |  Multibranch pipeline |  Build configurations |  Workflows|
| Custom build steps |  run + actions marketplace |  script + custom images |  Any shell/plugin |  Build runners |  Steps + orbs|
| Custom Docker build images |  container: + build-push |  image: + docker executor |  Docker plugin |  Docker build step |  Docker executor|
| Self-hosted runners |  self-hosted runners |  self-hosted runners |  Master/agents |  Build agents |  Self-hosted runners|
| Parallel builds |  matrix + jobs |  parallel: + needs |  parallelStage |  Parallel steps |  parallel: true|
| Parallel tests |  matrix + services |  parallel + artifacts |  parallelTest |  Parallel configurations |  parallel: true|
| Pricing (free tier) |  2000 min/mo public |  400 min/mo |  Open source | ❌ Limited free |  2500 credits/mo|

## Задача 2: Логи

Предложите решение для обеспечения сбора и анализа логов сервисов в микросервисной архитектуре.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- сбор логов в центральное хранилище со всех хостов, обслуживающих систему;
- минимальные требования к приложениям, сбор логов из stdout;
- гарантированная доставка логов до центрального хранилища;
- обеспечение поиска и фильтрации по записям логов;
- обеспечение пользовательского интерфейса с возможностью предоставления доступа разработчикам для поиска по записям логов;
- возможность дать ссылку на сохранённый поиск по записям логов.

Обоснуйте свой выбор.

## Задача 3: Мониторинг

Предложите решение для обеспечения сбора и анализа состояния хостов и сервисов в микросервисной архитектуре.
Решение может состоять из одного или нескольких программных продуктов и должно описывать способы и принципы их взаимодействия.

Решение должно соответствовать следующим требованиям:
- сбор метрик со всех хостов, обслуживающих систему;
- сбор метрик состояния ресурсов хостов: CPU, RAM, HDD, Network;
- сбор метрик потребляемых ресурсов для каждого сервиса: CPU, RAM, HDD, Network;
- сбор метрик, специфичных для каждого сервиса;
- пользовательский интерфейс с возможностью делать запросы и агрегировать информацию;
- пользовательский интерфейс с возможностью настраивать различные панели для отслеживания состояния системы.

Обоснуйте свой выбор.

## Задача 4: Логи * (необязательная)

Продолжить работу по задаче API Gateway: сервисы, используемые в задаче, пишут логи в stdout. 

Добавить в систему сервисы для сбора логов Vector + ElasticSearch + Kibana со всех сервисов, обеспечивающих работу API.

### Результат выполнения: 

docker compose файл, запустив который можно перейти по адресу http://localhost:8081, по которому доступна Kibana.
Логин в Kibana должен быть admin, пароль qwerty123456.


## Задача 5: Мониторинг * (необязательная)

Продолжить работу по задаче API Gateway: сервисы, используемые в задаче, предоставляют набор метрик в формате prometheus:

- сервис security по адресу /metrics,
- сервис uploader по адресу /metrics,
- сервис storage (minio) по адресу /minio/v2/metrics/cluster.

Добавить в систему сервисы для сбора метрик (Prometheus и Grafana) со всех сервисов, обеспечивающих работу API.
Построить в Graphana dashboard, показывающий распределение запросов по сервисам.

### Результат выполнения: 

docker compose файл, запустив который можно перейти по адресу http://localhost:8081, по которому доступна Grafana с настроенным Dashboard.
Логин в Grafana должен быть admin, пароль qwerty123456.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
