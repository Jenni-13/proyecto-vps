const express = require("express");
const app = express();

app.get("/api/saludo", (req, res) => {
    res.json({ mensaje: "Hola desde API v1" });
});

app.listen(3000, () => console.log("API corriendo en puerto 3000"));
module.exports = app;
