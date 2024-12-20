#!/bin/bash

# Запрос подтверждения у пользователя
read -p "Вы точно хотите переустановить Docker? (y/n): " confirm

if [[ "$confirm" != "y" ]]; then
    echo "Операция отменена."
    exit 1
fi

# Обновление списка пакетов
echo "Обновление списка пакетов..."
sudo apt-get update

# Удаление Docker и его зависимостей
echo "Удаление Docker..."
sudo apt-get purge -y docker-engine docker docker.io docker-ce docker-ce-cli

# Очистка оставшихся зависимостей
echo "Очистка системы от ненужных пакетов..."
sudo apt-get autoremove -y

# Удаление оставшихся файлов
echo "Удаление оставшихся файлов Docker..."
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd

# Установка необходимых зависимостей
echo "Установка необходимых пакетов..."
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Добавление GPG ключа Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Добавление репозитория Docker
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Обновление списка пакетов для нового репозитория
echo "Обновление списка пакетов с новым репозиторием..."
sudo apt-get update

# Установка Docker CE
echo "Установка Docker CE..."
sudo apt-get install -y docker-ce

# Проверка статуса Docker
echo "Проверка статуса Docker..."
sudo systemctl status docker

echo "Docker успешно переустановлен!"
