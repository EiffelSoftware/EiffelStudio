/////////////////////////////////////////////////////////////////////
//   title:         "IPictureDisp support";
//   cluster:       "CLIBRARY";
//   project:       "Eiffel OLE Library";
//   copyright:     "ISE Inc., 1997";


#include "eifole.h"




extern "C" HRESULT E_IPictureDisp_GetTypeInfoCount(
        void* ptr, BOOL incomingCall,
        UINT FAR* pctinfo );
extern "C" HRESULT E_IPictureDisp_GetTypeInfo(
        void* ptr, BOOL incomingCall,
        UINT itinfo, LCID lcid,
        ITypeInfo FAR* FAR* pptinfo );
extern "C" HRESULT E_IPictureDisp_GetIDsOfNames(
        void* ptr, BOOL incomingCall,
        REFIID riid, LPOLESTR FAR* rgszNames,
        UINT cNames, LCID lcid, DISPID FAR* rgdispid );
extern "C" HRESULT E_IPictureDisp_Invoke(
        void* ptr, BOOL incomingCall,
        DISPID dispidMember, REFIID riid,
        LCID lcid, WORD wFlags, DISPPARAMS FAR* pdispparams,
        VARIANT FAR* pvarResult, EXCEPINFO FAR* pexcepinfo,
        UINT FAR* puArgErr );
		
		
		
		
		
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
E_IPictureDisp::E_IPictureDisp() : E_IUnknown()
{
}

