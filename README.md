<div id="top"></div>

## 使用技術一覧

<p style="display: inline">
  <!-- フロントエンドのフレームワーク一覧 -->
  <img src="https://img.shields.io/badge/-TailwindCSS-06B6D4.svg?logo=tailwindcss&style=for-the-badge&logoColor=white" alt="TailwindCSS">
  <!-- バックエンドのフレームワーク一覧 -->
  <img src="https://img.shields.io/badge/-Ruby%20on%20Rails-CC0000.svg?logo=rubyonrails&style=for-the-badge&logoColor=white" alt="Ruby on Rails">
  <!-- バックエンドの言語一覧 -->
  <img src="https://img.shields.io/badge/-Ruby-701516.svg?logo=ruby&style=for-the-badge&logoColor=white" alt="Ruby">
  <!-- ミドルウェア一覧 -->
  <img src="https://img.shields.io/badge/-PostgreSQL-336791.svg?logo=postgresql&style=for-the-badge&logoColor=white" alt="PostgreSQL">
  <!-- インフラ一覧 -->
  <img src="https://img.shields.io/badge/-Docker-2496ED.svg?logo=docker&style=for-the-badge&logoColor=white" alt="Docker">
  <img src="https://img.shields.io/badge/-Heroku-430098.svg?logo=heroku&style=for-the-badge&logoColor=white" alt="Heroku">
  <img src="https://img.shields.io/badge/-Github%20Actions-2088FF.svg?logo=githubactions&style=for-the-badge&logoColor=white" alt="GitHub Actions">
</p>

## 目次

1. [サービスについて](#サービスについて)
2. [環境](#環境)
3. [ディレクトリ構成](#ディレクトリ構成)
4. [DB構成](#DB構成)

## サービス名

<img src="public/weathermaple.png" alt="Weather Maple Logo" width="25" style="vertical-align: middle; margin-right: 10px;"> Weather Maple

## サービスについて

旅行前に現地の天気を確認するための天気情報サービスです。</br>気温だけではなく、湿度や日の出日の入りの時間、風速なども確認できるため、旅行時の服装選びや行動予定にも役立ちます。</br>旅行の移動中でも操作しやすいようシンプルなUIにしています！

<p align="right">(<a href="#top">トップへ</a>)</p>

## 環境

| 言語・フレームワーク  | バージョン |
| --------------------- | ---------- |
| Ruby                  | 3.2.2      |
| Rails                 | 7.2.2      |
| PostgreSQL            | 15.10      |
| Node.js               | 20.x       |
| Yarn                  | 最新       |
| Docker                | 最新       |

<p align="right">(<a href="#top">トップへ</a>)</p>

## ディレクトリ構成

```plaintext
.
├── app
│   ├── assets
│   ├── controllers
│   ├── helpers
│   ├── javascript
│   ├── models
│   ├── services
│   │   └── weather_api.rb
│   └── views
├── bin
│   ├── breakeman
│   ├── bundle
│   ├── dev
│   ├── docker-entrypoint
│   ├── jobs
│   ├── kamal
│   ├── rails
│   ├── rake
│   ├── rubocop
│   ├── setup
│   └── thrust
├── config
│   ├── environments
│   ├── initializers
│   ├── locales
│   └── credentials.yml.enc
├── db
│   ├── city_list
│   ├── migrate
│   ├── schema.rb
│   └── seeds.rb
├── public
├── spec
├── compose.yml
├── Dockerfile
├── Dockerfile.dev
├── Gemfile
├── package.json
├── postcss.config.js
├── tailwind.config.js
└── README.md
```

<p align="right">(<a href="#top">トップへ</a>)</p>

## DB構成 <a id="DB構成"></a>

[![Image from Gyazo](https://i.gyazo.com/15392c72f0208f1a6bb18595c7d9a982.png)](https://gyazo.com/15392c72f0208f1a6bb18595c7d9a982)

<p align="right">(<a href="#top">トップへ</a>)</p>