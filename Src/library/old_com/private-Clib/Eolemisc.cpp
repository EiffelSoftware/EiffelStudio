//---------------------------------------------------------------------------
//indexing
//   title:         "Miscellaneous OLE API support";
//   cluster:       "CLIBRARY";
//   project:       "Eiffel OLE Library";
//   copyright:     "SiG Computer Inc.", 1996;
//   approved_by:   "Dmitry Mastrukov (DLM)";
//   done_at:       "SIG Computer Inc, Moscow (info@eiffel.ru)";
//   external_name: "$RCSfile$";
//---------------------------------------------------------------------------
// $Log$
// Revision 1.4  1998/02/02 18:05:03  raphaels
// Added TypeComp support.
// Updated TypeLib and TypeInfo support.
// Modified some file names.
//
// Revision 1.2  1998/01/20 00:25:55  raphaels
// Modified sources to be compatible with Borland compiler.
//
// Revision 1.1.1.1  1998/01/15 23:32:14  raphaels
// First version of EiffelCOM
//
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
// This file contains miscellaneous functions wrapping Win32 API
//---------------------------------------------------------------------------

#include "eifole.h"
#ifdef EIF_BORLAND
#	include "olectl.h"
#endif

/////////////////////////////////////////////////////////////////////////////
//
// g_hrStatusCode  HRESULT (Global)
//
// Purpose:
//    Since Eiffel restriction to return interface pointer in [out] parameter
//    in [Create|Open|Enum]... methods, we must remember the status of
//    each operation, wich return interface pointer in [out] parameter
//    in this global variable. Corresponding Eiffel object
//    can obtain this value via 'eole2_last_hresult' function.
//




	
//---------------------------------------------------------------------------

//---------------------------------------------------------------------------
// Initialization and Uninitialization of COM
//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_ole_initialize( void )
{
	return (EIF_INTEGER)OleInitialize( NULL );
}

extern "C" void eole2_ole_uninitialize( void )
{
    OleUninitialize();
}

//---------------------------------------------------------------------------
// Co... access methods
//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_co_initialize( void )
{
    return (EIF_INTEGER)CoInitialize( NULL );
}

//---------------------------------------------------------------------------

