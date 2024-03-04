import webView from '@ohos.web.webview';

@Entry
@Component
struct Index {
  @State url: string = "https://www.baidu.com/"

  controller: webView.WebviewController = new webView.WebviewController()

  build() {
    Column() {
      Search({value: this.url})
        .onSubmit((value) => {
          this.url = value
          this.controller.loadUrl(value)
        })
        .searchButton("加载")
        .width("100%")
      // Web 组件提供了 src 和 controller 两个属性，分别用于指定加载的网页地址和控制器。
      // 通过设置 src 属性，可以指定加载的网页地址。
      // 通过设置 controller 属性，可以指定控制器。
      // See: https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/in-app-web-based-content-provisioning-0000001500514249-V2
      Web({ src: this.url, controller: this.controller})
        .width("100%")
        .height("100%")
    }
  }
}