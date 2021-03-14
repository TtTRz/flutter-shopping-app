  // 导入koa-router模块
  const Router = require('koa-router');
  // 创建koa-router的实例router
  const router = new Router();
 // 导入koa模块
 const Koa = require('koa');
 // 创建koa的实例app
 const app = new Koa();

 app.use(async ctx => {
	const req = ctx.request
	const url = req.url	// 请求的url
	const method = req.method	// 请求的方法
	let post_data = ''
	ctx.req.addListener('data', (postDataChunk) => {
		console.log('收到post数据 ---->' ,postDataChunk)
		post_data += postDataChunk
	})
	ctx.req.addListener('end', () => {
		console.log('接收post数据完毕 ---->', post_data)
	})
	ctx.body = {
		url,
		method,
	}
})
 // 监听端口
 app.listen(3000, () => {
     console.log("服务器已启动，http://localhost:3000");
 })