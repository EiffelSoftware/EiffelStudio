/*****************************************************************************/
/* wel_enum_child_windows.h                                                  */
/*****************************************************************************/
/* Used to enumerate the children of a given window                         */
/*****************************************************************************/

#ifndef __WEL_ENUM_CHILD_WINDOWS_H_
#define __WEL_ENUM_CHILD_WINDOWS_H_

#ifdef __cplusplus
extern "C" {
#endif

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_enum_child_windows                                             */
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
void cwel_enum_child_windows_procedure (void *pCurrObject, void *fnptr, HWND hWndParent);

#ifdef __cplusplus
}
#endif

#endif /* __WEL_ENUM_CHILD_WINDOWS_H_ */
