# Домашнее задание к занятию «Введение в Terraform»

------

### Чек-лист готовности к домашнему заданию

<img width="825" height="164" alt="image" src="https://github.com/user-attachments/assets/0a69cf82-cf96-42ca-8804-6c550029c753" />

------

### Задание 1

1.
 <img width="673" height="483" alt="image" src="https://github.com/user-attachments/assets/faeccaa6-81eb-4835-a451-965c47e8c636" />
---
2. Согласно этому .gitignore, допустимо сохранить личную, секретную информацию в personal.auto.tfvars
---
3.
 <img width="1064" height="58" alt="image" src="https://github.com/user-attachments/assets/c55a42e1-2f34-4b31-89de-ae19a849f0c1" />
---
4.
<img width="885" height="265" alt="image" src="https://github.com/user-attachments/assets/2cde9d5d-d691-46bd-a05c-cc49abbcfd52" />

Первая ошибка так и описана,что не хватает 2го аргумента. Терраформ не понимает тип ли это или имя. Вторая ошибка тоже очевидна - имя не может начинаться с цифры.

<img width="813" height="136" alt="image" src="https://github.com/user-attachments/assets/d3eea7d5-9a33-45e6-a04c-ad484c6702bb" />

При повторной проверке вылезла новая ошибка. Убрать _FAKE -так как это меняет имя ресурса,а такого ресурса нет,и опечатку в слове resulT
---
5. 
<img width="1094" height="649" alt="image" src="https://github.com/user-attachments/assets/bf0c6a1f-f3b3-45e0-86f8-b960b357df96" />
---
6.
<img width="1029" height="172" alt="image" src="https://github.com/user-attachments/assets/56c8e0e6-30f3-4734-81ef-21d8422e7f9b" />

Может быть опасность применения ключа  ```-auto-approve``` в отсутствии контроля,ведь он дословно переводится как "автоматически соглашаться". Этот ключ можно применять только в тестовой или учебной среде или же после проверки плана. Ну или если уверены в себе на 100 процентов. Удобен тем,что не надо каждый раз подтверждать изменения.
---
7. 
<img width="701" height="172" alt="image" src="https://github.com/user-attachments/assets/9b1d9458-3784-4e83-bdde-91269698de0e" />
---
8. keep_locally = true - вот почему не был удален образ, а также «If true, the image will not be removed when the resource is destroyed.»
