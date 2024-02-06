# ALLS OBS AD

ALLS OBS AD是一个基于Flutter的公告小程序。它使用了Dart语言和Pub包管理器进行开发。

## 项目简介

这个项目主要用于在一台直播专用机器上展示公告，并被OBS Studio窗口采集。它可以从服务器获取广告数据，并在指定的设备上被OBS显示

## 安装

克隆这个仓库到你的本地机器上

```bash
git clone https://github.com/Kgym-Hina/alls_obs_ad.git
```

2. 在项目的根目录下运行以下命令来获取依赖

```bash
flutter pub get
```

3. 使用你的IDE运行项目

## 使用方法

在`lib/main.dart`文件中，你可以找到主程序的入口。你可以通过修改这个文件来改变程序的行为。为了让广告能够在特定的设备上显示并被OBS Studio采集，你可能需要对应用的部署和运行环境进行一些特殊的配置。

## 开发者信息

- Kgym-Hina

## 许可证

这个项目使用 AGPL-3.0 许可证。详情请查看[协议](https://www.gnu.org/licenses/agpl-3.0.html).

## 贡献

如果你有任何问题或者建议，欢迎提交issue或者pull request。