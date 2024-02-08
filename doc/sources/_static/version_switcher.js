fetch("/versions.json").then(response => response.text()).then(respText=>
    load_versions(respText));

function load_versions(json){
    var button = document.getElementById('version-switcher-button')
    var container = document.getElementById('version-switcher-dropdown')
    var loc = window.location.href;
    var s = document.createElement('select');
    const versions = JSON.parse(json);
    for (version of versions){
        var o = document.createElement('option');
        o.innerHTML = version[0];
        o.value = version[1];
        if (current_version == version[0]){
            o.selected = true;
        }
        s.append(o);
    }
    button.addEventListener("click", (event)=> {
        window.location.href = window.location.href.replace("/"+current_version+"/",s.value+"/");
    })
    container.append(s);
}