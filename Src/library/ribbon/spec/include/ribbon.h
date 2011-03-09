#include "common.h"

#ifdef __cplusplus
extern "C" {
#endif

extern IUIFramework *g_pFramework;

extern EIF_POINTER InitializeFramework(HWND hWnd);
extern IUIApplication *GetUIApplication();
extern BOOL CreateIUIImageFromBitmap (HBITMAP bitmap, IUIImage **image);
extern HRESULT QueryInterfaceIUICollectionWithPropVariant (PROPVARIANT * a_prop_variant);
extern IUICollection * GetUICollection ();

#ifdef __cplusplus
}
#endif
