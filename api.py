from aiohttp import web

async def hello(request):
    return web.Response(text="Hello, world")

app = web.Application()
app.add_routes([web.get('/', hello)])
app.router.add_static('/static', "./static")

web.run_app(app,host="0.0.0.0", port="5000")