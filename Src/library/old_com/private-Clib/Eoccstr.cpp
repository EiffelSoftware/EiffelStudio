/////////////////////////////////////////////////////////////////////////////
//
//     EOCCSTR.CPP    Copyright (c) 1996 by SiG Computer
//
//     Version:       0.00
//
//     Eiffel OLE2 Library
//
//     OCC Data structures suport.
//
//     Functions:
//       {{EOLE_MESSAGE}}
//          eole2_msg_allocate
//       {{EOLE_PALETTE}}
//          eole2_palette_allocate
//       {{EOLE_RECT}}
//          eole2_rect_allocate
//       {{EOLE_SIZE}}
//          eole2_size_allocate
//       {{EOLE_MENUGROUPWIDTHS}}
//          eole2_menugroupwidths_allocate
//       {{EOLE_WINDOW_CONTEXT}}
//          eole2_wndctx_allocate
//          eole2_wndctx_get_inplace_frame
//          eole2_wndctx_get_inplace_ui_window
//          eole2_wndctx_get_pos_rect
//          eole2_wndctx_get_clip_rect
//          eole2_wndctx_get_inplace_frame_info
//          eole2_wndctx_set_inplace_frame
//          eole2_wndctx_set_inplace_ui_window
//          eole2_wndctx_set_pos_rect
//          eole2_wndctx_set_clip_rect
//          eole2_wndctx_set_inplace_frame_info
//       {{EOLE_INPLACE_FRAME_INFO}}
//          eole2_inplace_frame_info_allocate
//       {{EOLE_ADVISEINFO}}
//          eole2_adviseinfo_allocate
//       {{EOLE_CONTROLINFO}}
//          eole2_controlinfo_allocate
//       {{EOLE_FORMATETC}}
//          eole2_formatetc_allocate
//       {{EOLE_STATDATA}}
//          eole2_statdata_allocate
//       {{EOLE_STGMEDIUM}}
//          eole2_stgmedium_allocate
//       {{EOLE_TARGETDEVICE}}
//          eole2_targetdevice_allocate
//       {{EOLE_OLEVERB}}
//          eole2_oleverb_allocate
//       {{EOLE_POINTF}}
//          eole2_pointf_allocate
//       {{EOLE_POINTL}}
//          eole2_pointl_allocate
//       {{EOLE_CONNECTDATA}}
//       {{EOLE_FONT}}
//     Globals:
//       None.
//     Notes:
//       None.
//

#include "eifole.h"

/////// EOLE_MESSAGE ////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
//
// eole2_msg_allocate
//
// Purpose:
//    Allocate a real MSG structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pointer to allocated MSG data structure.
//

