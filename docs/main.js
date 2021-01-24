$(document).ready(function () {
    // smooth scroll JQuery
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

    var typography = document.getElementsByClassName("print"); // testo stampato
    var catalog = document.getElementsByClassName("catalog");

    var manoscritti = document.getElementsByClassName("manoscritto"); // paragrafi manoscritti
    var zoneManoscr = document.getElementsByClassName("handWriting"); // zone colorate
    // stili per aree cartolina
    var highlight = 'background: #FF4136; color: #fff; fill: #FF4136; stroke: #ff4136'
    var blueHighlight = 'background: #FF4136; color: #fff; fill: #0074D9; stroke: #0074D9;'
    var yellowHighlight = 'background: #FF4136; color: #fff; fill: #FFDC00; stroke: #FFDC00;'
    var greenHighlight = 'background: #FF4136; color: #fff; fill: #2ECC40; stroke: #2ECC40;'
    var remHighlight = 'background: inherit; fill: transparent; color: inherit'
    // .filterbar buttons
    var btnHand = document.getElementsByClassName("btn-hand");
    var btnTypo = document.getElementsByClassName("btn-typo");
    var btnStmp = document.getElementsByClassName("btn-stmp");
    var btnCata = document.getElementsByClassName("btn-cata");
    var btnClr = document.getElementsByClassName("btn-clr");

    // sezioni delle cartoline
    var cartoline = document.querySelectorAll('#cartolina_011, #cartolina_016, #cartolina_020');

    var svgAreas = document.getElementsByClassName("overlayPath");
    for (let i = 0; i < svgAreas.length; i++) {
        // quando il cursore entra nella cartolina rimuovi i colori
        svgAreas[i].onmouseenter = clearZones
    }

    for (let i = 0; i < btnCata.length; i++) {
        //filtro: mostra numeri catalogazione
        let zone = cartoline[i].getElementsByClassName("catalog")
        btnCata[i].onclick = function (e) {
            for (let i = 0; i < zone.length; i++) {
                zone[i].style = greenHighlight
            }
        }
    }

    for (let i = 0; i < btnHand.length; i++) {
        // filtro: mostra handwriting
        btnHand[i].onclick = function (e) {
            let zone = cartoline[i].getElementsByClassName("handWriting")
            for (let i = 0; i < zone.length; i++) {
                zone[i].style = highlight
            }
        }
    }

    for (let i = 0; i < btnStmp.length; i++) {
        // filtro: mostra timbri
        let zone = cartoline[i].getElementsByClassName("postage")
        if (zone.length) {
            btnStmp[i].onclick = function (e) {
                for (let i = 0; i < zone.length; i++) {
                    zone[i].style = blueHighlight
                }
            }
        } else {
            // se non ci sono timbri disabilito il pulsante
            btnStmp[i].disabled = true
        }
    }

    for (let i = 0; i < btnTypo.length; i++) {
        // filtro: mostra typography
        let zone = cartoline[i].getElementsByClassName("print")
        if (zone.length) {
            btnTypo[i].onclick = function (e) {
                for (let i = 0; i < zone.length; i++) {
                    zone[i].style = yellowHighlight
                }
            }
        } else {
            btnTypo[i].disabled = true
        }
    }

    for (let i = 0; i < btnClr.length; i++) {
        // button-clear (rimuovi colore dalle zone)
        btnClr[i].onclick = clearZones
    }

    for (let i = 0; i < manoscritti.length; i++) {
        // dai paragrafi coloro paragrafi e zone
        manoscritti[i].onmouseenter = function (e) {
            e.target.style = highlight
            zoneManoscr[i].style = highlight
        }
        manoscritti[i].onmouseleave = function (e) {
            e.target.style = remHighlight
            zoneManoscr[i].style = remHighlight
        }
    }

    for (let i = 0; i < zoneManoscr.length; i++) {
        // dalle zone coloro paragrafi e zone
        zoneManoscr[i].onmouseenter = function (e) {
            e.target.style = highlight
            manoscritti[i].style = highlight
        }
        zoneManoscr[i].onmouseleave = function (e) {
            e.target.style = remHighlight
            manoscritti[i].style = remHighlight
        }
    }

    for (let i = 0; i < typography.length; i++) {
        // coloro di giallo typography
        typography[i].onmouseenter = function (e) {
            e.target.style = yellowHighlight
        }
        // rimuovo giallo da typography
        typography[i].onmouseleave = function (e) {
            e.target.style = remHighlight
        }
    }

    for (let i = 0; i < catalog.length; i++) {
        // coloro di verde catalogazione
        catalog[i].onmouseenter = function (e) {
            e.target.style = greenHighlight
        }
        // rimuovo verde da catalogazione
        catalog[i].onmouseleave = function (e) {
            e.target.style = remHighlight
        }
    }

    var postagemark = document.querySelectorAll(".postage, .postmark, .fronte")
    for (var i = 0; i < postagemark.length; i++) {
        // visualizza testo descrittivo cliccando
        postagemark[i].onclick = par_show;
        // attiva/disattiva colore blu al passaggio del mouse
        postagemark[i].onmouseenter = function (e) {
            e.target.style = blueHighlight
        }
        postagemark[i].onmouseleave = function (e) {
            e.target.style = remHighlight
        }
    }
    // gestione eccezione per riquadro_20 che deve essere giallo
    var riquadro_20 = document.getElementById("riquadro_20")
    riquadro_20.onclick = par_show;
    riquadro_20.onmouseenter = function (e) {
        e.target.style = yellowHighlight;
    }
    riquadro_20.onmouseleave = function (e) {
        e.target.style = remHighlight
    }
});

function clearZones() {
    // nascondi tutte le aree colorate dalla pagina
    let zones = document.querySelectorAll('.postage, .print, .handwriting, .catalog')
    for (let i = 0; i < zones.length; i++) {
        zones[i].style = 'background: inherit; fill: transparent; color: inherit'
    }
}

function par_show() {
    // mostra il testo nel post-it
    par_hidden();
    var svgID = this.id;
    var listPar = document.getElementsByClassName(svgID);
    for (var i = 0; i < listPar.length; i++) {
        listPar[i].style.display = "block";
    }
}

function par_hidden() {
    // nascondi il testo nel post-it
    var list_desc = document.getElementsByClassName("desc");
    for (var i = 0; i < list_desc.length; i++) {
        list_desc[i].style.display = "none";
    }
}