require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

# FireBase 関連
require 'google/cloud/storage'
require 'google/cloud/firestore'

get '/' do
    erb :index
end

post '/create' do
    if params[:file]

        storage = Google::Cloud::Storage.new(credentials: "./credentials.json")
        bucket = storage.bucket ENV["FIREBASE_STORAGE_BUCKET_ID"]

        # 画像の URL を保存する変数
        img_url = ''

        # 一時ファイルを作成
        img = params[:file]
        tempfile = img[:tempfile]

        # 拡張子を取得
        tempfile_ext = File.extname tempfile.path

        # ランダムな名前をつける
        tempfile_name = SecureRandom.hex + tempfile_ext

        # tempfile をストレージに保存
        bucket.create_file tempfile, "img/#{tempfile_name}", metadata: { firebaseStorageDownloadTokens: SecureRandom.uuid }

    end

    redirect '/'
end