extern "C" EIF_POINTER eole2_msg_allocate( void )
{
    return (EIF_POINTER)calloc( 1, sizeof( MSG ) );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_msg_set_hwnd
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_msg_set_hwnd( EIF_POINTER pThis, EIF_INTEGER hwnd )
{
    ((MSG*)pThis)->hwnd = (HWND)hwnd;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_msg_set_message
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_msg_set_message( EIF_POINTER pThis, EIF_INTEGER message )
{
    ((MSG*)pThis)->message = (UINT)message;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_msg_set_wparam
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_msg_set_wparam( EIF_POINTER pThis, EIF_INTEGER wparam )
{
    ((MSG*)pThis)->wParam = (WPARAM)wparam;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_msg_set_lparam
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_msg_set_lparam( EIF_POINTER pThis, EIF_INTEGER lparam )
{
    ((MSG*)pThis)->lParam = (LPARAM)lparam;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_msg_set_time
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_msg_set_time( EIF_POINTER pThis, EIF_INTEGER time )
{
    ((MSG*)pThis)->time = (DWORD)time;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_msg_set_point
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_msg_set_point( EIF_POINTER pThis,
      EIF_INTEGER x, EIF_INTEGER y )
{
    ((MSG*)pThis)->pt.x = (int)x;
    ((MSG*)pThis)->pt.y = (int)y;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_msg_get_hwnd
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_msg_get_hwnd( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((MSG*)pThis)->hwnd );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_msg_get_message
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_msg_get_message( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((MSG*)pThis)->message );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_msg_get_wparam
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_msg_get_wparam( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((MSG*)pThis)->wParam );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_msg_get_lparam
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_msg_get_lparam( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((MSG*)pThis)->lParam );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_msg_get_time
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_msg_get_time( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((MSG*)pThis)->time );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_msg_get_point_x
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_msg_get_point_x( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((MSG*)pThis)->pt.x );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_msg_get_point_y
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_msg_get_point_y( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((MSG*)pThis)->pt.y );
}


/////// EOLE_PALETTE ////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_palette_allocate
//
// Purpose:
//    Allocate a real LOGPALETTE structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pointer to allocated LOGPALETTE data structure.
//

extern "C" EIF_POINTER eole2_palette_allocate (void)
{
    return (EIF_POINTER)calloc (1, sizeof (LOGPALETTE));
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_palette_set_version
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_palette_set_version(
      EIF_POINTER pThis, EIF_INTEGER version )
{
    ((LOGPALETTE*)pThis)->palVersion = (WORD)version;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_palette_set_entry
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_palette_set_entry( EIF_POINTER pThis,
      EIF_INTEGER index,
      EIF_INTEGER red, EIF_INTEGER green, EIF_INTEGER blue,
      EIF_INTEGER flags )
{
    if( index >= ((LOGPALETTE*)pThis)->palNumEntries )
    {
        return;
    }

    PALETTEENTRY* pPe = &( ((LOGPALETTE*)pThis)->palPalEntry[index] );

    pPe->peRed   = (BYTE)red;
    pPe->peGreen = (BYTE)green;
    pPe->peBlue  = (BYTE)blue;
    pPe->peFlags = (BYTE)flags;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_palette_get_version
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_palette_get_version( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((LOGPALETTE*)pThis)->palVersion );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_palette_get_num_entries
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_palette_get_num_entries( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((LOGPALETTE*)pThis)->palNumEntries );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_palette_get_entry_red
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_palette_get_entry_red( EIF_POINTER pThis,
      EIF_INTEGER index )
{
    return (EIF_INTEGER)( ((LOGPALETTE*)pThis)->palPalEntry[index].peRed );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_palette_get_entry_green
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_palette_get_entry_green( EIF_POINTER pThis,
      EIF_INTEGER index )
{
    return (EIF_INTEGER)( ((LOGPALETTE*)pThis)->palPalEntry[index].peGreen );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_palette_get_entry_blue
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_palette_get_entry_blue( EIF_POINTER pThis,
      EIF_INTEGER index )
{
    return (EIF_INTEGER)( ((LOGPALETTE*)pThis)->palPalEntry[index].peBlue );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_palette_get_entry_flags
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_palette_get_entry_flags( EIF_POINTER pThis,
      EIF_INTEGER index )
{
    return (EIF_INTEGER)( ((LOGPALETTE*)pThis)->palPalEntry[index].peFlags );
}


/////// EOLE_RECT ///////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_rect_allocate
//
// Purpose:
//    Allocate a real RECT structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pointer to allocated RECT data structure.
//

extern "C" EIF_POINTER eole2_rect_allocate (void)
{
   return (EIF_POINTER)calloc (1, sizeof (RECT));
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_rect_set_left
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_rect_set_left( EIF_POINTER pThis, EIF_INTEGER left )
{
    ((RECT*)pThis)->left = left;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_rect_set_right
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_rect_set_right( EIF_POINTER pThis, EIF_INTEGER right )
{
    ((RECT*)pThis)->right = right;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_rect_set_top
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_rect_set_top( EIF_POINTER pThis, EIF_INTEGER top )
{
    ((RECT*)pThis)->top = top;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_rect_set_bottom
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_rect_set_bottom( EIF_POINTER pThis, EIF_INTEGER bottom )
{
    ((RECT*)pThis)->bottom = bottom;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_rect_set_rect
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_rect_set_rect( EIF_POINTER pThis,
      EIF_INTEGER left, EIF_INTEGER top,
      EIF_INTEGER right, EIF_INTEGER bottom )
{
    SetRect((RECT*)pThis, left, top, right, bottom );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_rect_get_left
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_rect_get_left( EIF_POINTER pThis )
{
   return ( (RECT*)pThis )->left;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_rect_get_right
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_rect_get_right( EIF_POINTER pThis )
{
   return ( (RECT*)pThis )->right;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_rect_get_top
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_rect_get_top( EIF_POINTER pThis )
{
   return ( (RECT*)pThis )->top;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_rect_get_bottom
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_rect_get_bottom( EIF_POINTER pThis )
{
   return ( (RECT*)pThis )->bottom;
}


/////// EOLE_SIZE ///////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_size_allocate
//
// Purpose:
//    Allocate a real SIZE structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pointer to allocated SIZE data structure.
//



extern "C" EIF_POINTER eole2_size_allocate (void)
{
   return (EIF_POINTER)calloc (1, sizeof (SIZE));
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_size_set_cx
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_size_set_cx( EIF_POINTER pThis, EIF_INTEGER cx )
{
    ( (SIZE*)pThis )->cx = cx;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_size_set_cy
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_size_set_cy( EIF_POINTER pThis, EIF_INTEGER cy )
{
    ( (SIZE*)pThis )->cy = cy;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_size_set_size
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_size_set_size( EIF_POINTER pThis,
      EIF_INTEGER cx, EIF_INTEGER cy )
{
    ( (SIZE*)pThis )->cx = cx;
    ( (SIZE*)pThis )->cy = cy;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_size_get_cx
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_size_get_cx( EIF_POINTER pThis )
{
    return ( (SIZE*)pThis )->cx;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_size_get_cy
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_size_get_cy( EIF_POINTER pThis )
{
    return ( (SIZE*)pThis )->cy;
}


/////// EOLE_MENUGROUPWIDTHS ////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_menugroupwidths_allocate
//
// Purpose:
//    Allocate a real OLEMENUGROUPWIDTHS structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pointer to allocated OLEMENUGROUPWIDTHS data structure.
//

extern "C" EIF_POINTER eole2_menugroupwidths_allocate (void)
{
   return (EIF_POINTER)calloc (1, sizeof (OLEMENUGROUPWIDTHS));
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_menugroupwidths_set_width
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_menugroupwidths_set_width(
      EIF_POINTER pThis, EIF_INTEGER index, EIF_INTEGER width )
{
    if( index < 0 || index >= 6 )
    {
        return;
    }

    ( (OLEMENUGROUPWIDTHS*)pThis )->width[index] = width;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_menugroupwidths_get_width
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_menugroupwidths_get_width(
      EIF_POINTER pThis, EIF_INTEGER index )
{
    if( index < 0 || index >= 6 )
    {
        return 0;
    }

    return (EIF_INTEGER)( ( (OLEMENUGROUPWIDTHS*)pThis )->width[index] );
}


/////// EOLE_WINDOW_CONTEXT /////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
//
// eole2_wndctx_allocate
//
// Purpose:
//    Allocate a real WINDOWCONTEXT structure.
//
// Parameters:
//    None.
//
// Return Value:
//    None.
//

extern "C" EIF_POINTER eole2_wndctx_allocate (void)
{
   LPWINDOWCONTEXT lpWndCtx = (LPWINDOWCONTEXT)calloc (1, sizeof (WINDOWCONTEXT));
   lpWndCtx->fiFrameInfo.cb = sizeof (OLEINPLACEFRAMEINFO);
   return (EIF_POINTER)lpWndCtx;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_wndctx_get_inplace_frame
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_wndctx_get_inplace_frame (EIF_POINTER pWndCtxThis) {
   return (EIF_POINTER)((LPWINDOWCONTEXT)pWndCtxThis)->pFrame;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_wndctx_get_inplace_ui_window
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_wndctx_get_inplace_ui_window (EIF_POINTER pWndCtxThis) {
   return (EIF_POINTER)((LPWINDOWCONTEXT)pWndCtxThis)->pDoc;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_wndctx_get_pos_rect
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_wndctx_get_pos_rect (EIF_POINTER pWndCtxThis) {
   return (EIF_POINTER)&(((LPWINDOWCONTEXT)pWndCtxThis)->rcPosRect);
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_wndctx_get_clip_rect
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_wndctx_get_clip_rect (EIF_POINTER pWndCtxThis) {
   return (EIF_POINTER)&(((LPWINDOWCONTEXT)pWndCtxThis)->rcClipRect);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_wndctx_get_inplace_frame_info
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_wndctx_get_inplace_frame_info (EIF_POINTER pWndCtxThis) {
   return (EIF_POINTER)&(((LPWINDOWCONTEXT)pWndCtxThis)->fiFrameInfo);
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_wndctx_set_inplace_frame
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_wndctx_set_inplace_frame (EIF_POINTER pWndCtxThis,
                                                EIF_POINTER pFrame) {
   ((LPWINDOWCONTEXT)pWndCtxThis)->pFrame = (LPOLEINPLACEFRAME)pFrame;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_wndctx_set_inplace_ui_window
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_wndctx_set_inplace_ui_window (EIF_POINTER pWndCtxThis,
                                                          EIF_POINTER pDoc) {
   ((LPWINDOWCONTEXT)pWndCtxThis)->pDoc = (LPOLEINPLACEUIWINDOW)pDoc;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_wndctx_set_pos_rect
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_wndctx_set_pos_rect (EIF_POINTER pWndCtxThis,
                                                    EIF_POINTER prcPosRect) {
   CopyRect (&(((LPWINDOWCONTEXT)pWndCtxThis)->rcPosRect), (LPRECT)prcPosRect);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_wndctx_set_clip_rect
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_wndctx_set_clip_rect (EIF_POINTER pWndCtxThis,
                                                   EIF_POINTER prcClipRect) {
   CopyRect (&(((LPWINDOWCONTEXT)pWndCtxThis)->rcClipRect), (LPRECT)prcClipRect);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_wndctx_set_inplace_frame_info
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_wndctx_set_inplace_frame_info (EIF_POINTER pWndCtxThis,
                                                 EIF_POINTER lpfiFrameInfo) {
   ((LPWINDOWCONTEXT)pWndCtxThis)->fiFrameInfo = *(LPOLEINPLACEFRAMEINFO)lpfiFrameInfo;
}

/////// EOLE_INPLACE_FRAME_INFO /////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_inplace_frame_info_allocate
//
// Purpose:
//    Allocate a real OLEINPLACEFRAMEINFO structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pounter to allocated OLEINPLACEFRAMEINFO data structure.
//

extern "C" EIF_POINTER eole2_inplace_frame_info_allocate (void)
{
    EIF_POINTER ptr;

    ptr = (EIF_POINTER)calloc (1, sizeof (OLEINPLACEFRAMEINFO));
    ( (OLEINPLACEFRAMEINFO*)ptr )->cb = sizeof( OLEINPLACEFRAMEINFO );

    return ptr;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ipfi_set_cb
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_ipfi_set_cb(
      EIF_POINTER pThis, EIF_INTEGER cb )
{
    ( (OLEINPLACEFRAMEINFO*)pThis )->cb = (UINT)cb;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ipfi_set_mdi_app_flag
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_ipfi_set_mdi_app_flag(
      EIF_POINTER pThis, EIF_BOOLEAN flag )
{
    ( (OLEINPLACEFRAMEINFO*)pThis )->fMDIApp = (BOOL)flag;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ipfi_set_frame_hwnd
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_ipfi_set_frame_hwnd(
      EIF_POINTER pThis, EIF_INTEGER hwnd )
{
    ( (OLEINPLACEFRAMEINFO*)pThis )->hwndFrame = (HWND)hwnd;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ipfi_set_accel_handle
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_ipfi_set_accel_handle(
      EIF_POINTER pThis, EIF_INTEGER haccel )
{
    ( (OLEINPLACEFRAMEINFO*)pThis )->haccel = (HACCEL)haccel;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ipfi_set_accel_entries
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_ipfi_set_accel_entries(
      EIF_POINTER pThis, EIF_INTEGER entries )
{
    ( (OLEINPLACEFRAMEINFO*)pThis )->cAccelEntries = (UINT)entries;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ipfi_get_cb
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_ipfi_get_cb( EIF_POINTER pThis )
{
    return ( (OLEINPLACEFRAMEINFO*)pThis )->cb;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ipfi_get_mdi_app_flag
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_BOOLEAN eole2_ipfi_get_mdi_app_flag( EIF_POINTER pThis )
{
    return ( (OLEINPLACEFRAMEINFO*)pThis )->fMDIApp;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ipfi_get_frame_hwnd
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_ipfi_get_frame_hwnd( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ( (OLEINPLACEFRAMEINFO*)pThis )->hwndFrame );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ipfi_get_accel_handle
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_ipfi_get_accel_handle( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ( (OLEINPLACEFRAMEINFO*)pThis )->haccel );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ipfi_get_accel_entries
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_ipfi_get_accel_entries( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ( (OLEINPLACEFRAMEINFO*)pThis )->cAccelEntries );
}


/////// EOLE_ADVISEINFO /////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_adviseinfo_allocate
//
// Purpose:
//    Allocate a real ADVISEINFO structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pounter to allocated ADVISEINFO data structure.
//

extern "C" EIF_POINTER eole2_adviseinfo_allocate (void)
{
   return (EIF_POINTER)calloc (1, sizeof (ADVISEINFO));
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ai_set_aspect
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_ai_set_aspect( EIF_POINTER pThis, EIF_INTEGER aspect )
{
    ((LPADVISEINFO)pThis)->dwAspect = (DWORD)aspect;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_ai_set_advise_flag
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_ai_set_advise_flag( EIF_POINTER pThis, EIF_INTEGER flag )
{
    ((LPADVISEINFO)pThis)->advf = (DWORD)flag;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_ai_set_advise_sink
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_ai_set_advise_sink( EIF_POINTER pThis, EIF_POINTER iptr )
{
    ((LPADVISEINFO)pThis)->pAdvSink = (IAdviseSink*)iptr;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ai_get_aspect
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_ai_get_aspect( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((LPADVISEINFO)pThis)->dwAspect );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ai_get_advise_flag
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_ai_get_advise_flag( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((LPADVISEINFO)pThis)->advf );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ai_get_advise_sink
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_ai_get_advise_sink( EIF_POINTER pThis )
{
    return (EIF_POINTER)( ((LPADVISEINFO)pThis)->pAdvSink );
}


/////// EOLE_CONTROLINFO ////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_controlinfo_allocate
//
// Purpose:
//    Allocate a real CONTROLINFO structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pounter to allocated CONTROLINFO data structure.
//


extern "C" EIF_POINTER eole2_controlinfo_allocate (void)
{
    EIF_POINTER ptr;

    ptr = (EIF_POINTER)calloc (1, sizeof (CONTROLINFO));
    ((CONTROLINFO*)ptr)->cb = sizeof( CONTROLINFO );

    return ptr;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ctrlinfo_get_accel_handle
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_ctrlinfo_get_accel_handle( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((CONTROLINFO*)pThis)->hAccel );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ctrlinfo_get_accel_count
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_ctrlinfo_get_accel_count( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((CONTROLINFO*)pThis)->cAccel );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ctrlinfo_get_flags
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_ctrlinfo_get_flags( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((CONTROLINFO*)pThis)->dwFlags );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ctrlinfo_set_accel_handle
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_ctrlinfo_set_accel_handle(
      EIF_POINTER pThis, EIF_INTEGER handle )
{
    ((CONTROLINFO*)pThis)->hAccel = (HACCEL)handle;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ctrlinfo_set_accel_count
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_ctrlinfo_set_accel_count(
      EIF_POINTER pThis, EIF_INTEGER count )
{
    ((CONTROLINFO*)pThis)->cAccel = (USHORT)count;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_ctrlinfo_set_flags
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_ctrlinfo_set_flags(
      EIF_POINTER pThis, EIF_INTEGER flags )
{
    ((CONTROLINFO*)pThis)->dwFlags = (DWORD)flags;
}


/////// EOLE_FORMATETC //////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_formatetc_allocate
//
// Purpose:
//    Allocate a real FORMATETC structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pounter to allocated FORMATETC data structure.
//

extern "C" EIF_POINTER eole2_formatetc_allocate (void)
{
    return (EIF_POINTER)calloc (1, sizeof (FORMATETC));
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_fmtetc_set_clipboard_format
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_fmtetc_set_clipboard_format(
      EIF_POINTER pThis, EIF_INTEGER fmt )
{
    ( (FORMATETC*)pThis )->cfFormat = (CLIPFORMAT)fmt;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_fmtetc_set_target_device
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_fmtetc_set_target_device(
      EIF_POINTER pThis, EIF_POINTER ptd )
{
    ( (FORMATETC*)pThis )->ptd = (DVTARGETDEVICE*)ptd;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_fmtetc_set_aspect
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_fmtetc_set_aspect(
      EIF_POINTER pThis, EIF_INTEGER aspect )
{
    ( (FORMATETC*)pThis )->dwAspect = (DWORD)aspect;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_fmtetc_set_index
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_fmtetc_set_index( EIF_POINTER pThis, EIF_INTEGER index )
{
    ( (FORMATETC*)pThis )->lindex = (LONG)index;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_fmtetc_set_tymed
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_fmtetc_set_tymed( EIF_POINTER pThis, EIF_INTEGER tymed )
{
    ( (FORMATETC*)pThis )->tymed = (DWORD)tymed;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_fmtetc_get_clipboard_format
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_fmtetc_get_clipboard_format( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ( (FORMATETC*)pThis )->cfFormat );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_fmtetc_get_target_device
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_fmtetc_get_target_device( EIF_POINTER pThis )
{
    return (EIF_POINTER)( ( (FORMATETC*)pThis )->ptd );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_fmtetc_get_aspect
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_fmtetc_get_aspect( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ( (FORMATETC*)pThis )->dwAspect );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_fmtetc_get_index
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_fmtetc_get_index( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ( (FORMATETC*)pThis )->lindex );
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_fmtetc_get_tymed
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_fmtetc_get_tymed( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ( (FORMATETC*)pThis )->tymed );
}


/////// EOLE_STATDATA ///////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_statdata_allocate
//
// Purpose:
//    Allocate a real STATDATA structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pounter to allocated STATDATA data structure.
//

extern "C" EIF_POINTER eole2_statdata_allocate (void)
{
   return (EIF_POINTER)calloc (1, sizeof (STATDATA));
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_sdata_set_formatetc
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_sdata_set_formatetc(
      EIF_POINTER pThis, EIF_POINTER p_formatetc )
{
    if( p_formatetc )
    {
        memcpy( &( ((STATDATA*)pThis)->formatetc ),
                p_formatetc, sizeof( FORMATETC ) );
    }
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_sdata_set_advf
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_sdata_set_advf(
      EIF_POINTER pThis, EIF_INTEGER advf )
{
    ( (STATDATA*)pThis )->advf = (DWORD)advf;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_sdata_set_connection
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_sdata_set_connection(
      EIF_POINTER pThis, EIF_INTEGER connection )
{
    ( (STATDATA*)pThis )->dwConnection = (DWORD)connection;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_sdata_set_advise_sink
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_sdata_set_advise_sink(
      EIF_POINTER pThis, EIF_POINTER iptr_advise_sink )
{
    ( (STATDATA*)pThis )->pAdvSink = (IAdviseSink*)iptr_advise_sink;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_sdata_get_formatetc
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_sdata_get_formatetc( EIF_POINTER pThis )
{
    return (EIF_POINTER)( &( ( (STATDATA*)pThis )->formatetc ) );
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_sdata_get_advf
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_sdata_get_advf( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ( (STATDATA*)pThis )->advf );
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_sdata_get_connection
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_sdata_get_connection( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ( (STATDATA*)pThis )->dwConnection );
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_sdata_get_advise_sink
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_sdata_get_advise_sink( EIF_POINTER pThis )
{
    return (EIF_POINTER)( ( (STATDATA*)pThis )->pAdvSink );
}


/////// EOLE_STGMEDIUM //////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_stgmedium_allocate
//
// Purpose:
//    Allocate a real STGMEDIUM structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pounter to allocated STGMEDIUM data structure.
//

extern "C" EIF_POINTER eole2_stgmedium_allocate (void)
{
   return (EIF_POINTER)calloc (1, sizeof (STGMEDIUM));
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stgmedium_set_tymed
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_stgmedium_set_tymed(
      EIF_POINTER pThis, EIF_INTEGER tymed )
{
    ( (STGMEDIUM*)pThis )->tymed = (DWORD)tymed;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stgmedium_set_unknown_for_release
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_stgmedium_set_unknown_for_release(
      EIF_POINTER pThis, EIF_POINTER iptr )
{
    ( (STGMEDIUM*)pThis )->pUnkForRelease = (IUnknown*)iptr;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stgmedium_set_integer_value
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_stgmedium_set_integer_value(
      EIF_POINTER pThis, EIF_INTEGER value )
{
    ( (STGMEDIUM*)pThis )->hGlobal = (HGLOBAL)value;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stgmedium_set_pointer_value
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_stgmedium_set_pointer_value(
      EIF_POINTER pThis, EIF_POINTER value )
{
    ( (STGMEDIUM*)pThis )->pstm = (IStream*)value;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stgmedium_get_tymed
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_stgmedium_get_tymed( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ( (STGMEDIUM*)pThis )->tymed );
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stgmedium_get_unknown_for_release
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_stgmedium_get_unknown_for_release(
      EIF_POINTER pThis )
{
    return (EIF_POINTER)( ( (STGMEDIUM*)pThis )->pUnkForRelease );
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stgmedium_get_integer_value
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_stgmedium_get_integer_value( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ( (STGMEDIUM*)pThis )->hGlobal );
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_stgmedium_get_pointer_value
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_stgmedium_get_pointer_value( EIF_POINTER pThis )
{
    return (EIF_POINTER)( ( (STGMEDIUM*)pThis )->pstm );
}


/////// EOLE_TARGETDEVICE ///////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_targetdevice_allocate
//
// Purpose:
//    Allocate a real DVTARGETDEVICE structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pounter to allocated DVTARGETDEVICE data structure.
//

extern "C" EIF_POINTER eole2_targetdevice_allocate (void)
{
   return (EIF_POINTER)calloc (1, sizeof (DVTARGETDEVICE));
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_td_get_driver_name
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_td_get_driver_name( EIF_POINTER pThis )
{
    BYTE* ptr;

    ptr = &( ((DVTARGETDEVICE*)pThis)->tdData[0] );
    ptr += ((DVTARGETDEVICE*)pThis)->tdDriverNameOffset;
    return (EIF_POINTER)ptr;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_td_get_device_name
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_td_get_device_name( EIF_POINTER pThis )
{
    BYTE* ptr;

    ptr = &( ((DVTARGETDEVICE*)pThis)->tdData[0] );
    ptr += ((DVTARGETDEVICE*)pThis)->tdDeviceNameOffset;
    return (EIF_POINTER)ptr;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_td_get_port_name
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_td_get_port_name( EIF_POINTER pThis )
{
    BYTE* ptr;

    ptr = &( ((DVTARGETDEVICE*)pThis)->tdData[0] );
    ptr += ((DVTARGETDEVICE*)pThis)->tdPortNameOffset;
    return (EIF_POINTER)ptr;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_td_get_ext_dev_mode_ptr
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_td_get_ext_dev_mode_ptr( EIF_POINTER pThis )
{
    BYTE* ptr;

    ptr = &( ((DVTARGETDEVICE*)pThis)->tdData[0] );
    ptr += ((DVTARGETDEVICE*)pThis)->tdExtDevmodeOffset;
    return (EIF_POINTER)ptr;
}


/////// EOLE_OLEVERB ////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_oleverb_allocate
//
// Purpose:
//    Allocate a real OLEVERB structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pounter to allocated OLEVERB data structure.
//

extern "C" EIF_POINTER eole2_oleverb_allocate (void)
{
   return (EIF_POINTER)calloc (1, sizeof (OLEVERB));
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_verb_set_verb
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_verb_set_verb( EIF_POINTER pThis, EIF_INTEGER verb )
{
    ((OLEVERB*)pThis)->lVerb = (LONG)verb;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_verb_set_name
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_verb_set_name( EIF_POINTER pThis, EIF_POINTER name )
{
    ((OLEVERB*)pThis)->lpszVerbName = Eif2OleString( name );
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_verb_set_flags
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_verb_set_flags( EIF_POINTER pThis, EIF_INTEGER flags )
{
    ((OLEVERB*)pThis)->fuFlags = (DWORD)flags;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_verb_set_attribs
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_verb_set_attribs( EIF_POINTER pThis, EIF_INTEGER attr )
{
    ((OLEVERB*)pThis)->grfAttribs = (DWORD)attr;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_verb_get_verb
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_verb_get_verb( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((OLEVERB*)pThis)->lVerb );
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_verb_get_name
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_POINTER eole2_verb_get_name( EIF_POINTER pThis )
{
	char *result;
	Ole2CString( ((OLEVERB*)pThis)->lpszVerbName, &result );
    return (EIF_POINTER)result;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_verb_get_flags
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_verb_get_flags( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((OLEVERB*)pThis)->fuFlags );
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_verb_get_attribs
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_verb_get_attribs( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ((OLEVERB*)pThis)->grfAttribs );
}

/////// EOLE_POINTF /////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////
//
// eole2_pointf_allocate
//
// Purpose:
//    Allocate a real POINTF structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pounter to allocated POINTF data structure.
//

extern "C" EIF_POINTER eole2_pointf_allocate (void)
{
   return (EIF_POINTER)calloc (1, sizeof (POINTF));
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_pointf_set_x
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_pointf_set_x( EIF_POINTER pThis, EIF_REAL x )
{
    ( (POINTF*)pThis)->x = (float)x;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_pointf_set_y
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_pointf_set_y( EIF_POINTER pThis, EIF_REAL y )
{
    ( (POINTF*)pThis)->y = (float)y;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_pointf_set_point
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_pointf_set_point( EIF_POINTER pThis,
      EIF_REAL x, EIF_REAL y )
{
    ( (POINTF*)pThis)->x = (float)x;
    ( (POINTF*)pThis)->y = (float)y;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_pointf_get_x
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_REAL eole2_pointf_get_x( EIF_POINTER pThis )
{
    return (EIF_REAL)( ( (POINTF*)pThis)->x );
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_pointf_get_y
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_REAL eole2_pointf_get_y( EIF_POINTER pThis )
{
    return (EIF_REAL)( ( (POINTF*)pThis)->y );
}


/////// EOLE_POINTL /////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_pointl_allocate
//
// Purpose:
//    Allocate a real POINTL structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pounter to allocated POINTL data structure.
//

extern "C" EIF_POINTER eole2_pointl_allocate (void)
{
   return (EIF_POINTER)calloc (1, sizeof (POINTL));
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_pointl_set_x
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_pointl_set_x( EIF_POINTER pThis, EIF_INTEGER x )
{
    ( (POINTL*)pThis)->x = x;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_pointl_set_y
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_pointl_set_y( EIF_POINTER pThis, EIF_INTEGER y )
{
    ( (POINTL*)pThis)->y = y;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_pointl_set_point
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" void eole2_pointl_set_point( EIF_POINTER pThis,
      EIF_INTEGER x, EIF_INTEGER y )
{
    ( (POINTL*)pThis)->x = x;
    ( (POINTL*)pThis)->y = y;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_pointl_get_x
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_pointl_get_x( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ( (POINTL*)pThis)->x );
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_pointl_get_y
//
// Purpose:
//
//
// Parameters:
//
//
// Return Value:
//
//

extern "C" EIF_INTEGER eole2_pointl_get_y( EIF_POINTER pThis )
{
    return (EIF_INTEGER)( ( (POINTL*)pThis)->y );
}

/////// EOLE_CONNECT_DATA ///////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_connect_data_allocate
//
// Purpose:
//    Allocate a real CONNECTDATA structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pointer to allocated CONNECTDATA data structure.
//

extern "C" EIF_POINTER eole2_connect_data_allocate (void) {
   return (EIF_POINTER)  calloc (1, sizeof (CONNECTDATA));
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_connect_data_set_p_unk
//
// Purpose:
//    Set the 'p_unk' member of CONNECTDATA structure to the specified value.
//
// Parameters:
//    _this        EIF_POINTER pointer to the CONNECTDATA structure.
//    p_unk        EIF_POINTER.
//
// Return Value:
//    None.
//

extern "C" void eole2_connect_data_set_p_unk (EIF_POINTER _this,
                                             EIF_POINTER  p_unk) {
   ((CONNECTDATA FAR *)_this)->pUnk = (IUnknown FAR *) p_unk;
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_connect_data_set_cookie
//
// Purpose:
//    Set the 'dwCookie' member of CONNECTDATA structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the CONNECTDATA structure.
//    cookie        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_connect_data_set_cookie (EIF_POINTER _this,
                                             EIF_INTEGER cookie) {
   ((CONNECTDATA FAR *)_this)->dwCookie = (DWORD) cookie;
   return;
}


/////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_connect_data_get_p_unk
//
// Purpose:
//    Obtain the 'PUnk' member of the CONNECTDATA structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the CONNECTDATA structure.
//
// Return Value:
//    Height element.
//

extern "C" EIF_POINTER eole2_connect_data_get_p_unk (EIF_POINTER _this) {
   return (EIF_POINTER)(((CONNECTDATA FAR *)_this)->pUnk);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_connect_data_get_cookie
//
// Purpose:
//    Obtain the 'dwCookie' member of the CONNECTDATA structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the CONNECTDATA structure.
//
// Return Value:
//    Ascent element.
//

extern "C" EIF_INTEGER eole2_connect_data_get_cookie (EIF_POINTER _this) {
   return (EIF_INTEGER)(((CONNECTDATA FAR *)_this)->dwCookie);
}

/////// EOLE_SELECT_PICTURE /////////////////////////////////////////////////

#ifndef SELECT_PICTURE
 typedef struct SelectPicture
         {
           HDC        hdcOut;        /* Previous device context   */
           OLE_HANDLE hbmpOut;      /* GDI handle of the picture */
         } SelectPicture;
 #define SELECT_PICTURE
#endif

/////// EOLE_TEXTMETRIC /////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_allocate
//
// Purpose:
//    Allocate a real TEXTMETRIC structure.
//
// Parameters:
//    None.
//
// Return Value:
//    Pointer to allocated TEXTMETRIC data structure.
//

extern "C" EIF_POINTER eole2_textmetric_allocate (void) {
   return (EIF_POINTER)  calloc (1, sizeof (TEXTMETRIC));
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_height
//
// Purpose:
//    Set the 'tmHeight' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    height        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_height (EIF_POINTER _this,
                                             EIF_INTEGER height) {
   ((TEXTMETRIC FAR *)_this)->tmHeight = (int) height;
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_ascent
//
// Purpose:
//    Set the 'tmAscent' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    ascent        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_ascent (EIF_POINTER _this,
                                             EIF_INTEGER ascent) {
   ((TEXTMETRIC FAR *)_this)->tmAscent = (int) ascent;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_descent
//
// Purpose:
//    Set the 'tmDescent' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    descent        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_descent (EIF_POINTER _this,
                                             EIF_INTEGER descent) {
   ((TEXTMETRIC FAR *)_this)->tmDescent = (int) descent;
   return;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_internal_leading
//
// Purpose:
//    Set the 'tmInternalLeading' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    internal_leading        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_internal_leading (EIF_POINTER _this,
                                             EIF_INTEGER internal_leading) {
   ((TEXTMETRIC FAR *)_this)->tmInternalLeading = (int) internal_leading;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_external_leading
//
// Purpose:
//    Set the 'tmExternalLeading' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    external_leading        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_external_leading (EIF_POINTER _this,
                                             EIF_INTEGER external_leading) {
   ((TEXTMETRIC FAR *)_this)->tmExternalLeading = (int) external_leading;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_ave_char_width
//
// Purpose:
//    Set the 'tmAveCharWidth' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    ave_char_width        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_ave_char_width (EIF_POINTER _this,
                                             EIF_INTEGER ave_char_width) {
   ((TEXTMETRIC FAR *)_this)->tmAveCharWidth = (int) ave_char_width;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_max_char_width
//
// Purpose:
//    Set the 'tmMaxCharWidth' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    max_char_width        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_max_char_width (EIF_POINTER _this,
                                             EIF_INTEGER max_char_width) {
   ((TEXTMETRIC FAR *)_this)->tmMaxCharWidth = (int) max_char_width;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_weight
//
// Purpose:
//    Set the 'tmWeight' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    weight        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_weight (EIF_POINTER _this,
                                             EIF_INTEGER weight) {
   ((TEXTMETRIC FAR *)_this)->tmWeight = (int) weight;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_italic
//
// Purpose:
//    Set the 'tmItalic' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    italic        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_italic (EIF_POINTER _this,
                                             EIF_INTEGER italic) {
   ((TEXTMETRIC FAR *)_this)->tmItalic = (BYTE) italic;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_underlined
//
// Purpose:
//    Set the 'tmUnderlined' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    underlined        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_underlined (EIF_POINTER _this,
                                             EIF_INTEGER underlined) {
   ((TEXTMETRIC FAR *)_this)->tmUnderlined = (BYTE) underlined;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_struck_out
//
// Purpose:
//    Set the 'tmStruckOut' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    struck_out        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_struck_out (EIF_POINTER _this,
                                             EIF_INTEGER struck_out) {
   ((TEXTMETRIC FAR *)_this)->tmStruckOut = (BYTE) struck_out;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_first_char
//
// Purpose:
//    Set the 'tmFirstChar' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    first_char        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_first_char (EIF_POINTER _this,
                                             EIF_INTEGER first_char) {
   ((TEXTMETRIC FAR *)_this)->tmFirstChar = (BYTE) first_char;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_last_char
//
// Purpose:
//    Set the 'tmLastChar' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    last_char        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_last_char (EIF_POINTER _this,
                                             EIF_INTEGER last_char) {
   ((TEXTMETRIC FAR *)_this)->tmLastChar = (BYTE) last_char;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_default_char
//
// Purpose:
//    Set the 'tmDefaultChar' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    default_char        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_default_char (EIF_POINTER _this,
                                             EIF_INTEGER default_char) {
   ((TEXTMETRIC FAR *)_this)->tmDefaultChar = (BYTE) default_char;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_break_char
//
// Purpose:
//    Set the 'tmBreakChar' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    break_char        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_break_char (EIF_POINTER _this,
                                             EIF_INTEGER break_char) {
   ((TEXTMETRIC FAR *)_this)->tmBreakChar = (BYTE) break_char;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_pitch_and_family
//
// Purpose:
//    Set the 'tmPitchAndFamily' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    pitch_and_family        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_pitch_and_family (EIF_POINTER _this,
                                             EIF_INTEGER pitch_and_family) {
   ((TEXTMETRIC FAR *)_this)->tmPitchAndFamily = (BYTE) pitch_and_family;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_char_set
//
// Purpose:
//    Set the 'tmCharSet' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    char_set        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_char_set (EIF_POINTER _this,
                                             EIF_INTEGER char_set) {
   ((TEXTMETRIC FAR *)_this)->tmCharSet = (BYTE) char_set;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_overhang
//
// Purpose:
//    Set the 'tmOverhang' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    overhang        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_overhang (EIF_POINTER _this,
                                             EIF_INTEGER overhang) {
   ((TEXTMETRIC FAR *)_this)->tmOverhang = (int) overhang;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_digitized_aspect_x
//
// Purpose:
//    Set the 'tmDigitizedAspectX' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    digitized_aspect_x        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_digitized_aspect_x (EIF_POINTER _this,
                                             EIF_INTEGER digitized_aspect_x) {
   ((TEXTMETRIC FAR *)_this)->tmDigitizedAspectX = (int) digitized_aspect_x;
   return;
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_set_digitized_aspect_y
//
// Purpose:
//    Set the 'tmDigitizedAspectY' member of TEXTMETRIC structure to the specified value.
//
// Parameters:
//    _this         EIF_POINTER pointer to the TEXTMETRIC structure.
//    digitized_aspect_y        EIF_INTEGER.
//
// Return Value:
//    None.
//

extern "C" void eole2_textmetric_set_digitized_aspect_y (EIF_POINTER _this,
                                             EIF_INTEGER digitized_aspect_y) {
   ((TEXTMETRIC FAR *)_this)->tmDigitizedAspectY = (int) digitized_aspect_y;
   return;
}
/////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_height
//
// Purpose:
//    Obtain the 'tmHeight' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    Height element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_height (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmHeight);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_ascent
//
// Purpose:
//    Obtain the 'tmAscent' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    Ascent element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_ascent (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmAscent);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_descent
//
// Purpose:
//    Obtain the 'tmDescent' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    Descent element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_descent (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmDescent);
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_internal_leading
//
// Purpose:
//    Obtain the 'tmInternalLeading' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    InternalLeading element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_internal_leading (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmInternalLeading);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_external_leading
//
// Purpose:
//    Obtain the 'tmExternalLeading' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    ExternalLeading element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_external_leading (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmExternalLeading);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_ave_char_width
//
// Purpose:
//    Obtain the 'tmAveCharWidth' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    AveCharWidth element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_ave_char_width (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmAveCharWidth);
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_max_char_width
//
// Purpose:
//    Obtain the 'tmMaxCharWidth' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    MaxCharWidth element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_max_char_width (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmMaxCharWidth);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_weight
//
// Purpose:
//    Obtain the 'tmWeight' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    Weight element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_weight (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmWeight);
}
/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_italic
//
// Purpose:
//    Obtain the 'tmItalic' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    Italic element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_italic (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmItalic);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_underlined
//
// Purpose:
//    Obtain the 'tmUnderlined' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    Underlined element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_underlined (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmUnderlined);
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_struck_out
//
// Purpose:
//    Obtain the 'tmStruckOut' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    StruckOut element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_struck_out (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmStruckOut);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_first_char
//
// Purpose:
//    Obtain the 'tmFirstChar' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    FirstChar element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_first_char (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmFirstChar);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_last_char
//
// Purpose:
//    Obtain the 'tmLastChar' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    LastChar element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_last_char (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmLastChar);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_default_char
//
// Purpose:
//    Obtain the 'tmDefaultChar' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    DefaultChar element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_default_char (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmDefaultChar);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_break_char
//
// Purpose:
//    Obtain the 'tmBreakChar' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    BreakChar element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_break_char (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmBreakChar);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_pitch_and_family
//
// Purpose:
//    Obtain the 'tmPitchAndFamily' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    PitchAndFamily element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_pitch_and_family (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmPitchAndFamily);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_char_set
//
// Purpose:
//    Obtain the 'tmCharSet' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    CharSet element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_char_set (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmCharSet);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_overhang
//
// Purpose:
//    Obtain the 'tmOverhang' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    Overhang element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_overhang (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmOverhang);
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_digitized_aspect_x
//
// Purpose:
//    Obtain the 'tmDigitizedAspectX' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    DigitizedAspectX element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_digitized_aspect_x (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmDigitizedAspectX);
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_textmetric_get_digitized_aspect_y
//
// Purpose:
//    Obtain the 'tmDigitizedAspectY' member of the TEXTMETRIC structure.
//
// Parameters:
//    _this           EIF_POINTER pointer to the TEXTMETRIC structure.
//
// Return Value:
//    DigitizedAspectY element.
//

extern "C" EIF_INTEGER eole2_textmetric_get_digitized_aspect_y (EIF_POINTER _this) {
   return (EIF_INTEGER)(((TEXTMETRIC FAR *)_this)->tmDigitizedAspectY);
}


/////// END OF FILE /////////////////////////////////////////////////////////
