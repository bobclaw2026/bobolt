package ai.bobolt.android.protocol

import org.junit.Assert.assertEquals
import org.junit.Test

class BoboltProtocolConstantsTest {
  @Test
  fun canvasCommandsUseStableStrings() {
    assertEquals("canvas.present", BoboltCanvasCommand.Present.rawValue)
    assertEquals("canvas.hide", BoboltCanvasCommand.Hide.rawValue)
    assertEquals("canvas.navigate", BoboltCanvasCommand.Navigate.rawValue)
    assertEquals("canvas.eval", BoboltCanvasCommand.Eval.rawValue)
    assertEquals("canvas.snapshot", BoboltCanvasCommand.Snapshot.rawValue)
  }

  @Test
  fun a2uiCommandsUseStableStrings() {
    assertEquals("canvas.a2ui.push", BoboltCanvasA2UICommand.Push.rawValue)
    assertEquals("canvas.a2ui.pushJSONL", BoboltCanvasA2UICommand.PushJSONL.rawValue)
    assertEquals("canvas.a2ui.reset", BoboltCanvasA2UICommand.Reset.rawValue)
  }

  @Test
  fun capabilitiesUseStableStrings() {
    assertEquals("canvas", BoboltCapability.Canvas.rawValue)
    assertEquals("camera", BoboltCapability.Camera.rawValue)
    assertEquals("screen", BoboltCapability.Screen.rawValue)
    assertEquals("voiceWake", BoboltCapability.VoiceWake.rawValue)
  }

  @Test
  fun screenCommandsUseStableStrings() {
    assertEquals("screen.record", BoboltScreenCommand.Record.rawValue)
  }
}
