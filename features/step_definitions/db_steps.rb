前提('下記のユーザーが登録されていること:') do |table|
  User.create!(table.hashes)
end

前提('下記のボードが登録されていること:') do |table|
  Board.create!(table.hashes)
end

前提('{string} に下記のフォルダのファイルをピン留めする:') do |string, doc_string|
  others_board = Board.find_by!(name: string)

  Dir.glob(Rails.root.join(doc_string.strip, '*')).each do |path|
    pin = Pin.find_or_create_by!(title: File.basename(path), board: others_board)
    next if pin.image.attached?

    pin.image.attach(
      filename: File.basename(path),
      io: File.open(path),
      content_type: Rack::Mime::MIME_TYPES[File.extname(path)]
    )
    sleep 0.1
  end
end

ならば('データベースに下記のボードが登録されている:') do |table|
  table.hashes.each do |row|
    expect { Board.find_by!(row) }.not_to raise_error
  end
end

ならば('データベースに下記のリピンが登録されている:') do |table|
  table.hashes.each do |row|
    expect { RePin.find_by!(row) }.not_to raise_error
  end
end

前提('画像を下記からダウンロードして {string} にピン留めする:') do |string, doc_string|
  board = Board.find_by!(name: string)
  path  = 'tmp/upload.jpg'

  URI.open(doc_string) do |io|
    File.open(path, 'w+b') do |file|
      file.write io.read
    end
  end

  pin = Pin.find_or_create_by!(title: File.basename(path), board: board)
  pin.image.attach(
    filename: File.basename(path),
    io: File.open(path),
    content_type: Rack::Mime::MIME_TYPES[File.extname(path)]
  )
end

前提('下記のリピンが登録されていること:') do |table|
  RePin.create!(table.hashes)
end

ならば('データベースに下記のボードが登録されていない:') do |table|
  table.hashes.each do |row|
    expect(Board).not_to be_exist row
  end
end
