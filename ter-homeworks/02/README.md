# Домашнее задание к занятию «Основы Terraform. Yandex Cloud»

------

### Задание 1
1. Опечатка в platform_id = "standart-v4"
Должно быть: "standard-v4" (standard, а не standart).
2. Отсутствие ресурса
  zone = var.default_zone

preemptible = true
Создаёт прерываемую (spot) ВМ, которая стоит до 4 раз дешевле обычной.
1. Полезно для обучения: можно экспериментировать без больших затрат.
2. Минус: ВМ может быть остановлена системой через 24 часа или раньше при нехватке ресурсов — не подходит для продакшена, но идеальна для лабораторных работ.

core_fraction = 5
Ограничивает гарантированную долю CPU до 5% от ядра (минимальное значение).
1. Позволяет снизить стоимость ВМ при низкой нагрузке (например, просто поднять сервер и посмотреть логи).
2. Для учебных задач (SSH, curl, базовые команды) этого более чем достаточно.
3. Не подходит для CPU-нагруженных задач (компиляция, ML), но отлично для знакомства с инфраструктурой.

<img width="1798" height="267" alt="image" src="https://github.com/user-attachments/assets/f1ae9ad7-4c81-4220-afff-b424ad7ef4b6" />

<img width="1799" height="384" alt="image" src="https://github.com/user-attachments/assets/cb455937-73d9-437d-9cae-6c88d6b4525b" />

<img width="1063" height="467" alt="image" src="https://github.com/user-attachments/assets/2edb2dac-d5c8-4f5f-9789-d8f310c19516" />


### Задание 2

1.
<img width="595" height="863" alt="image" src="https://github.com/user-attachments/assets/132476d5-0850-4dd9-bd16-9d9d72cb0fdb" />


2. 

<img width="602" height="498" alt="image" src="https://github.com/user-attachments/assets/c423b08c-3a78-44a6-b41e-32ae63b97a4c" />


### Задание 3

1. 
<img width="661" height="871" alt="image" src="https://github.com/user-attachments/assets/ea7a9935-499e-4a2a-9231-ec8fabf3b094" />

<img width="549" height="753" alt="image" src="https://github.com/user-attachments/assets/92a55860-b820-48a0-9ae4-b4ec6b9e2ab6" />

<img width="543" height="265" alt="image" src="https://github.com/user-attachments/assets/324c97d2-2ab5-4a17-906a-b3bf39bd4767" />

2. 
<img width="560" height="836" alt="image" src="https://github.com/user-attachments/assets/3afe036a-a701-456f-9e7f-706fdf850f68" />

<img width="531" height="836" alt="image" src="https://github.com/user-attachments/assets/86e3b31c-de31-46ba-9d60-110c1f9e25e5" />

3.
<img width="356" height="569" alt="image" src="https://github.com/user-attachments/assets/1c67f49c-4f11-450f-96c3-f3cefbb45c3b" />

4. 
<img width="442" height="888" alt="image" src="https://github.com/user-attachments/assets/792459c4-ddc9-4571-a906-57f3d2132fa4" />

### Задание 4

<img width="738" height="224" alt="image" src="https://github.com/user-attachments/assets/7dbee023-a363-4743-ab63-3766fe1b214e" />



### Задание 5

<img width="605" height="201" alt="image" src="https://github.com/user-attachments/assets/c684e5fd-c277-4033-8270-0aa6c714caeb" />

<img width="440" height="228" alt="image" src="https://github.com/user-attachments/assets/b7767721-acbc-45c4-a5a9-1b2034b747c4" />

<img width="597" height="212" alt="image" src="https://github.com/user-attachments/assets/35edd8b4-986b-4cf9-acdb-231f1097cf8c" />


### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map(object).  
   ```
   пример из terraform.tfvars:
   vms_resources = {
     web={
       cores=2
       memory=2
       core_fraction=5
       hdd_size=10
       hdd_type="network-hdd"
       ...
     },
     db= {
       cores=2
       memory=4
       core_fraction=20
       hdd_size=10
       hdd_type="network-ssd"
       ...
     }
   }
   ```
3. Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.
   ```
   пример из terraform.tfvars:
   metadata = {
     serial-port-enable = 1
     ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
   }
   ```  
  
5. Найдите и закоментируйте все, более не используемые переменные проекта.
6. Проверьте terraform plan. Изменений быть не должно.

------

## Дополнительное задание (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.**   
Они помогут глубже разобраться в материале. Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 


------
### Задание 7*

Изучите содержимое файла console.tf. Откройте terraform console, выполните следующие задания: 

1. Напишите, какой командой можно отобразить **второй** элемент списка test_list.
2. Найдите длину списка test_list с помощью функции length(<имя переменной>).
3. Напишите, какой командой можно отобразить значение ключа admin из map test_map.
4. Напишите interpolation-выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.

**Примечание**: если не догадаетесь как вычленить слово "admin", погуглите: "terraform get keys of map"

В качестве решения предоставьте необходимые команды и их вывод.

------

### Задание 8*
1. Напишите и проверьте переменную test и полное описание ее type в соответствии со значением из terraform.tfvars:
```
test = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]
```
2. Напишите выражение в terraform console, которое позволит вычленить строку "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117" из этой переменной.
------

------

### Задание 9*

Используя инструкцию https://cloud.yandex.ru/ru/docs/vpc/operations/create-nat-gateway#tf_1, настройте для ваших ВМ nat_gateway. Для проверки уберите внешний IP адрес (nat=false) у ваших ВМ и проверьте доступ в интернет с ВМ, подключившись к ней через serial console. Для подключения предварительно через ssh измените пароль пользователя: ```sudo passwd ubuntu```

### Правила приёма работыДля подключения предварительно через ssh измените пароль пользователя: sudo passwd ubuntu
В качестве результата прикрепите ссылку на MD файл с описанием выполненой работы в вашем репозитории. Так же в репозитории должен присутсвовать ваш финальный код проекта.

**Важно. Удалите все созданные ресурсы**.


### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 

