## Запуск

Команды выполняются из папки `crossPlatfrom/flutter_app`:

```powershell
flutter pub get
flutter run -d chrome --web-port=8080 --dart-define=API_BASE_URL=http://localhost:5055/
```

Перед запуском Flutter запустите сервер из корня репозитория `crossPlatfrom`:

```powershell
dotnet run --project Server/Server/Server.csproj --launch-profile http
```

Главная страница получает фильмы через `GET /api/movies`. Сервер разрешает
CORS для Flutter Web на порту 8080. Постеры загружаются по относительным URL
из ответа API. Ошибка запроса отображается с кнопкой «Повторить».

Для Windows:

```powershell
flutter run -d windows --dart-define=API_BASE_URL=http://localhost:5055/
```

Для стандартного Android-эмулятора укажите адрес `http://10.0.2.2:5055/`
через тот же `--dart-define`. Для телефона используйте IP компьютера в общей
локальной сети и настройте доступ к серверу по этому адресу. Локальный HTTP
разрешён в debug-конфигурации Android.

## Генерация модели

После изменения `lib/domain/repositories/movies/model/movie.dart`:

```powershell
dart run build_runner build -d
```

## Проверка

```powershell
flutter analyze
flutter build web
flutter build windows
```
