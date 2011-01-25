#include "common.h"
//#include "command.c"

BOOL InitializeFramework(HWND hWnd);
void DestroyRibbon();
HRESULT GetRibbonHeight(UINT* ribbonHeight);
HRESULT SetModes(INT32 iModes);
HRESULT GetUICommandPropertyBoolean(UINT32 commandId, PROPVARIANT *value);