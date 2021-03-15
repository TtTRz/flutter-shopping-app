const SERVICE_BASE_URL = "https://api.fmg.net.cn";
const QINIU_BASR_URL = "http://qiniu.fmg.net.cn";
// const serviceBaseUrl = "http://localhost:3000";
const Map servicePath = {
  "user": {
    "register": "/account/login/register",
    "web_login": "/account/login/web_login"
  },
  "swiper": {
    "goods": {"mget": "/goods/slideshow/_mget"}
  },
  "category": {
    "list": "/goods/kind_tag/list",
    "mget": "/goods/kind_tag/_mget",
  }
};
