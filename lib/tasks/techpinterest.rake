namespace :techpinterest do
  namespace :demodata do
    desc 'デモデータをダウンロードして"test/images"に保存します'
    task download: :environment do
      expect_file_count = 30
      image_dir         = Rails.root.join('test/images')

      FileUtils.mkdir_p image_dir

      file_count = Dir.glob(File.join(image_dir, '*')).count
      print "フォルダ[#{image_dir}]にファイルを#{file_count}個確認しました\n"

      if file_count < expect_file_count
        download_file_count = expect_file_count - file_count
        print "画像ファイルを新たに#{download_file_count}個ダウンロードします\n"

        download_file_count.times.each do |i|
          url = "https://loremflickr.com/200/#{rand(2..5) * 100}?random=#{i + 1}"

          URI.open(url) do |io|
            extension = Rack::Mime::MIME_TYPES.invert[io.content_type]
            File.open(File.join(image_dir, "#{Time.zone.now.to_f}#{extension}"), 'w+b') do |file|
              file.write io.read
              print '.'
            end
          end
        end
        print "\n画像ファイルのダウンロードが完了しました\n"
      end
    end

    desc 'デモデータの取り込み'
    task setup: :download do
      User.find_or_create_by!(name: '自分')
      other = User.find_or_create_by!(name: '他人')

      others_board = Board.find_or_create_by!(name: '他人のボード', user: other)

      Dir.glob(Rails.root.join('test/images/*')).each do |path|
        pin = Pin.find_or_create_by!(title: File.basename(path), board: others_board)
        next if pin.image.attached?

        pin.image.attach(
          filename: File.basename(path),
          io: File.open(path),
          content_type: Rack::Mime::MIME_TYPES[File.extname(path)]
        )
        print '.'
        sleep 0.3
      end
      print "\nデータの取り込みが完了しました\n"
    end

  end
end
