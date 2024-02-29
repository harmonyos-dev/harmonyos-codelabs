import hub from "@ohos.events.emitter";
import { EV_COLOR_CHANGE, EV_BRIGHT_CHANGE, EV_IMMERSE_CHANGE, EV_FLOAT_WINDOW } from "../events";

@Entry
@Component
struct Index {
  @State message: string = "Hello World"
  @State bright: number = 5;

  @Builder
  windowProps() {
    Text("窗口属性：")

    Button("红")
      .onClick(() => {
        hub.emit({ eventId: EV_COLOR_CHANGE }, { data: { color: '#FF0000' } })
      })
    Button("绿")
      .onClick(() => {
        hub.emit({ eventId: EV_COLOR_CHANGE }, { data: { color: '#00FF00' } })
      })
    Button("蓝")
      .onClick(() => {
        hub.emit({ eventId: EV_COLOR_CHANGE }, { data: { color: '#0000FF' } })
      })
    Button("亮度+")
      .onClick(() => {
        this.bright += 1
        if (this.bright > 10) {
          this.bright = 10
        }
        hub.emit({ eventId: EV_BRIGHT_CHANGE }, { data: { bright: this.bright } })
      })
    Button("亮度-")
      .onClick(() => {
        this.bright -= 1
        if (this.bright < 0) {
          this.bright = 0
        }
        hub.emit({ eventId: EV_BRIGHT_CHANGE }, { data: { bright: this.bright } })
      })
    Button("重置")
      .onClick(() => {
        hub.emit({ eventId: EV_COLOR_CHANGE }, { data: { color: "#FFFFFF" } })

        this.bright = 5
        hub.emit({ eventId: EV_BRIGHT_CHANGE }, { data: { bright: this.bright } })
      })
  }

  @Builder
  immerse() {
    Text("沉浸属性：")

    Button("开启")
      .onClick(() => {
        hub.emit({ eventId: EV_IMMERSE_CHANGE }, { data: { immerse: true } })
      })

    Button("关闭")
      .onClick(() => {
        hub.emit({ eventId: EV_IMMERSE_CHANGE }, { data: { immerse: false } })
      })
  }

  @Builder
  floatWindow() {
    Text("悬浮窗：")

    Button("开启")
      .onClick(() => {
        hub.emit({ eventId: EV_FLOAT_WINDOW }, { data: { floatWindow: true } })
      })

    Button("关闭")
      .onClick(() => {
        hub.emit({ eventId: EV_FLOAT_WINDOW }, { data: { floatWindow: false } })
      })
  }

  build() {
    Column() {
      HorizontalScrollContainer({child: this.windowProps})
      HorizontalScrollContainer({child: this.immerse})
      HorizontalScrollContainer({child: this.floatWindow})
    }
    .height('100%')
  }
}

@Component
struct HorizontalScrollContainer {
  @BuilderParam child: () => void;

  build() {
    Scroll() {
      Row() {
        /* children */
        this.child()
      }
      .padding({ top: 10, left: 10, right: 10, bottom: 20 })
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
  }
}


@Component
struct Parent {
  build() {
    Scroll() {
      Row() {
        /* children */
        // @Component 应该提供个 this.children() 方法, 里面就是 {} 里的东西
        // 如：
        // ```
        // Parent() {
        //   Child()
        //   Child2()
        // }
        // ```
        // 然后 Parent 的 build 方法里就可以直接调用 this.children()
        // this.children() 就等同于：
        // ```
        // Child()
        // Child2()
        // ```
      }
      .padding({ top: 10, left: 10, right: 10, bottom: 20 })
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
  }
}