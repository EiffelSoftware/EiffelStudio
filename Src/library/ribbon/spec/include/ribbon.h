#include "common.h"
//#include "command.c"

BOOL InitializeFramework(HWND hWnd);
void DestroyRibbon();
HRESULT GetRibbonHeight(UINT* ribbonHeight, IUIFramework *a_framework);
HRESULT SetModes(INT32 iModes, IUIFramework *a_framework);
HRESULT GetUICommandProperty(UINT32 commandId, REFPROPERTYKEY key, PROPVARIANT *value, IUIFramework *a_framework);
HRESULT SetUICommandProperty(UINT32 commandId, REFPROPERTYKEY key, PROPVARIANT *value, IUIFramework *a_framework);
HRESULT InvalidateUICommand(UINT32 commandId, UI_INVALIDATIONS flags, const PROPERTYKEY *key, IUIFramework *a_framework);
IUIFramework *GetRibbonFramwork();
IUICommandHandler *GetCommandHandler();
BOOL CreateIUIImageFromBitmap (HBITMAP bitmap, IUIImage **image);
HRESULT QueryInterfaceIUICollectionWithPropVariant (PROPVARIANT * a_prop_variant);
IUICollection * GetUICollection ();
