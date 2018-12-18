function main() {
  let paper = document.getElementById("computed");
  for (let i = 0; i < items.length; i++) {
    let object = items[i]
    let p = document.createElement("p");
    let t = document.createTextNode(object.text);
    p.style.cssText = "position: absolute; top: "+object.y+"px; left: "+object.x+"px; transform: rotate("+object.rotation+"deg); font-size: 1.4rem; z-Index: 2;"
    paper.appendChild(p).appendChild(t);
  }
  for (let i = 0; i < postmarks.length; i++) {
    let postmark = postmarks[i]
    let p = document.createElement("div");
    p.style.cssText = "position: absolute; top: "+postmark.x+"px; left: "+postmark.y+"px; background-color: "+postmark.color+"; height: "+postmark.height+"px; width: "+postmark.width+"px; transform: rotate("+postmark.rotation+"deg); z-Index: 1;"
    paper.appendChild(p);
  }
  for (let i = 0; i < stamps.length; i++) {
    let stamp = stamps[i];    
    let p = document.createElement("div");
    p.style.cssText = "position: absolute; top: "+stamp.x+"px; left: "+stamp.y+"px; border: 4px dashed "+stamp.color+"; height: "+stamp.diameter+"px; width: "+stamp.diameter+"px; border-radius: 50%; z-Index: 2";
    paper.appendChild(p)
  }
}

window.onload = main;