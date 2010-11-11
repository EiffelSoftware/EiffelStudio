#ifndef _COMMON_H_
#define _COMMON_H_
#define CINTERFACE
#include <windows.h>
#include <ObjBase.h>
#include <initguid.h>
#include <Uiribbon.h>
//#include "resource.h"

DEFINE_GUID(IID_IUIFRAMEWORK, 0xf4f0385d, 0x6872, 0x43a8, 0xad, 0x09, 0x4c, 0x33, 0x9c, 0xb3, 0xf5, 0xc5);
DEFINE_GUID(IID_IUIAPPLICATION, 0xd428903c, 0x729a, 0x491d, 0x91, 0x0d, 0x68, 0x2a, 0x08, 0xff, 0x25, 0x22);

#endif

BOOL InitializeFramework(HWND hWnd);
void DestroyRibbon();