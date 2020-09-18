document.addEventListener("turbolinks:load", function(){
    $('.tagsinput').tagsInput();
});
document.addEventListener("turbolinks:load", function(){
    $('#tags_all').tagsInput();
});

document.addEventListener("turbolinks:load", function(){
    $('#tags_top').tagsInput();
});

document.addEventListener("turbolinks:load", function() {
    var topBtn = $('.reserv_post');
    topBtn.hide();
    //スクロールしてページトップから100に達したらボタンを表示
    $(window).scroll(function () {
        if ($(this).scrollTop() > 400) {
            topBtn.fadeIn();
        } else {
            topBtn.fadeOut();
        }
    });
});
document.addEventListener("turbolinks:load", function() {
    var topBtn = $('.reserv_mypage');
    topBtn.hide();
    $(window).scroll(function () {
        if ($(this).scrollTop() > 400) {
            topBtn.fadeIn();
        } else {
            topBtn.fadeOut();
        }
    });
});

document.addEventListener("turbolinks:load", function() {
  window.showmain = document.getElementById('show-main')
  if (showmain === null) {
      return
    }
  document.getElementById("copyTarget").style.display ="none";
  copybtn.addEventListener("click",function() {
     copyTarget.style.display ="block";
     copyTarget.select();
     document.execCommand("copy");
     copyTarget.style.display ="none";
     alert("URLをコピーしました。 SNSにも投稿し対戦相手を探しましょう。")
  })
})
