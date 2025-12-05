fetch("/api/saludo")
    .then(res => res.json())
    .then(data => {
        document.getElementById("mensaje").textContent = data.mensaje;
    });
