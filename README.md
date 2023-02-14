# NotifireProvider
Riverpod2.0のNotifireを使ってみた!

参考にしたサイト
https://codewithandrea.com/articles/flutter-riverpod-async-notifier/

pub finished with exit code 66のエラーを解決する方法!

Android Studioのターミナルに

① flutter pub pub cache repair と打つ。
```
flutter pub pub cache repair
```
② flutter packages get と打つ。
```
flutter packages get
```

③  flutter pub run build_runner watch --delete-conflicting-outputsと打つ。
watchモードになってずっと起動しているので、止めるときはMacだと　control + c を押す!
```
flutter pub run build_runner watch --delete-conflicting-outputs
```

# 参考になったサイト
https://github.com/fluttercommunity/flutter_launcher_icons/issues/50
