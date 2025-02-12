### Чек-лист готовности к домашнему заданию
Проверяем наличие Terraform в системе:

![изображение](https://github.com/user-attachments/assets/462e6b45-d99b-49e9-98ba-4bb5084f03aa)

## Задание 1
2. Согласно файлу .gitignore допускается хранить секретные данные в файле personal.auto.tfvarsфайле.

3. Инициализируем каталог командой ```terrafrom init```, выполняем код и получаем файл ```terraform.tfstate```. Находим в нем секретные данные:
![изображение](https://github.com/user-attachments/assets/25120e8a-a3c3-4a40-86ce-594556781ec7)

4. Раскомментируем блок кода в файла main.tf. Проверяем командой ```terraform validate``` и видим ошибки:
   
      a. Название блока должно содержать 2 значения.
   
      b. Имя ```1nginx``` должно начмнать с буквы.
  
      c. Лишние символы в строке и заглавная буква.

![Снимок экрана от 2025-01-27 16-26-12](https://github.com/user-attachments/assets/619e865c-f214-44d3-815c-40cfb10f89dd)

5. Исправляем код:
```   
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"
```
и получаем:

![изображение](https://github.com/user-attachments/assets/916ce30b-1554-42a2-a310-5a252dfa3859)

6. Меняем имя контейнера на ```hello_world``` 
```   
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "hello_world"
```
с помощью ```terraform apply -auto-approve```  получаем:

![изображение](https://github.com/user-attachments/assets/abc80e2a-bb26-4056-b791-a5e11b4bd567)

Ключ ```-auto-approve``` отключает режим подтверждения изменений. Что грозит удалением инфраструктуры или применением изменений на лету. Допустим на тестовых сценариях.

7. Уничтожьте созданные ресурсы с помощью ```terraform destroy```. Содержимое файла terraform.tfstate:

   ![изображение](https://github.com/user-attachments/assets/1179dfa4-5653-4573-8dad-fa873dbd6da7)

9. docker-образ nginx:latest не был удалён из-за строчки кода```keep_locally = true```

![image](https://github.com/user-attachments/assets/8b5ccd94-d30d-4765-989a-631a59ca09b1)


## Задание 2*
1. Создаем в облаке ВМ.
2. Подключаемся к ВМ, настраиваем remote docker context:
  
   ![Снимок экрана от 2025-01-28 10-58-21](https://github.com/user-attachments/assets/64a3688f-ef2d-4bcc-ab1f-2b31ef59eb9f)

  Не получилось прикрутить переменные для MYSQL :(

## Задание 3*
1. Установливаем opentofu (v1.9.0). Создаем ```.tofurc``` и добавляем в коде: ```source = "registry.terraform.io/XXX```

2. Запускаем код с помощью ```tofu apply```.

   ![изображение](https://github.com/user-attachments/assets/c9530441-8349-49ee-95fe-1e0a971f68c1)

Проверяем наличие контейнера:

![изображение](https://github.com/user-attachments/assets/2c16d6b9-f712-4a6d-ac81-8ee0bd84412f)


