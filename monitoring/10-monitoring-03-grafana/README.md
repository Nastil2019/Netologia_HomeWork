# Домашнее задание к занятию 14 «Средство визуализации Grafana»


## Обязательные задания

### Задание 1

1. 
<img width="513" height="1029" alt="image" src="https://github.com/user-attachments/assets/c3111e78-2fb7-43f5-b312-7d803439d1a8" />

2. 
<img width="1895" height="1117" alt="image" src="https://github.com/user-attachments/assets/03f68da5-b3ef-4fc4-8eb9-da4b29bc5979" />

3.
<img width="1297" height="468" alt="image" src="https://github.com/user-attachments/assets/501c4d59-f778-4c4f-9cd4-40539c98c23a" />


## Задание 2

Изучите самостоятельно ресурсы:

1. [PromQL tutorial for beginners and humans](https://valyala.medium.com/promql-tutorial-for-beginners-9ab455142085).
1. [Understanding Machine CPU usage](https://www.robustperception.io/understanding-machine-cpu-usage).
1. [Introduction to PromQL, the Prometheus query language](https://grafana.com/blog/2020/02/04/introduction-to-promql-the-prometheus-query-language/).

Создайте Dashboard и в ней создайте Panels:

- утилизация CPU для nodeexporter (в процентах, 100-idle);
- CPULA 1/5/15;
- количество свободной оперативной памяти;
- количество места на файловой системе.

Для решения этого задания приведите promql-запросы для выдачи этих метрик, а также скриншот получившейся Dashboard.

## Задание 3

1. Создайте для каждой Dashboard подходящее правило alert — можно обратиться к первой лекции в блоке «Мониторинг».
1. В качестве решения задания приведите скриншот вашей итоговой Dashboard.

## Задание 4

1. Сохраните ваш Dashboard.Для этого перейдите в настройки Dashboard, выберите в боковом меню «JSON MODEL». Далее скопируйте отображаемое json-содержимое в отдельный файл и сохраните его.
1. В качестве решения задания приведите листинг этого файла.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
