$(function() {
  var search_list = $(".contents.row")

  function appendTweet(tweet) {
    if(tweet.user_sign_in && tweet.user_sign_in.id == tweet.user_id) {
      var current_user = `<li>
                            <a href="/tweets/${tweet.id}/edit" data-method="get" >編集</a>
                          </li>
                          <li>
                            <a href="/tweets/${tweet.id}" data-method="delete" >削除</a>
                          </li>`
    } else {
      var current_user = ""
    }

    var html = `<div class="content_post wow bounce" style="background-image: url(${tweet.image});">
                  <div class="more">
                    <span><img src="/assets/arrow_top.png"></span>
                    <ul class="more_list">
                      <li>
                        <a href="/tweets/${tweet.id}" data-method="get" >詳細</a>
                      </li>
                      ${current_user}
                    </ul>
                  </div>
                <span class="name">
                <a href="/users/${tweet.user_id}">
                    ${ tweet.name }
                  </a>
                </span>
                <div class="text">
                  ${ tweet.text }<br>
                  today:${tweet.time}h 
                  <br>
                  残り: xxxh
                </div>
                </div>`
    search_list.append(html);
  }

  function appendErrMsgToHTML(msg) {
    var html = `<div class="name> ${msg}</div>`
    search_list.append(html);
  }

  $(".search-input").on("keyup", function() {
    var input = $(".search-input").val();
    $.ajax({
      type: "GET",
      url: "/tweets/searches",
      data: { keyword: input},
      dataType: "json"
    })
    .done(function(tweets){
      $(".contents.row").empty();
      if(tweets.length !== 0) {
        tweets.forEach(function(tweet){
          appendTweet(tweet);
        });
      }
      else{
        appendErrMsgToHTML("一致するツイートがありません");
      }
    })
    .fail(function() {
      alert('error');
    });
  });
});