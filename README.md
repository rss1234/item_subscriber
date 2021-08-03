# 前言

此repo用作于探讨用R做商品网页爬虫的可能性，请勿用作商业用途。`find_bag_utils.R`中使用到了一个Hermes picotin的url仅做示例。

# 项目目标

此项目最初目标仅为使用代码替代手动刷新页面查看目标商品（类）的存在，并提供邮件提醒，为上班党带来福音。项目目标会随时间改变，请在PR中同时更改项目目标。

# Using `renv`

为保持使用相同的环境，请在编程过程使用`renv` workflow，详情见下
When using `renv` to manage dependencies for your deployments, it's sometimes desirable to have separate `renv` libraries for each deployment, as this will allow you to have separate versions of packages (eg. v1.0 on production, v1.1 on staging).

To set-up deployment-specific `renv` libraries:

1. Use `renv::init(project = "fancy_app/")` to initialize an `renv` library under `deployments/fancy_app`
2. Whenever you want to manage this deployment, use `renv::activate(project = "fancy_app/")` to activate this deployment's `renv` library.
3. After activation, all subsequent `renv` function calls (eg. `renv::install`, `renv::snapshot`, `renv::restore`) will now default to this library.

# 目前代码存在的问题

1. 一旦出现了一个目标商品，while loop将无法进行，只能等待目标商品消失才能继续爬取。解决方案：加入exclusion_list把已经出现的目标物品从link_list中移除
2. 访问host单一，容易被网站察觉。
3. 需要泛化的function来定义目标商品

# 沟通

如有任何建议请大家通过Issues沟通，请各位大佬随意创建PR并tag zhuyangg1f 为reviewer。请将勿将任何代码merge到main branch，谢谢！

#
#

# 步骤记录 From Windows10
##### 无R环境  GMAIL-API未开启
##### ！先开启GMAIL-API，再改代码，最后运行配置R环境并运行脚本！

## 开启GMAIL-API
1. 进入Google API Console. Link: https://console.developers.google.com/
![image](https://user-images.githubusercontent.com/15516632/127945120-61320ef1-0ae6-4a17-9581-316c7f01d6b9.png)
2. 点击[库]，键入 GMAIL，选择 [GMAIL API]
![image](https://user-images.githubusercontent.com/15516632/127945252-1c10eb8e-620f-447b-9642-4a15045e1752.png)
3. 点击[启用]
![image](https://user-images.githubusercontent.com/15516632/127945340-8943ff6c-f7ae-45fb-9b04-e9436149ab95.png)
4. 创建凭据 
        [范围]处无需选择，直接跳过
        [凭据]无需下载，直接完成
![image](https://user-images.githubusercontent.com/15516632/127945451-e89d1c64-4fab-4bd0-8228-878605ecdf1e.png)
![image](https://user-images.githubusercontent.com/15516632/127945479-7c159e99-c05d-469f-b0c1-1d67f6b4adef.png)
![image](https://user-images.githubusercontent.com/15516632/127945545-5fb11a32-2110-4860-82f7-d17a49074ded.png)
![image](https://user-images.githubusercontent.com/15516632/127945651-6ce3ab36-82a1-4510-8441-42ee68c0890d.png)
5. 开启"安全性较低的应用的访问权限"   Link: https://myaccount.google.com/lesssecureapps

## R环境配置
1. 下载R, 由于R要求版本为4.0.5.目前最新版本为4.1.0.故需找到R4.0.5版本文件. Link: https://cran.r-project.org/bin/windows/base/old/4.0.5/
2. WIN+R,打开cmd,键入 `cd C:\Users\Username\Desktop\HERMES\完整文档\item_subscriber` , 进入对应目录下。
   键入 `R`，进入R环境。
3. 键入 `renv::init(project = "fancy_app/")` 安装`renv`包
4. 键入 `install.packages(c("rvest", "Rcrawler", "emayili")`一次性安装所需包
   或依次键入 `library(rvest)`   `library(Rcrawler)`   `library(emayili)` 分开安装
5. 键入 `source("hermes_web_crawler.R")` 即开始运行脚本
![image](https://user-images.githubusercontent.com/15516632/127946046-006ed5ee-b902-4efd-b5f8-3d0792d15803.png)

##
## 代码更改
### find_bag_utils.R
`picotin <- "https://www.hermes.com/us/en/product/picotin-lock"` 可将`picotin-lock`改为其他关键字，从而锁定其它包包
### hermes_web_crawler.R
1. 设置抓取网址
        url = "https://www.hermes.com/us/en/category/women/bags-and-small-leather-goods/bags-and-clutches/#||Category"
2. smtp邮箱设置
        `emayili::from("sender@mail.com") %>%` 改为 `emayili::from("打开了API的谷歌邮箱@gmail.com") %>%` 
        `emayili::to(c("renshangsi@gmail.com")) %>%` 改为 `emayili::to(c("收件人邮箱@gmail.com")) %>%`
        
        c) `username = "sender@mail.com"` 改为 `username = "上面的发件人邮箱@mail.com"`
        d) `password = "email password"` 改为 ``password = "邮箱密码"`
