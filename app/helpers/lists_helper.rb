module ListsHelper
  def share_link(list)

    text = current_user&.id == list.user_id ? "来年読みたいリスト" : "おすすめのリスト"
    text += "【#{list.name}】をチェック📕👀"

    params = {
      text: text,
      url: request.original_url,
      hashtags: "来読"
    }

    url = "https://x.com/intent/tweet"
    "#{url}?#{params.to_query}"
  end
end