STDMETHODIMP E_IPictureDisp::get_Handle
                         (
                           OLE_HANDLE * phandle
                         )
{
     return E_IPictureDisp_get_Handle
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( OLE_HANDLE * )  phandle
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IPictureDisp::get_hPal
                         (
                           OLE_HANDLE * phpal
                         )
{
     return E_IPictureDisp_get_hPal
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( OLE_HANDLE * )  phpal
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IPictureDisp::get_Type
                         (
                           short* ptype
                         )
{
     return E_IPictureDisp_get_Type
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( short* )  ptype
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IPictureDisp::get_Width
                         (
                           OLE_XSIZE_HIMETRIC* pwidth
                         )
{
     return E_IPictureDisp_get_Width
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( OLE_XSIZE_HIMETRIC* )  pwidth
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IPictureDisp::get_Height
                         (
                           OLE_YSIZE_HIMETRIC* pheight
                         )
{
     return E_IPictureDisp_get_Height
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( OLE_YSIZE_HIMETRIC* )  pheight
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IPictureDisp::Render
                         (
                           HDC hdc,
                           long x,
                           long y,
                           long cx,
                           long cy,
                           OLE_XPOS_HIMETRIC xSrc,
                           OLE_YPOS_HIMETRIC ySrc,
                           OLE_XSIZE_HIMETRIC cxSrc,
                           OLE_YSIZE_HIMETRIC cySrc,
                           LPCRECT prcWBounds
                         )
{
     return E_IPictureDisp_Render
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( HDC )  hdc,
                           ( long )  x,
                           ( long )  y,
                           ( long )  cx,
                           ( long )  cy,
                           ( OLE_XPOS_HIMETRIC )  xSrc,
                           ( OLE_YPOS_HIMETRIC )  ySrc,
                           ( OLE_XSIZE_HIMETRIC )  cxSrc,
                           ( OLE_YSIZE_HIMETRIC )  cySrc,
                           ( LPCRECT )  prcWBounds
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IPictureDisp::set_hPal
                         (
                           OLE_HANDLE hpal
                         )
{
     return E_IPictureDisp_set_hPal
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( OLE_HANDLE )  hpal
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IPictureDisp::get_CurDC
                         (
                           HDC* phdcOut
                         )
{
     return E_IPictureDisp_get_CurDC
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( HDC* )  phdcOut
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IPictureDisp::SelectPicture
                         (
                           HDC hdcIn,
                           HDC* phdcOut,
                           OLE_HANDLE * phbmpOut
                         )
{
     return E_IPictureDisp_SelectPicture
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( HDC )  hdcIn,
                           ( HDC* )  phdcOut,
                           ( OLE_HANDLE * )  phbmpOut
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IPictureDisp::get_KeepOriginalFormat
                         (
                           BOOL* pfkeep
                         )
{
     return E_IPictureDisp_get_KeepOriginalFormat
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( BOOL* )  pfkeep
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IPictureDisp::put_KeepOriginalFormat
                         (
                           BOOL keep
                         )
{
     return E_IPictureDisp_put_KeepOriginalFormat
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( BOOL )  keep
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IPictureDisp::PictureChanged
                         (  void
                         )
{
     return E_IPictureDisp_PictureChanged
                         ( GetEiffelCurrentPointer(),
                           TRUE
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IPictureDisp::SaveAsFile
                         (
                           IStream * pstream,
                           BOOL fSaveMemCopy,
                           LONG * pcbSize
                         )
{
     return E_IPictureDisp_SaveAsFile
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( IStream * )  pstream,
                           ( BOOL )  fSaveMemCopy,
                           ( LONG * )  pcbSize
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IPictureDisp::get_Attributes
                         (
                           DWORD *  pdwAttr
                         )
{
     return E_IPictureDisp_get_Attributes
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( DWORD *  )  pdwAttr
                         );
}
//---------------------------------------------------------------------------



//---------------------------------------------------------------------------

extern "C" HRESULT E_IPictureDisp_get_Handle
                         ( void * ptr,
                           BOOL incomingCall,
                           OLE_HANDLE * phandle
                         )
{
     if( incomingCall )
          {
		    *phandle = (OLE_HANDLE) Ocxdisp_PictureGetHandle (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IPictureDisp*) ptr)->get_Handle
                         (
                           ( OLE_HANDLE * )  phandle
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IPictureDisp_get_hPal
                         ( void * ptr,
                           BOOL incomingCall,
                           OLE_HANDLE * phpal
                         )
{
     if( incomingCall )
          {
		    *phpal = (OLE_HANDLE)Ocxdisp_PictureGetHpal (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IPictureDisp*) ptr)->get_hPal
                         (
                           ( OLE_HANDLE * )  phpal
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IPictureDisp_get_Type
                         ( void * ptr,
                           BOOL incomingCall,
                           short* ptype
                         )
{
     if( incomingCall )
          {
		    *ptype = (short)Ocxdisp_PictureGetType (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IPictureDisp*) ptr)->get_Type
                         (
                           ( short* )  ptype
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IPictureDisp_get_Width
                         ( void * ptr,
                           BOOL incomingCall,
                           OLE_XSIZE_HIMETRIC* pwidth
                         )
{
     if( incomingCall )
          {
		    *pwidth = (OLE_XSIZE_HIMETRIC)Ocxdisp_PictureGetWidth (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IPictureDisp*) ptr)->get_Width
                         (
                           ( OLE_XSIZE_HIMETRIC* )  pwidth
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IPictureDisp_get_Height
                         ( void * ptr,
                           BOOL incomingCall,
                           OLE_YSIZE_HIMETRIC* pheight
                         )
{
     if( incomingCall )
          {
		    *pheight = (OLE_YSIZE_HIMETRIC)Ocxdisp_PictureGetHeight (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IPictureDisp*) ptr)->get_Height
                         (
                           ( OLE_YSIZE_HIMETRIC* )  pheight
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IPictureDisp_Render
                         ( void * ptr,
                           BOOL incomingCall,
                           HDC hdc,
                           long x,
                           long y,
                           long cx,
                           long cy,
                           OLE_XPOS_HIMETRIC xSrc,
                           OLE_YPOS_HIMETRIC ySrc,
                           OLE_XSIZE_HIMETRIC cxSrc,
                           OLE_YSIZE_HIMETRIC cySrc,
                           LPCRECT prcWBounds
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_PictureRender (eif_access (eoleOcxDisp), eif_access (ptr), 
			               (EIF_INTEGER) hdc,
                           (EIF_INTEGER) x,
                           (EIF_INTEGER) y,
                           (EIF_INTEGER) cx,
                           (EIF_INTEGER) cy,
                           (EIF_INTEGER) xSrc,
                           (EIF_INTEGER) ySrc,
                           (EIF_INTEGER) cxSrc,
                           (EIF_INTEGER) cySrc,
                           (EIF_POINTER) prcWBounds);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IPictureDisp*) ptr)->Render
                         (
                           ( HDC )  hdc,
                           ( long )  x,
                           ( long )  y,
                           ( long )  cx,
                           ( long )  cy,
                           ( OLE_XPOS_HIMETRIC )  xSrc,
                           ( OLE_YPOS_HIMETRIC )  ySrc,
                           ( OLE_XSIZE_HIMETRIC )  cxSrc,
                           ( OLE_YSIZE_HIMETRIC )  cySrc,
                           ( LPCRECT )  prcWBounds
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IPictureDisp_set_hPal
                         ( void * ptr,
                           BOOL incomingCall,
                           OLE_HANDLE hpal
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_PictureSetHpal (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_INTEGER)hpal);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IPictureDisp*) ptr)->set_hPal
                         (
                           ( OLE_HANDLE )  hpal
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IPictureDisp_get_CurDC
                         ( void * ptr,
                           BOOL incomingCall,
                           HDC* phdcOut
                         )
{
     if( incomingCall )
          {
		    *phdcOut = (HDC)Ocxdisp_PictureGetCurDc (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IPictureDisp*) ptr)->get_CurDC
                         (
                           ( HDC* )  phdcOut
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IPictureDisp_SelectPicture
                         ( void * ptr,
                           BOOL incomingCall,
                           HDC hdcIn,
                           HDC* phdcOut,
                           OLE_HANDLE * phbmpOut
                         )
{
     if( incomingCall )
          {
		  	EIF_POINTER result;
			EIF_FN_INT hbout;
			EIF_FN_INT hdout;
			EIF_TYPE_ID selectpicture_id;

			selectpicture_id = eif_type_id ("EOLE_SELECT_PICTURE");
			hbout = eif_fn_int ("hbmp_out", selectpicture_id);
			hdout = eif_fn_int ("hdc_out", selectpicture_id);
		    result = (EIF_POINTER)Ocxdisp_PictureSelectPicture (eif_access (eoleOcxDisp), eif_access (ptr));
			*phdcOut = (HDC)hdout (result);
			*phbmpOut = (OLE_HANDLE)hbout (result);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IPictureDisp*) ptr)->SelectPicture
                         (
                           ( HDC )  hdcIn,
                           ( HDC* )  phdcOut,
                           ( OLE_HANDLE * )  phbmpOut
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IPictureDisp_get_KeepOriginalFormat
                         ( void * ptr,
                           BOOL incomingCall,
                           BOOL* pfkeep
                         )
{
     if( incomingCall )
          {
		    *pfkeep = (BOOL)Ocxdisp_PictureGetKeepOriginalFormat (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
           }
     return ((E_IPictureDisp*) ptr)->get_KeepOriginalFormat
                         (
                           ( BOOL* )  pfkeep
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IPictureDisp_put_KeepOriginalFormat
                         ( void * ptr,
                           BOOL incomingCall,
                           BOOL keep
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_PicturePutKeepOriginalFormat (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_BOOLEAN)keep);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IPictureDisp*) ptr)->put_KeepOriginalFormat
                         (
                           ( BOOL )  keep
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IPictureDisp_PictureChanged
                         ( void * ptr,
                           BOOL incomingCall
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_PicturePictureChanged (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IPictureDisp*) ptr)->PictureChanged
                         ();
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IPictureDisp_SaveAsFile
                         ( void * ptr,
                           BOOL incomingCall,
                           IStream * pstream,
                           BOOL fSaveMemCopy,
                           LONG * pcbSize
                         )
{
     if( incomingCall )
          {
		    *pcbSize = (LONG)Ocxdisp_PictureSaveAsFile (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_POINTER)pstream, (EIF_BOOLEAN)fSaveMemCopy);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IPictureDisp*) ptr)->SaveAsFile
                         (
                           ( IStream * )  pstream,
                           ( BOOL )  fSaveMemCopy,
                           ( LONG * )  pcbSize
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IPictureDisp_get_Attributes
                         ( void * ptr,
                           BOOL incomingCall,
                           DWORD *  pdwAttr
                         )
{
     if( incomingCall )
          {
		    *pdwAttr = (DWORD)Ocxdisp_PictureGetAttributes (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IPictureDisp*) ptr)->get_Attributes
                         (
                           ( DWORD *  )  pdwAttr
                         );
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_picture_get_handle( EIF_POINTER ip )
{
   OLE_HANDLE handle;
   
   g_hrStatusCode = E_IPictureDisp_get_Handle ( ip, FALSE, ( OLE_HANDLE * ) &handle);
   return (EIF_INTEGER) handle;
}
//---------------------------------------------------------------------------
extern "C"  EIF_INTEGER eole2_picture_get_hpal ( EIF_POINTER ip )
{
  OLE_HANDLE  hpal;

  g_hrStatusCode = E_IPictureDisp_get_hPal ( ip, FALSE, ( OLE_HANDLE * )  &hpal);
  return (EIF_INTEGER) hpal;

}
//---------------------------------------------------------------------------
extern "C"  EIF_INTEGER eole2_picture_get_type  ( EIF_POINTER ip )
{
  short  type;
  
  g_hrStatusCode = E_IPictureDisp_get_Type ( ip, FALSE,  ( short* )  &type);
  return (EIF_INTEGER) type;
}
//---------------------------------------------------------------------------
extern "C" EIF_INTEGER eole2_picture_get_width ( EIF_POINTER ip )
{
  OLE_XSIZE_HIMETRIC  width;
  
  g_hrStatusCode = E_IPictureDisp_get_Width
                                       ( ip, FALSE,
                                         ( OLE_XSIZE_HIMETRIC* )  &width
                                       );
  return (EIF_INTEGER) width;
}
//---------------------------------------------------------------------------
extern "C"  EIF_INTEGER  eole2_picture_get_height ( EIF_POINTER ip )
{
  OLE_YSIZE_HIMETRIC height;

  g_hrStatusCode = E_IPictureDisp_get_Height
                                        ( ip, FALSE,
                                          ( OLE_YSIZE_HIMETRIC* )  &height
                                         );
  return (EIF_INTEGER) height;
}
//---------------------------------------------------------------------------
extern "C" void eole2_picture_render
                          ( EIF_POINTER ip,
                            EIF_INTEGER hdc,
                            EIF_INTEGER x,
                            EIF_INTEGER y,
                            EIF_INTEGER cx,
                            EIF_INTEGER cy,
                            EIF_INTEGER x_src,
                            EIF_INTEGER y_src,
                            EIF_INTEGER cx_src,
                            EIF_INTEGER cy_src,
                            EIF_POINTER bounds
                          )
{
     g_hrStatusCode = E_IPictureDisp_Render
                          ( ip, FALSE,
                           ( HDC )  hdc,
                           ( long )  x,
                           ( long )  y,
                           ( long )  cx,
                           ( long )  cy,
                           ( OLE_XPOS_HIMETRIC )  x_src,
                           ( OLE_YPOS_HIMETRIC )  y_src,
                           ( OLE_XSIZE_HIMETRIC )  cx_src,
                           ( OLE_YSIZE_HIMETRIC )  cy_src,
                           ( LPCRECT )  bounds
                          );

}
//---------------------------------------------------------------------------
extern "C" void eole2_picture_set_hpal ( EIF_POINTER ip, EIF_INTEGER hpal )
{
     g_hrStatusCode = E_IPictureDisp_set_hPal
                                        ( ip, FALSE,
                                          ( OLE_HANDLE )  hpal
                                        );

}
//---------------------------------------------------------------------------
extern "C" EIF_INTEGER eole2_picture_get_cur_dc( EIF_POINTER ip )
{
  HDC  hdc_out;

     g_hrStatusCode = E_IPictureDisp_get_CurDC
                          ( ip, FALSE,
                           ( HDC* )  &hdc_out
                          );
     return (EIF_INTEGER) hdc_out;
}
//---------------------------------------------------------------------------
extern "C" void eole2_picture_select_picture
                          ( EIF_POINTER ip,
                            EIF_INTEGER hdc_in,
                            EIF_POINTER psp
                          )
{
  SelectPicture  * sp;
  
  sp = (SelectPicture *) psp;
  
  g_hrStatusCode = E_IPictureDisp_SelectPicture
                                          ( ip, FALSE,
                                            ( HDC )  hdc_in,
                                            &sp->hdcOut,
                                            &sp->hbmpOut
                                          );

}
//---------------------------------------------------------------------------
extern "C" EIF_BOOLEAN  eole2_picture_get_keep_original_format( EIF_POINTER ip)
{
  BOOL  fkeep;
  
  g_hrStatusCode = E_IPictureDisp_get_KeepOriginalFormat
                                                 ( ip, FALSE,
                                                   ( BOOL* )  &fkeep
                                                 );
  return (EIF_BOOLEAN) fkeep;
}
//---------------------------------------------------------------------------
extern "C" void eole2_picture_put_keep_original_format
                          ( EIF_POINTER ip,
                            EIF_BOOLEAN keep
                          )
{
  g_hrStatusCode = E_IPictureDisp_put_KeepOriginalFormat
                          ( ip, FALSE,
                           ( BOOL )  keep
                          );

}
//---------------------------------------------------------------------------
extern "C" void eole2_picture_picture_changed ( EIF_POINTER ip)
{
     g_hrStatusCode = E_IPictureDisp_PictureChanged ( ip, FALSE );

}
//---------------------------------------------------------------------------
extern "C" EIF_INTEGER eole2_picture_save_as_file
                          ( EIF_POINTER ip,
                            EIF_POINTER pstream,
                            EIF_BOOLEAN f_save_mem_copy
                          )
{
  LONG   size;
  
  g_hrStatusCode = E_IPictureDisp_SaveAsFile
                          ( ip, FALSE,
                           ( IStream * )  pstream,
                           ( BOOL )  f_save_mem_copy,
                           ( LONG * )  &size
                          );
  return  (EIF_INTEGER) size;
}
//---------------------------------------------------------------------------
extern "C" EIF_INTEGER eole2_picture_get_attributes
                          ( EIF_POINTER ip,
                            EIF_POINTER p_attr
                          )
{
 DWORD  attr;
 
 g_hrStatusCode = E_IPictureDisp_get_Attributes ( ip, FALSE,( DWORD *  ) &attr);
 return  (EIF_INTEGER) attr;

}
//---------------------------------------------------------------------------
