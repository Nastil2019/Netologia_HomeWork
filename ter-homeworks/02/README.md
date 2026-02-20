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

<img width="722" height="280" alt="image" src="https://github.com/user-attachments/assets/11e004c5-e1ed-4fac-8cf9-7c7b18c82870" />


------

## Дополнительное задание (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.**   
Они помогут глубже разобраться в материале. Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 


------
### Задание 7*

<img width="1597" height="327" alt="image" src="https://github.com/user-attachments/assets/4adfdf5f-29f7-4a65-932d-73fe19486e47" />


------
### Задание 8*

<img width="885" height="367" alt="image" src="https://github.com/user-attachments/assets/d16b7e21-e93a-4017-8e2d-d4f872c88b4d" />





