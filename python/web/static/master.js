
function exportCanvas(){
    var jpeg = document.getElementById("myChart");
    jpeg.addEventListener("click",function(){	
        var dato = canvas.toDataURL("image/jpeg");
        dato = dato.replace("image/jpeg", "image/octet-stream");
        document.location.href = dato;	
    },false);
}