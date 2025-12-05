const request = require("supertest");
const app = require("../server");

describe("Pruebas API", () => {
    test("GET /api/saludo responde 200", async () => {
        const res = await request(app).get("/api/saludo");
        expect(res.statusCode).toBe(200);
    });

    test("Responde JSON", async () => {
        const res = await request(app).get("/api/saludo");
        expect(res.headers['content-type']).toMatch(/json/);
    });

    test("Tiene propiedad mensaje", async () => {
        const res = await request(app).get("/api/saludo");
        expect(res.body).toHaveProperty("mensaje");
    });
});
