# カテゴリ
category_names = [
  "Ruby",
  "Rails",
  "HTML/CSS",
  "JavaScript",
  "Typescript",
  "React",  
  "Next.js",
  "Vue.js",
  "Nuxt.js",
  "Python",
  "PHP",
  "Laravel",
  "Java",
  "モバイルアプリ",
  "SQL",
  "データベース",
  "AWS",
  "インフラ",
  "WEB技術",
  "基本情報技術者"
  "セキュリティ"
  "テスト"
  "キャリア"
  "デザイン",
  "マーケティング",
  "ビジネス",
  "マネジメント",
  "エディタ",
  "その他"
]

created_categories = category_names.map do |name|
  Category.find_or_create_by!(name: name)
end
