$(document).ready(function () {
    $("a").on('click', function (event) {
        if (this.hash !== "") {
            event.preventDefault();
            var hash = this.hash;
            $('html, body').animate({
                scrollTop: $(hash).offset().top
            }, 1000, function () {
                window.location.hash = hash;
            });
        }
    });
    var postage = document.getElementsByClassName("postage");
    var postmark = document.getElementsByClassName("postmark");
    var figdesc = document.getElementsByClassName("fronte");
    var postagemark = [];
    postagemark.push.apply(postagemark, postage);
    postagemark.push.apply(postagemark, postmark);
    postagemark.push.apply(postagemark, figdesc);
    postagemark.push(document.getElementById('riquadro_20'))
    for (var i = 0; i < postagemark.length; i++) {
        postagemark[i].onclick = par_show;
    }

});

function par_show() {
    par_hidden();
    var svgID = this.id;
    var listPar = document.getElementsByClassName(svgID);
    for (var i = 0; i < listPar.length; i++) {
        listPar[i].style.display = "block";
    }
}

function par_hidden() {
    var list_desc = document.getElementsByClassName("desc");
    for (var i = 0; i < list_desc.length; i++) {
        list_desc[i].style.display = "none";
    }
}