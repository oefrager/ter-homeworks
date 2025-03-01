# Домашнее задание к занятию «Продвинутые методы работы с Terraform»

### Задание 1

1. Создаем с помощью двух вызовов remote-модуля -> две ВМ, относящихся к разным проектам (marketing и analytics) используйте labels для обозначения принадлежности [main.tf](main.tf).  В файле cloud-init.yml используем переменную для ssh-ключа вместо хардкода. Передаем ssh-ключ в функцию template_file в блоке vars ={}: [userdata.tf](userdata.tf)


2. Добавляем в файл [cloud-init.yml](cloud-init.yml) установку nginx.
3. Предоставьте скриншот подключения к консоли и вывод команды ```sudo nginx -t```, скриншот консоли ВМ yandex cloud с их метками. Откройте terraform console и предоставьте скриншот содержимого модуля. Пример: > module.marketing_vm

   ![image](https://github.com/user-attachments/assets/16a089b2-bae3-4d7a-b417-be5df2a6fefd)

   ![image](https://github.com/user-attachments/assets/e37ecb09-9890-4bd6-b2ad-29f59b7840e8)      ![image](https://github.com/user-attachments/assets/63bc87f0-da8a-4ea8-af4a-ec1ecb98c263)

   ![image](https://github.com/user-attachments/assets/5cf4170a-fddc-43f4-b4a1-30f1566cf954)


### Задание 2

1. Пишем локальный модуль vpc, который будет создавать 2 ресурса: **одну** сеть и **одну** подсеть в зоне, объявленной при вызове модуля, например: ```ru-central1-a```:
         Для этого создаем в каталоге module/vpc файл [main.tf](vpc/main.tf)

2. Передаем в модуль [переменные](vpc/variables.tf) с названием сети, zone и v4_cidr_blocks.
3. Модуль должен возвращать в root module с помощью [output](vpc/output.tf) информацию о yandex_vpc_subnet. Пришлите скриншот информации из terraform console о своем модуле. Пример: > module.vpc_dev  

      ![image](https://github.com/user-attachments/assets/294a9b3b-5d8e-4c0b-9fd1-6b447cfe2dc0)

4. Замените ресурсы yandex_vpc_network и yandex_vpc_subnet созданным модулем. Не забудьте передать необходимые параметры сети из модуля vpc в модуль с виртуальной машиной.

      ![image](https://github.com/user-attachments/assets/707ac88e-7593-4985-8d8e-6f267adc5eae)

5. Генерируем документацию к модулю с помощью terraform-docs: "terraform-docs markdown table . --output-file README.md": [README.md](vpc/README.md)

### Задание 3
1. Выведите список ресурсов в стейте.

      ![изображение](https://github.com/user-attachments/assets/677f70cb-05bb-4b83-9b38-99a6018cf490)

2. Полностью удалите из стейта модуль vpc.
3. Полностью удалите из стейта модуль vm.

      ![изображение](https://github.com/user-attachments/assets/2a582da2-57e8-462e-8fc7-5323caddeaac)


4. Импортируйте всё обратно. Проверьте terraform plan. Значимых(!!) изменений быть не должно.

      ![изображение](https://github.com/user-attachments/assets/74fec860-d4e5-4ced-9b81-d3981cffc747)

      ![изображение](https://github.com/user-attachments/assets/172ca05f-61b1-403b-8cc3-ba015314eac2)
      
      ![изображение](https://github.com/user-attachments/assets/1bc665ca-d888-4f95-98e5-13ab429e321e)

---------------------

### Задание 4*

1. Измените модуль vpc так, чтобы он мог создать подсети во всех зонах доступности, переданных в переменной типа list(object) при вызове модуля.
  
Пример вызова
```
module "vpc_prod" {
  source       = "./vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}
```

Получаем следующий [код](vpc_subnets) и результат из консоли YC:

   ![изображение](https://github.com/user-attachments/assets/548425e2-92b1-443d-a09f-34756deccb64)

   ![изображение](https://github.com/user-attachments/assets/ff1dc7e4-7713-43ba-88d9-b4fda2aaf432)

