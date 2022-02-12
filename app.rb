require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

# FireBase 関連
require 'google/cloud/storage'
require 'google/cloud/firestore'
require 'json'

# .env ファイルを読み込む
before do
    Dotenv.load
end

get '/' do
    erb :index
end

post '/create' do
    if params[:file]

        # storage を取得
        storage = Google::Cloud::Storage.new(credentials: "./credentials.json")

        # bucket を取得
        bucket = storage.bucket ENV['FIREBASE_STORAGE_BUCKET_ID']

        # 一時ファイルの情報を img に格納
        img = params[:file]

        # 一時ファイルの保存場所を取得
        tempfile = img[:tempfile]

        # 拡張子を取得
        tempfile_ext = File.extname tempfile.path

        # ランダムな名前をつける
        tempfile_name = SecureRandom.hex + tempfile_ext

        # ファイル所得時のためにトークンを生成
        token = SecureRandom.uuid

        # tempfile をストレージに保存
        file = bucket.create_file tempfile, "img/#{tempfile_name}", metadata: { firebaseStorageDownloadTokens: token }

        # 画像のパブリック URL を保存する変数
        img_url = "https://firebasestorage.googleapis.com/v0/b/#{ENV['FIREBASE_STORAGE_BUCKET_ID']}/o/img%2F#{tempfile_name}?alt=media&token=#{token}"

        # 画像のパブリック URL を表示する
        puts img_url

    end

    redirect '/'
end