FROM ruby:2.5.3

# apt-get update: パッケージのリストの更新
#Railsの環境構築に必要なパッケージのインストール 
# build-essential: コンパイラなど、ビルドに必要なツール
# libpq-dev: PostgresSQLを使う際に必要
RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       nodejs           

# 作業ディレクトリの作成、設定
RUN mkdir /app_name 
##作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /app_name 
# 作業ディレクトリに設定
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileをコピー
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileに定義されたgemのインストール
RUN bundle install
ADD . $APP_ROOT