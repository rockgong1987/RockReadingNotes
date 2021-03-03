# Instant MinGW
## Quick Start
1. Add source files
```cpp
#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include "resources.h"

BOOL CALLBACK DialogPro(HWND hwndDlg, UINT uMsg, WPARAM wParam, LPARAM lParam) {
    switch(uMsg) {
        case WM_CLOSE:
            EndDialog(hwndDlg, 0);
            return TRUE;
        case WM_COMMAND:
            switch(LOWORD(wParam)) {
                case IDC_BTN_QUIT:
                    EndDialog(hwndDlg, 0);
                    return TRUE;
                case IDC_BTN_TEST:
                    MessageBox(hwndDlg, "Message text", "Information",  MB_ICONIFORMATION);
                    return TRUE;
            }
    }
    return FALSE;
}

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nShowCmd) {
    return DialogBox(hInstance, MAKEINTRESOURCE(DLG_MAIN), NULL, (DLGPROC)DialogProc);
}
```
```rc
#include "reources.h"

DLG_MAIN DIALOGEX 6, 5, 138, 75
CAPTION "Typical Windows Application"
FONT 10, "Tahoma"
STYLE 0x10CE0804
BEGIN
  CONTROL "&Message", IDC_BTN_TEST, "Button", 0x10010000, 46, 15, 46, 15
  CONTROL "&Quit", IDC_BTN_QUIT, "Button", 0x10010000, 46, 45, 46, 15
END
```
```c
#include <windows.h>
#define DLG_MAIN 100
#define IDC_BTN_TEST 101
#define IDC_BTN_QUIT 102
```
2. Adding a Make file
```makefile
win32-app.exe:  main.cpp resource.rc.res.o
    g++ -o wind32-app.exe main.cpp resource.rc.res.o
resource.rc.res.o:  resource.rc
    windres -o resource.rc.res.o - resource.rc
clean:  
    rm -f *.o win32-app.exe
```