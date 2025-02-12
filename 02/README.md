### Задание 1
2. Создаем сервисный аккаунт и ключ.
 
 ![изображение](https://github.com/user-attachments/assets/2b60afec-3a2f-4537-b3c3-f8733fec6e31)

3. Указываем ssh-public в переменную **vms_ssh_root_key**:  ``` default     = "~/.ssh/id_ed25519.pub" ```
4. Запускаем код и получаем ВМ:

 ![изображение](https://github.com/user-attachments/assets/1630a0cd-6802-4ca4-b8e4-b89d2000478d)

Исправлены строки:
  ```platform_id = "standard-v3"```. Синтаксическая ошибка, версии могут быть только v1, v2 и v3.
  ```Cores = 2```  допустимо только 2
  ```core_fraction = 20``` доступно 20, 50, 100
   
5. Подключаемся к консоли ВМ через ssh и выполните команду ``` curl ifconfig.me```.

 ![изображение](https://github.com/user-attachments/assets/6a82add1-8aa6-4824-b4f7-1f8201660c0f)

6. Так как ВМ не загружена работой, параметры ```preemptible = true``` (прерываемая ВМ) и ```core_fraction=5``` (загрузка процессора) помогают экономить  ресурсы.



### Задание 2

1. Меняем все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на переменные в [variables.tf](variables.tf)
Получаем main.tf:
```
resource "yandex_vpc_network" "develop" {
  name      = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

#--------------
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image
}

resource "yandex_compute_instance" "platform" {
  name            = var.vm_web_instance["name"]
  platform_id     = var.vm_web_instance["platform_id"]
  resources {
    cores         = var.vm_web_instance["cores"]
    memory        = var.vm_web_instance["memory"]
    core_fraction = var.vm_web_instance["core_fraction"]
  }
#--------------

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${file(var.vms_ssh_root_key)}"
  }

}
```

3. Проверяем ```terraform plan```.

   ![изображение](https://github.com/user-attachments/assets/51c803df-791c-4731-8c72-6484d334009f)



### Задание 3

1. Создаем файл [vms_platform.tf](vms_platform.tf).
2. Правим [main.tf](main.tf).
3. Применяем изменения и получаем:

![изображение](https://github.com/user-attachments/assets/b01dcb1c-1dd9-4b36-93fd-839dd7c04979)


### Задание 4

1. Создаем файл [outputs.tf](outputs.tf) для вывода: instance_name, external_ip, fqdn из каждой ВМ

![изображение](https://github.com/user-attachments/assets/74c53387-1427-43b7-b526-ace33ba04b35)


### Задание 5

1. Создаем файл [locals.tf](locals.tf) с параметрами ВМ.
3. Применяем изменения и получаем:

![изображение](https://github.com/user-attachments/assets/1ca5b0f0-83b2-456f-a08b-e290f871bdbe)


### Задание 6

1. Объединяем переменную в ```vms_resources``` и  внутри неё конфиги обеих ВМ в виде вложенного map(object).

variebles.tf:

   ![изображение](https://github.com/user-attachments/assets/b084aa3a-230d-4cfd-beb4-5593df3a02a8)

main.tf:

   ![изображение](https://github.com/user-attachments/assets/738b2a8e-eaa3-492b-9d5e-d1c715d87cb6)

  
5. Найдите и закоментируйте все, более не используемые переменные проекта.
6. Проверяем terraform plan:

![изображение](https://github.com/user-attachments/assets/59f1466f-dac6-4432-894b-c2d53f4667f4)

------

### Задание 7*

Изучите содержимое файла console.tf. Откройте terraform console, выполните следующие задания: 

1. Напишите, какой командой можно отобразить **второй** элемент списка test_list.
   ```
   > local.test_list.1
   "staging"
   ```
3. Найдите длину списка test_list с помощью функции length(<имя переменной>).
   ```
   > length(local.test_list)
   3
   ```
5. Напишите, какой командой можно отобразить значение ключа admin из map test_map.
   ```
   > local.test_map.admin
   "John"
   ```
7. Напишите interpolation-выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.
   ```
   > "${local.test_map.admin} is ${keys(local.test_map).0} for ${local.test_list.2} server based on OS    ${local.servers.stage.image} with ${local.servers.production.cpu} vcpu, ${local.servers.production.ram} ram and ${length(local.servers.production.disks)} virtual disks"
   
   "John is admin for production server based on OS ubuntu-20-04 with 10 vcpu, 40 ram and 4 virtual disks"
   ```

### Задание 8*
1. Напишите и проверьте переменную test и полное описание ее type в соответствии со значением из terraform.tfvars:
```
> type(var.test)
tuple([
    object({
        dev1: tuple([
            string,
            string,
        ]),
    }),
    object({
        dev2: tuple([
            string,
            string,
        ]),
    }),
    object({
        prod1: tuple([
            string,
            string,
        ]),
    }),
])
```
2. Напишите выражение в terraform console, которое позволит вычленить строку "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117" из этой переменной.
 ```
 > var.test.0.dev1.0
 "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117"
 ```
