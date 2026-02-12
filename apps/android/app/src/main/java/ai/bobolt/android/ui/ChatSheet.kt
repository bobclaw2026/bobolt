package ai.bobolt.android.ui

import androidx.compose.runtime.Composable
import ai.bobolt.android.MainViewModel
import ai.bobolt.android.ui.chat.ChatSheetContent

@Composable
fun ChatSheet(viewModel: MainViewModel) {
  ChatSheetContent(viewModel = viewModel)
}
