/*****************************************************************************/
/* wel_mousehook.h                                                           */
/*****************************************************************************/
/* Used to monitor mouse messages for the pick and drop mechanism under      */
/* Windows                                                                   */
/*****************************************************************************/
#include "eif_eiffel.h"
#include <windows.h>

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_hook_mouse                                                     */
/* ARGS: hHookWindow: Handle of the window registering the hook.             */
/*---------------------------------------------------------------------------*/
/* Capture all mouse messages and redirect them to `hWnd'.                   */
/* Return TRUE if everything went fine, FALSE otherwise. If `wel_hook.dll'   */
/* cannot be loaded an error box is displayed                                */
/*---------------------------------------------------------------------------*/
EIF_BOOLEAN cwel_hook_mouse(HWND hWnd);

/*---------------------------------------------------------------------------*/
/* FUNC: cwel_unhook_mouse                                                   */
/* ARGS:                                                                     */
/*---------------------------------------------------------------------------*/
/* Stop capturing all mouse messages                                         */
/* Return TRUE if everything went fine, FALSE otherwise.                     */
/*---------------------------------------------------------------------------*/
EIF_BOOLEAN cwel_unhook_mouse();
