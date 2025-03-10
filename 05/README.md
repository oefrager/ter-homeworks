# Домашнее задание к занятию «Использование Terraform в команде»

------

### Задание 1

1. Возьмите код:
- из [ДЗ к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/src),
- из [демо к лекции 4](https://github.com/netology-code/ter-homeworks/tree/main/04/demonstration1).
2. Проверьте код с помощью tflint и checkov. Вам не нужно инициализировать этот проект.
3. Перечислите, какие **типы** ошибок обнаружены в проекте (без дублей).

Запускаем проверку:
        
        docker run --rm -v "$(pwd):/tflint" ghcr.io/terraform-linters/tflint --chdir /tflint
        docker run --rm --tty --volume $(pwd):/tf --workdir /tf bridgecrew/checkov --download-external-modules true --directory /tf

Получаем ошибки:

CHECKOV:
        
        Ensure Terraform module sources use a commit hash                  не указанн хэш удалённого модуля указывать Git
        Ensure Terraform module sources use a tag with a version number    не указана версия в источнике модуля
TFLint:
        
        Warning: Missing version constraint for provider "yandex" in `required_providers`    не указана версия провайдер
        Warning: [Fixable] variable "vms_ssh_root_key" is declared but not used              исключить из переменных root_key. Так же: vm_web_name, db_name, root_key
        Warning: Module source "git::https://github.com/......" uses a default branch as ref используется ветка в git, указывать хеш коммита
        Warning: [Fixable] variable "public_key" is declared but not used                    объявлена переменная но не используется
------

### Задание 2

1. Возьмите ваш GitHub-репозиторий с **выполненным ДЗ 4** в ветке 'terraform-04' и сделайте из него ветку 'terraform-05'.
2. Повторите демонстрацию лекции: настройте YDB, S3 bucket, yandex service account, права доступа и мигрируйте state проекта в S3 с блокировками. Предоставьте скриншоты процесса в качестве ответа.

    ![изображение](https://github.com/user-attachments/assets/f2065710-7279-4c80-a170-2490705a4847)
    ![изображение](https://github.com/user-attachments/assets/0ab94349-1570-4d32-b8a0-2f32bea82c16)
        
Выполняем команду: ``` terraform init -backend-config="access_key=..." -backend-config="..." ```

   ![изображение](https://github.com/user-attachments/assets/b7ad2545-683a-46b1-bc9f-995d72b85d04)
   ![изображение](https://github.com/user-attachments/assets/9798cb27-6bd4-4a7f-b86b-e2d9d376bbe5)

4. Закоммитьте в ветку 'terraform-05' все изменения.
5. Откройте в проекте terraform console, а в другом окне из этой же директории попробуйте запустить terraform apply.
6. Пришлите ответ об ошибке доступа к state.

   ![изображение](https://github.com/user-attachments/assets/797a2783-c04c-4c29-8cd8-5dc26a533d96)
   
7. Принудительно разблокируйте state. Пришлите команду и вывод.

   ![изображение](https://github.com/user-attachments/assets/1ba4ce2f-c8a0-4123-93d3-17571f44b27a)

------
### Задание 3  

1. Делаем в GitHub из ветки '05' новую ветку '05-fix'.
2. Проверяем код с помощью tflint и checkov, исправьляемвсе предупреждения и ошибки.
3. Создаем новый pull request изменений.
4. Вставьте в комментарий PR результат анализа tflint и checkov, план изменений инфраструктуры из вывода команды terraform plan.
5. Ссылку на [Pull requests](https://github.com/oefrager/ter-homeworks/pull/1) для ревью.
        
------
### Задание 4

1. Пишем [переменные](variables.tf) с валидацией и протестируйте их, заполнив default верными и неверными значениями. Предоставьте скриншоты проверок из terraform console. 

- type=string, description="ip-адрес" — проверка, что значение переменной содержит верный IP-адрес с помощью функций cidrhost() или regex(). Тесты:  "192.168.0.1" и "1920.1680.0.1";
- type=list(string), description="список ip-адресов" — проверка, что все адреса верны. Тесты:  ["192.168.0.1", "1.1.1.1", "127.0.0.1"] и ["192.168.0.1", "1.1.1.1", "1270.0.0.1"].

     ![изображение](https://github.com/user-attachments/assets/ed19dee0-b485-4fa8-b3d5-a7ed9dcbd5f8)

## Дополнительные задания (со звёздочкой*)

------
### Задание 5*
1. Напишите переменные с валидацией:
- type=string, description="любая строка" — проверка, что строка не содержит символов верхнего регистра;
- type=object — проверка, что одно из значений равно true, а второе false, т. е. не допускается false false и true true:
```
variable "lowercase" {
  description = "Uppercase is wrong"
  type        = string
  default     = "qwertyuiop"
  validation {
    condition     = can(regex("^[a-z]+$", var.lowercase))
    error_message = "Uppercase in the string"
  }
}

variable "in_the_end_there_can_be_only_one" {
    description="Who is better Connor or Duncan?"
    type = object({
        Dunkan = optional(bool)
        Connor = optional(bool)
    })
    default = {
        Dunkan = true
        Connor = true
    }
    validation {
        condition = var.in_the_end_there_can_be_only_one.Dunkan != var.in_the_end_there_can_be_only_one.Connor
        error_message = "There can be only one MacLeod"
    }
}
```
------
### Задание 6*

1. Настройте любую известную вам CI/CD-систему. Если вы ещё не знакомы с CI/CD-системами, настоятельно рекомендуем вернуться к этому заданию после изучения Jenkins/Teamcity/Gitlab.
2. Скачайте с её помощью ваш репозиторий с кодом и инициализируйте инфраструктуру.
3. Уничтожьте инфраструктуру тем же способом.


------
### Задание 7*
1. Настройте отдельный terraform root модуль, который будет создавать YDB, s3 bucket для tfstate и сервисный аккаунт с необходимыми правами. 


