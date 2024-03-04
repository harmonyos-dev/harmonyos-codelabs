// 通知简介
// 应用可以通过通知接口发送通知消息，终端用户可以通过通知栏查看通知内容，也可以点击通知来打开应用。
// 通知常见的使用场景：
// - 显示接收到的短消息、即时消息等。
// - 显示应用的推送消息，如广告、版本更新等。
// - 显示当前正在进行的事件，如下载等。
//
// HarmonyOS通过ANS（Advanced Notification Service，通知系统服务）对通知类型的消息进行管理，支持多种通知类型，如基础类型通知、进度条类型通知。
// See: https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V2/1_3_u901a_u77e5-0000001427902316-V2

import NotificationManager from '@ohos.notificationManager';
import image from '@ohos.multimedia.image';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Row() {
        Text("普通文本类型通知")
        Button("发送通知")
          .onClick(() => {
            NotificationManager.publish({
              id: 1,
              content: {
                contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
                normal: {
                  title: "普通文本类型通知",
                  text: "这是一条普通文本类型通知",
                  additionalText: "这是一条普通文本类型通知的附加文本"
                }
              }
            });
          });
      }

      Row() {
        Text("长文本类型通知")
        Button("发送通知")
          .onClick(() => {
            NotificationManager.publish({
              id: 2,
              content: {
                contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_LONG_TEXT,
                longText: {
                  title: "长文本类型通知",
                  text: "这是一条长文本类型通知",
                  additionalText: "这是一条长文本类型通知的附加文本",
                  longText: "这是一条长文本类型通知的长文本",
                  briefText: "这是一条长文本类型通知的简短描述",
                  expandedTitle: "长文本类型通知展开后的标题",
                }
              }
            });
          });
      }

      Row() {
        Text("多行文本类型通知")
        Button("发送通知")
          .onClick(() => {
            NotificationManager.publish({
              id: 3,
              content: {
                contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_MULTILINE,
                multiLine: {
                  title: "多行文本类型通知",
                  text: "这是一条多行文本类型通知",
                  briefText: "多行文本类型通知简单描述",
                  longTitle: "这是一条多行文本类型通知的附加文本",
                  lines: [
                    "这是一条多行文本类型通知的第一行",
                    "这是一条多行文本类型通知的第二行",
                    "这是一条多行文本类型通知的第三行",
                  ]
                }
              }
            });
          });
      }

      Row() {
        Text("图片类型通知")
        Button("发送通知")
          .onClick(async () => {
            const raw = await getContext().resourceManager.getMediaContent($r("app.media.icon").id);
            const pixelMap =  await image.createPixelMap(raw, {size: {width: 114, height: 114,}, pixelFormat: 3,});
            // TODO(CGQAQ): image.createPixelMap returns a Promise<PixelMap>, but actually returned undefined, don't know why

            NotificationManager.publish({
              id: 4,
              content: {
                contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_PICTURE,
                picture: {
                  title: "图片类型通知",
                  text: "这是一条图片类型通知",
                  additionalText: "这是一条图片类型通知的附加文本",
                  briefText: "图片类型通知简单描述",
                  expandedTitle: "图片类型通知展开后的标题",
                  picture: pixelMap,
                }
              }
            }, (err) => {
              if (err) {
                console.error(`Failed to publish notification. Code is ${err.code}, message is ${err.message}`);
                return;
              }
              console.info('Succeeded in publishing notification.');
            });
          });
      }
    }
  }
}