import call from '@ohos.telephony.call'
import observer from '@ohos.telephony.observer'

@Entry
@Component
struct Index {
  @State phoneNum: string = "13888888888"
  @State signalStrength: string[] = []

  onSignalChange(signalInfo) {
    this.signalStrength = signalInfo.map(it => `Type: ${it.signalType}, Level: ${it.signalLevel}, Dbm: ${it.dBm}`)
  }

  aboutToAppear() {
    try {
      observer.on('signalInfoChange', this.onSignalChange);
    } catch (e) {
      console.error(e)
    }
  }

  aboutToDisappear() {
    try {
      observer.off('signalInfoChange', this.onSignalChange)
    } catch (e) {
      console.error(e)
    }
  }

  build() {
    Row() {
      Column() {
        ForEach(this.signalStrength, (it) => {
          Text(it)
        })


        TextInput({ placeholder: "请输入电话号码", text: this.phoneNum })
          .onChange((text) => {
            this.phoneNum = text
          })
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button() {
          Text("拨打电话")
        }
        .onClick(() => {
          // 跳转拨号界面
          // 不需要额外权限
          // See: https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/jumping-to-the-dial-screen-0000001477981073-V2
          call.makeCall(this.phoneNum)
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}