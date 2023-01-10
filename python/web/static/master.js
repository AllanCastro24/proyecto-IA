
function exportCanvas(){
    var jpeg = document.getElementById("myChart");
    jpeg.addEventListener("click",function(){	
        var dato = canvas.toDataURL("image/jpeg");
        dato = dato.replace("image/jpeg", "image/octet-stream");
        document.location.href = dato;	
    },false);
}

(function () {
    'use strict'

    feather.replace()

    var ctx = document.getElementById('myChart')
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: [
                'Domingo',
                'Lunes',
                'Martes',
                'Miercoles',
                'Jueves',
                'Viernes',
                'Sabado',
                'Domingo',
                'Lunes',
                'Martes',
                'Miercoles',
                'Jueves',
                'Viernes',
                'Sabado'
            ],
            datasets: [{
                data: [
                    89.7,
                    590,
                    17.9,
                    44,
                    239.2,
                    84,
                    17.9,
                    29.9,
                    104,
                    149.7
                ],
                lineTension: 0,
                backgroundColor: 'transparent',
                borderColor: '#007bff',
                borderWidth: 4,
                pointBackgroundColor: '#007bff'
            }]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: false
                        }
                    }]
                },
                legend: {
                    display: false
                }
            }
        })
    })()