extern "C" void eole2_co_uninitialize( void )
{
    CoUninitialize();
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_co_build_version_major( void )
{
    DWORD ver;
    ver = CoBuildVersion();
    return (EIF_INTEGER)( ver >> 16 );
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_co_build_version_minor( void )
{
    DWORD ver;
    ver = CoBuildVersion();
    return (EIF_INTEGER)( (unsigned short)ver );
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_co_create_guid( void )
{
    GUID guid;

    CoCreateGuid( &guid );
    return (char*)GuidToCString( guid );
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_co_create_instance(
        EIF_POINTER clsid, EIF_POINTER punk_outer,
        EIF_INTEGER context,
        EIF_POINTER iid )
{
    void* iptr;
    GUID classID, interfID;

    EiffelStringToGuid( clsid, &classID );
    EiffelStringToGuid( iid, &interfID );

    g_hrStatusCode = CoCreateInstance(
            classID,
            (LPUNKNOWN)punk_outer,
            context,
            interfID,
            &iptr );

    return (EIF_POINTER)iptr;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_co_get_class_object(
        EIF_POINTER clsid,
        EIF_INTEGER context,
        EIF_POINTER iid )
{
    void* iptr;
    GUID classID, interfID;

    EiffelStringToGuid( clsid, &classID );
    EiffelStringToGuid( iid, &interfID );

    g_hrStatusCode = CoGetClassObject(
            classID,
            context,
            NULL,
            interfID,
            &iptr );

    return (EIF_POINTER)iptr;
}

//------------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_co_register_class_object (
		EIF_POINTER clsid, EIF_POINTER pClassFactory,
		EIF_INTEGER context, EIF_INTEGER flags )
{
	EIF_INTEGER result;
	GUID classID;

	EiffelStringToGuid( clsid, &classID );
	g_hrStatusCode = CoRegisterClassObject (
			classID,
			(LPCLASSFACTORY)pClassFactory,
			context,
			flags,
			(unsigned long*)&result);
	return result;
}

extern "C" void eole2_co_revoke_class_object (EIF_INTEGER token)
{
	g_hrStatusCode = CoRevokeClassObject ((DWORD)token);
}

#define HIMETRIC_INCH   2540    // HIMETRIC units per inch

/////////////////////////////////////////////////////////////////////////////
//
// eole2_DPtoHIMETRIC
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

extern "C" void eole2_DPtoHIMETRIC (EIF_POINTER psz) {
   HDC hDC = GetDC (NULL);
   LPSIZE lpSize = (LPSIZE)psz;
   int nMapMode;

   if ((nMapMode = GetMapMode (hDC)) < MM_ISOTROPIC &&
      nMapMode != MM_TEXT)
   {
      // when using a constrained map mode, map against physical inch
      SetMapMode (hDC, MM_HIMETRIC);
      DPtoLP (hDC, (LPPOINT)lpSize, 1);
      SetMapMode (hDC, nMapMode);
   }
   else
   {
      // map against logical inch for non-constrained mapping modes
      int cxPerInch, cyPerInch;
      cxPerInch = GetDeviceCaps (hDC, LOGPIXELSX);
      cyPerInch = GetDeviceCaps (hDC, LOGPIXELSY);
      lpSize->cx = MulDiv(lpSize->cx, HIMETRIC_INCH, cxPerInch);
      lpSize->cy = MulDiv(lpSize->cy, HIMETRIC_INCH, cyPerInch);
   }
   ReleaseDC (NULL, hDC);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_HIMETRICtoDP
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

extern "C" void eole2_HIMETRICtoDP (EIF_POINTER psz) {
   HDC hDC = GetDC (NULL);
   LPSIZE lpSize = (LPSIZE)psz;

   int nMapMode;
   if ((nMapMode = GetMapMode (hDC)) < MM_ISOTROPIC &&
      nMapMode != MM_TEXT)
   {
      // when using a constrained map mode, map against physical inch
      SetMapMode(hDC, MM_HIMETRIC);
      LPtoDP (hDC, (LPPOINT)lpSize, 1);
      SetMapMode (hDC, nMapMode);
   }
   else
   {
      // map against logical inch for non-constrained mapping modes
      int cxPerInch, cyPerInch;
      cxPerInch = GetDeviceCaps (hDC, LOGPIXELSX);
      cyPerInch = GetDeviceCaps (hDC, LOGPIXELSY);
      lpSize->cx = MulDiv(lpSize->cx, cxPerInch, HIMETRIC_INCH);
      lpSize->cy = MulDiv(lpSize->cy, cyPerInch, HIMETRIC_INCH);
   }
   ReleaseDC (NULL, hDC);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_modify_style
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

extern "C" EIF_BOOLEAN eole2_modify_style (
                                    EIF_INTEGER hWnd, EIF_INTEGER nStyleOffset,
                                    EIF_INTEGER dwRemove,
                                    EIF_INTEGER dwAdd, EIF_INTEGER nFlags) {

   DWORD dwStyle    = GetWindowLong((HWND)hWnd, (int)nStyleOffset);
   DWORD dwNewStyle = (dwStyle & ~(DWORD)dwRemove) | (DWORD)dwAdd;
   if (dwStyle == dwNewStyle)
      return (EIF_BOOLEAN)FALSE;

   SetWindowLong((HWND)hWnd, (int)nStyleOffset, dwNewStyle);
   if (nFlags != 0)
   {
      SetWindowPos((HWND)hWnd, NULL, 0, 0, 0, 0,
         SWP_NOSIZE | SWP_NOMOVE | SWP_NOZORDER | SWP_NOACTIVATE | nFlags);
   }
   return (EIF_BOOLEAN)TRUE;
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_get_bk_color
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

extern "C" EIF_INTEGER eole2_get_bk_color (EIF_INTEGER hWnd)
{
/*
   HDC      dc = GetDC ((HWND)hWnd);
   COLORREF crBack;

   SendMessage ((HWND)hWnd, WM_CTLCOLORSTATIC, (WPARAM)dc, (LPARAM)(HWND)hWnd);
   crBack = GetBkColor (dc);
   ReleaseDC ((HWND)hWnd, dc);
   return (EIF_INTEGER)crBack;
*/
   return (EIF_INTEGER)GetSysColor (COLOR_WINDOW);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_get_text_color
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

extern "C" EIF_INTEGER eole2_get_text_color (EIF_INTEGER hWnd)
{
/*
   HDC      dc = GetDC ((HWND)hWnd);
   COLORREF crFore;

   SendMessage ((HWND)hWnd, WM_CTLCOLORSTATIC, (WPARAM)dc, (LPARAM)(HWND)hWnd);
   crFore = GetTextColor (dc);
   ReleaseDC ((HWND)hWnd, dc);
   return (EIF_INTEGER)crFore;
*/
   return (EIF_INTEGER)GetSysColor (COLOR_WINDOWTEXT);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_create_ole_font (not used)
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

/*

extern "C" EIF_POINTER eole2_create_ole_font (EIF_INTEGER hWnd) {

   HFONT      hfontSys;
   HFONT      hFont;
   LPFONTDISP pOleFont;

   hFont = (HFONT)SendMessage ((HWND)hWnd, WM_GETFONT, 0, 0L);

   if (hFont == NULL) {
      if ((hfontSys = GetStockObject (DEFAULT_GUI_FONT)) != NULL ||
         (hfontSys = GetStockObject (SYSTEM_FONT)) != NULL) {
         hFont = hfontSys;
      }
      else {
         return (EIF_POINTER)0;
      }
   }

   LOGFONT logfont;
   GetObject (hFont, sizeof (LOGFONT), &logfont);

   FONTDESC fd;
   fd.cbSizeofstruct = sizeof(FONTDESC);

   fd.lpstrName = Eif2OleString (logfont.lfFaceName);
   fd.sWeight = (short)logfont.lfWeight;
   fd.sCharset = logfont.lfCharSet;
   fd.fItalic = logfont.lfItalic;
   fd.fUnderline = logfont.lfUnderline;
   fd.fStrikethrough = logfont.lfStrikeOut;

   long lfHeight = logfont.lfHeight;
   if (lfHeight < 0)
      lfHeight = -lfHeight;

   HDC dc = GetDC ((HWND)hWnd);
   int ppi = GetDeviceCaps (dc, LOGPIXELSY);
   ReleaseDC ((HWND)hWnd, dc);

#ifdef EIF_BORLAND
   fd.cySize.s.Lo = lfHeight * 720000 / ppi;
   fd.cySize.s.Hi = 0;
#else
   fd.cySize.Lo = lfHeight * 720000 / ppi;
   fd.cySize.Hi = 0;
#endif

   if (FAILED(OleCreateFontIndirect(&fd, IID_IFontDisp, (void**)&pOleFont)))
      return (EIF_POINTER)0;
   return (EIF_POINTER)pOleFont;
}
*/

/////////////////////////////////////////////////////////////////////////////
//
// eole2_is_matching_mnemonic
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

extern "C" EIF_BOOLEAN eole2_is_matching_mnemonic (EIF_INTEGER hAccel,
                                                   EIF_INTEGER cAccel,
                                                   EIF_POINTER lpMsg) {

   ACCEL* pAccel = (ACCEL*)calloc (sizeof (ACCEL), (USHORT)cAccel);

   CopyAcceleratorTable((HACCEL)hAccel, pAccel, cAccel);

   BOOL bMatch = FALSE;

   for (int i = 0; i < cAccel; i++)
   {
      BOOL fVirt = (((LPMSG)lpMsg)->message == WM_SYSCHAR ? FALT : 0);

      WORD key = LOWORD(((LPMSG)lpMsg)->wParam);

      if (((pAccel[i].fVirt & ~FNOINVERT) == fVirt) &&
         (pAccel[i].key == key))
      {
         bMatch = TRUE;
         break;
      }
   }

   free (pAccel);
   return (EIF_BOOLEAN)bMatch;
}


/////////////////////////////////////////////////////////////////////////////
//
// eole2_get_window_long
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

/*extern "C" EIF_INTEGER eole2_get_window_long (EIF_INTEGER hWnd,
                                               EIF_INTEGER nStyleOffset) {
   return (EIF_INTEGER)GetWindowLong ((HWND)hWnd, (int)nStyleOffset);
} */

/////////////////////////////////////////////////////////////////////////////
//
// eole2_occsite_transform_coords
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

extern "C" EIF_INTEGER eole2_occsite_transform_coords (
                  POINTL* pptHimetric, POINTF* pptContainer, DWORD dwFlags) {
   HRESULT hr = NOERROR;

   HDC hDC = GetDC(NULL);
   SetMapMode(hDC, MM_HIMETRIC);
   POINT rgptConvert[2];
   rgptConvert[0].x = 0;
   rgptConvert[0].y = 0;

   if (dwFlags & XFORMCOORDS_HIMETRICTOCONTAINER)
   {
      rgptConvert[1].x = pptHimetric->x;
      rgptConvert[1].y = pptHimetric->y;
      LPtoDP(hDC, rgptConvert, 2);
      if (dwFlags & XFORMCOORDS_SIZE)
      {
         pptContainer->x = (float)(rgptConvert[1].x - rgptConvert[0].x);
         pptContainer->y = (float)(rgptConvert[0].y - rgptConvert[1].y);
      }
      else if (dwFlags & XFORMCOORDS_POSITION)
      {
         pptContainer->x = (float)rgptConvert[1].x;
         pptContainer->y = (float)rgptConvert[1].y;
      }
      else
      {
         hr = E_INVALIDARG;
      }
   }
   else if (dwFlags & XFORMCOORDS_CONTAINERTOHIMETRIC)
   {
      rgptConvert[1].x = (int)(pptContainer->x);
      rgptConvert[1].y = (int)(pptContainer->y);
      DPtoLP(hDC, rgptConvert, 2);
      if (dwFlags & XFORMCOORDS_SIZE)
      {
         pptHimetric->x = rgptConvert[1].x - rgptConvert[0].x;
         pptHimetric->y = rgptConvert[0].y - rgptConvert[1].y;
      }
      else if (dwFlags & XFORMCOORDS_POSITION)
      {
         pptHimetric->x = rgptConvert[1].x;
         pptHimetric->y = rgptConvert[1].y;
      }
      else
      {
         hr = E_INVALIDARG;
      }
   }
   else
   {
      hr = E_INVALIDARG;
   }

   ReleaseDC(NULL, hDC);

   return (EIF_INTEGER)hr;
}

/////// END OF FILE /////////////////////////////////////////////////////////

