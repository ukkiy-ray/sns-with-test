require 'rails_helper'

RSpec.describe "Posts", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
  end

  context '投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('投稿する')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する
      fill_in 'post[title]', with: @post.title
      fill_in 'post[description]', with: @post.description

      # 添付する画像を定義する
      image_path = Rails.root.join('spec/factories/images/test.png')

      # 画像選択フォームに画像を添付する
      attach_file('post[image]', image_path, make_visible: true)

      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容のツイートが存在することを確認する
    end
  end
  context '投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('投稿する')
    end
  end
end

RSpec.describe 'Post編集', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
  end
  context 'Postの編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したPostの編集ができる' do
      # post1を投稿したユーザーでログインする
      # post1に「Update」ボタンがあることを確認する
      # 編集ページへ遷移する
      # すでに投稿済みの内容がフォームに入っていることを確認する
      # 投稿内容を編集する
      # 編集してもPostモデルのカウントは変わらないことを確認する
      # トップページに遷移したことを確認する
      # トップページには先ほど変更した内容のPostが存在することを確認する
    end
  end
  context 'Post編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したPostの編集画面には遷移できない' do
      # post1を投稿したユーザーでログインする
      # post2に「Update」ボタンがないことを確認する
    end
    it 'ログインしていないとPostの編集画面には遷移できない' do
      # トップページにいる
      # post1に「Update」ボタンがないことを確認する
      # post2に「Update」ボタンがないことを確認する
    end
  end
end