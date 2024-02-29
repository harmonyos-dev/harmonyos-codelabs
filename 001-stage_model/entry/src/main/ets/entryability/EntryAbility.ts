import UIAbility from '@ohos.app.ability.UIAbility';
import hilog from '@ohos.hilog';
import window from '@ohos.window';
import hub from '@ohos.events.emitter';
import {EV_COLOR_CHANGE, EV_BRIGHT_CHANGE, EV_IMMERSE_CHANGE, EV_FLOAT_WINDOW} from '../events';

export default class EntryAbility extends UIAbility {
  onCreate(want, launchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy() {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage) {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err, data) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content. Data: %{public}s', JSON.stringify(data) ?? '');
    });

    // windowStage.getMainWindowSync().setWindowBrightness(0.5);

    hub.on({eventId:EV_COLOR_CHANGE}, (data) => {
      hilog.info(0x0000, 'EV_COLOR_CHANGE', 'Received color change event: %{public}s', JSON.stringify(data) ?? '');

      windowStage.getMainWindowSync().setWindowBackgroundColor(data.data['color']);
    });

    hub.on({eventId:EV_BRIGHT_CHANGE}, (data) => {
      hilog.info(0x0000, 'EV_BRIGHT_CHANGE', 'Received bright change event: %{public}s', JSON.stringify(data) ?? '');

      windowStage.getMainWindowSync().setWindowBrightness(data.data['bright'] / 10, (err) => {
        if (err.code) {
          hilog.error(0x0000, 'EV_BRIGHT_CHANGE', 'Failed to set the window brightness. Cause: %{public}s', JSON.stringify(err) ?? '');
          return;
        }
        hilog.info(0x0000, 'EV_BRIGHT_CHANGE', 'Succeeded in setting the window brightness');
      })
    });

    hub.on({eventId:EV_IMMERSE_CHANGE}, (data) => {
      hilog.info(0x0000, 'EV_IMMERSE_CHANGE', 'Received immerse change event: %{public}s', JSON.stringify(data) ?? '');

      windowStage.getMainWindowSync().setWindowSystemBarEnable(data.data['immerse'] ? [] : ['status', 'navigation']);
    });

    let windowClass: window.Window | null = null;
    hub.on({eventId:EV_FLOAT_WINDOW}, (data) => {
      hilog.info(0x0000, 'EV_FLOAT_WINDOW', 'Received float window event: %{public}s', JSON.stringify(data) ?? '');

      if (data.data["create"]) {
        window.createWindow({name: 'my float window', windowType:window.WindowType.TYPE_FLOAT, ctx: this.context}, (err, data) => {
          if (err.code) {
            hilog.error(0x0000, 'EV_FLOAT_WINDOW', 'Failed to create the float window. Cause: %{public}s', JSON.stringify(err) ?? '');
            return;
          }
          hilog.info(0x0000, 'EV_FLOAT_WINDOW', 'Succeeded in creating the float window. Data: %{public}s', JSON.stringify(data) ?? '');

          windowClass = data;
        });
      } else {
        windowClass?.destroyWindow((err, data) => {
          if (err.code) {
            hilog.error(0x0000, 'testTag', 'Failed to destroy the float window. Cause: %{public}s', JSON.stringify(err) ?? '');
            return;
          }
          hilog.info(0x0000, 'testTag', 'Succeeded in destroying the float window. Data: %{public}s', JSON.stringify(data) ?? '');
          windowClass = null;
        });
      }

    });
  }

  onWindowStageDestroy() {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground() {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground() {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
