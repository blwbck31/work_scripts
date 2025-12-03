# Устанавливаем путь к папке с бэкапами
$BackupPath = "E:\SQL_BAK"

# Устанавливаем количество дней, после которых файлы считаются устаревшими
$DaysToKeep = 14

# Вычисляем дату, до которой файлы ещё актуальны (сегодня - количество дней)
$CutoffDate = (Get-Date).AddDays(-$DaysToKeep)

# Находим все файлы во всех подпапках, которые были изменены до CutOffDate
$FilesToDelete = Get-ChildItem -Path $BackupPath -File -Recurse | Where-Object { $_.LastWriteTime -lt $CutoffDate }

# Удаляем каждый найденный файл
foreach ($File in $FilesToDelete) {
    Write-Host "Удаляется файл: $($File.FullName)" -ForegroundColor Yellow
    Remove-Item $File.FullName -Force
}

Write-Host "Очистка завершена." -ForegroundColor Green
