//---------------------------------------------------------------------------
// indexing
//   title:         "IFont support";
//   cluster:       "CLIBRARY";
//   project:       "Eiffel OLE Library";
//   copyright:     "SiG Computer Inc., 1997";
//   approved_by:   "Symbol +";
//   external_name: "$RCSfile$";
//---------------------------------------------------------------------------
//-- $Log$
//-- Revision 1.3  1998/02/02 18:10:30  raphaels
//-- Added ITypeComp support.
//-- Corrected some bugs in ITypeLib and ITypeInfo.
//--
//-- Revision 1.1.1.1  1998/01/15 23:32:15  raphaels
//-- First version of EiffelCOM
//--
//---------------------------------------------------------------------------

#include "eifole.h"
#include "eif_hector.h"

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
E_IFont::E_IFont() : E_IUnknown()
{
}

STDMETHODIMP E_IFont::get_Name
                         (
                           BSTR * pname
                         )
{
     return E_IFont_get_Name
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( BSTR * )  pname
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::put_Name ( BSTR name )
{
     return E_IFont_put_Name
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( BSTR )  name
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::get_Size ( CY* psize )
{
     return E_IFont_get_Size
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( CY* )  psize
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::put_Size ( CY  size)
{
     return E_IFont_put_Size
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( CY  )  size
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::get_Bold
                         (
                           BOOL* pbold
                         )
{
     return E_IFont_get_Bold
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( BOOL* )  pbold
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::put_Bold
                         (
                           BOOL bold
                         )
{
     return E_IFont_put_Bold
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( BOOL )  bold
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::get_Italic
                         (
                           BOOL* pitalic
                         )
{
     return E_IFont_get_Italic
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( BOOL* )  pitalic
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::put_Italic
                         (
                           BOOL italic
                         )
{
     return E_IFont_put_Italic
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( BOOL )  italic
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::get_Underline
                         (
                           BOOL* punderline
                         )
{
     return E_IFont_get_Underline
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( BOOL* )  punderline
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::put_Underline
                         (
                           BOOL underline
                         )
{
     return E_IFont_put_Underline
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( BOOL )  underline
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::get_Strikethrough
                         (
                           BOOL* pstrikethrough
                         )
{
     return E_IFont_get_Strikethrough
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( BOOL* )  pstrikethrough
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::put_Strikethrough
                         (
                           BOOL strikethrough
                         )
{
     return E_IFont_put_Strikethrough
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( BOOL )  strikethrough
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::get_Weight
                         (
                           short* pweight
                         )
{
     return E_IFont_get_Weight
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( short* )  pweight
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::put_Weight
                         (
                           short weight
                         )
{
     return E_IFont_put_Weight
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( short )  weight
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::get_Charset
                         (
                           short* pcharset
                         )
{
     return E_IFont_get_Charset
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( short* )  pcharset
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::put_Charset
                         (
                           short charset
                         )
{
     return E_IFont_put_Charset
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( short )  charset
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::get_hFont
                         (
                           HFONT* phfont
                         )
{
     return E_IFont_get_hFont
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( HFONT* )  phfont
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::Clone
                         (
                           IFont** ppfont
                         )
{
     return E_IFont_Clone
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( IFont** )  ppfont
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::IsEqual
                         (
                           IFont* pFontOther
                         )
{
     return E_IFont_IsEqual
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( IFont* )  pFontOther
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::SetRatio
                         (
                           long cyLogical,
                           long cyHimetric
                         )
{
     return E_IFont_SetRatio
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( long )  cyLogical,
                           ( long )  cyHimetric
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::QueryTextMetrics
                         (
                           TEXTMETRICOLE* ptm
                         )
{
     return E_IFont_QueryTextMetrics
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( TEXTMETRICOLE* )  ptm
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::AddRefHfont
                         (
                           HFONT hfont
                         )
{
     return E_IFont_AddRefHfont
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( HFONT )  hfont
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::ReleaseHfont
                         (
                           HFONT hfont
                         )
{
     return E_IFont_ReleaseHfont
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( HFONT )  hfont
                         );
}
//---------------------------------------------------------------------------

STDMETHODIMP E_IFont::SetHdc
                         (
                           HDC hdc
                         )
{
     return E_IFont_SetHdc
                         ( GetEiffelCurrentPointer(),
                           TRUE,
                           ( HDC )  hdc
                         );
}
//---------------------------------------------------------------------------



//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_get_Name
                         ( void *ptr,
                           BOOL incomingCall,
                           BSTR*      pname
                         )
{
     if( incomingCall )
	 {
		    *pname = (BSTR)Ocxdisp_FontGetName (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->get_Name
                         (
                           ( BSTR*      )  pname
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_put_Name
                         ( void * ptr,
                           BOOL incomingCall,
                           BSTR name
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_FontPutName (eif_access (eoleOcxDisp), eif_access (ptr), name);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
		  }
     return ((E_IFont*) ptr)->put_Name
                         (
                           ( BSTR )  name
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_get_Size
                         ( void * ptr,
                           BOOL incomingCall,
                           CY* psize
                         )
{
     if( incomingCall )
          {
		    *psize = *(CY*)Ocxdisp_FontGetSize (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->get_Size
                         (
                           ( CY* )  psize
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_put_Size
                         ( void * ptr,
                           BOOL incomingCall,
                           CY  size
                         )
{
     if( incomingCall )
          { 
		    Ocxdisp_FontPutSize (eif_access (eoleOcxDisp), eif_access (ptr), &size);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->put_Size
                         (
                           ( CY  )  size
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_get_Bold
                         ( void * ptr,
                           BOOL incomingCall,
                           BOOL* pbold
                         )
{
     if( incomingCall )
          {
		    *pbold = (BOOL)Ocxdisp_FontGetBold (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->get_Bold
                         (
                           ( BOOL* )  pbold
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_put_Bold
                         ( void * ptr,
                           BOOL incomingCall,
                           BOOL bold
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_FontPutBold (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_BOOLEAN)bold);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->put_Bold
                         (
                           ( BOOL )  bold
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_get_Italic
                         ( void * ptr,
                           BOOL incomingCall,
                           BOOL* pitalic
                         )
{
     if( incomingCall )
          {
		    *pitalic = (BOOL)Ocxdisp_FontGetItalic (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->get_Italic
                         (
                           ( BOOL* )  pitalic
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_put_Italic
                         ( void * ptr,
                           BOOL incomingCall,
                           BOOL italic
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_FontPutItalic (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_BOOLEAN)italic);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->put_Italic
                         (
                           ( BOOL )  italic
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_get_Underline
                         ( void * ptr,
                           BOOL incomingCall,
                           BOOL* punderline
                         )
{
     if( incomingCall )
          {
		    *punderline = (BOOL)Ocxdisp_FontGetUnderline (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->get_Underline
                         (
                           ( BOOL* )  punderline
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_put_Underline
                         ( void * ptr,
                           BOOL incomingCall,
                           BOOL underline
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_FontPutUnderline (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_BOOLEAN)underline);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->put_Underline
                         (
                           ( BOOL )  underline
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_get_Strikethrough
                         ( void * ptr,
                           BOOL incomingCall,
                           BOOL* pstrikethrough
                         )
{
     if( incomingCall )
          {
		    *pstrikethrough = (BOOL)Ocxdisp_FontGetStrikethrough (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->get_Strikethrough
                         (
                           ( BOOL* )  pstrikethrough
                         );

}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_put_Strikethrough
                         ( void * ptr,
                           BOOL incomingCall,
                           BOOL strikethrough
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_FontPutStrikethrough (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_BOOLEAN)strikethrough);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->put_Strikethrough
                         (
                           ( BOOL )  strikethrough
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_get_Weight
                         ( void * ptr,
                           BOOL incomingCall,
                           short* pweight
                         )
{
     if( incomingCall )
          {
		    *pweight = (short)Ocxdisp_FontGetWeight (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->get_Weight
                         (
                           ( short* )  pweight
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_put_Weight
                         ( void * ptr,
                           BOOL incomingCall,
                           short weight
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_FontPutWeight (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_INTEGER)weight);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->put_Weight
                         (
                           ( short )  weight
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_get_Charset
                         ( void * ptr,
                           BOOL incomingCall,
                           short* pCharset
                         )
{
     if( incomingCall )
          {
		    *pCharset = (short)Ocxdisp_FontGetCharset (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->get_Charset
                         (
                           ( short* )  pCharset
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_put_Charset
                         ( void * ptr,
                           BOOL incomingCall,
                           short charset
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_FontPutCharset (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_INTEGER)charset);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->put_Charset
                         (
                           ( short )  charset
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_get_hFont
                         ( void * ptr,
                           BOOL incomingCall,
                           HFONT* phfont
                         )
{
     if( incomingCall )
          {
		    *phfont = (HFONT)Ocxdisp_FontGetHFont (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->get_hFont
                         (
                           ( HFONT* )  phfont
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_Clone
                         ( void * ptr,
                           BOOL incomingCall,
                           IFont** ppfont
                         )
{
     if( incomingCall )
          {
		    *ppfont = (IFont*)Ocxdisp_FontClone (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->Clone
                         (
                           ( IFont** )  ppfont
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_IsEqual
                         ( void * ptr,
                           BOOL incomingCall,
                           IFont* pFontOther
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_FontIsEqual (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_POINTER)pFontOther);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->IsEqual
                         (
                           ( IFont* )  pFontOther
                         );

}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_SetRatio
                         ( void * ptr,
                           BOOL incomingCall,
                           long cyLogical,
                           long cyHimetric
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_FontSetRatio (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_INTEGER)cyLogical, (EIF_INTEGER)cyHimetric);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->SetRatio
                         (
                           ( long )  cyLogical,
                           ( long )  cyHimetric
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_QueryTextMetrics
                         ( void * ptr,
                           BOOL incomingCall,
                           TEXTMETRICOLE* ptm
                         )
{
     if( incomingCall )
          {
		    *ptm = *(TEXTMETRICOLE*)Ocxdisp_FontQueryTextMetrics (eif_access (eoleOcxDisp), eif_access (ptr));
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->QueryTextMetrics
                         (
                           ( TEXTMETRICOLE* )  ptm
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_AddRefHfont
                         ( void * ptr,
                           BOOL incomingCall,
                           HFONT hfont
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_FontAddRefHfont (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_INTEGER)hfont);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->AddRefHfont
                         (
                           ( HFONT )  hfont
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_ReleaseHfont
                         ( void * ptr,
                           BOOL incomingCall,
                           HFONT hfont
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_FontReleaseHfont (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_INTEGER)hfont);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->ReleaseHfont
                         (
                           ( HFONT )  hfont
                         );
}

//---------------------------------------------------------------------------

extern "C" HRESULT E_IFont_SetHdc
                         ( void * ptr,
                           BOOL incomingCall,
                           HDC hdc
                         )
{
     if( incomingCall )
          {
		    Ocxdisp_FontSetHdc (eif_access (eoleOcxDisp), eif_access (ptr), (EIF_INTEGER)hdc);
            return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
          }
     return ((E_IFont*) ptr)->SetHdc
                         (
                           ( HDC )  hdc
                         );
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_font_get_name( EIF_POINTER ip )
{
  BSTR pname;

  g_hrStatusCode = E_IFont_get_Name ( ip, FALSE, &pname );
  return (EIF_POINTER) pname;
}

//---------------------------------------------------------------------------
extern "C" void eole2_font_put_name ( EIF_POINTER ip, EIF_POINTER name)
{	
   g_hrStatusCode = E_IFont_put_Name ( ip, FALSE, (BSTR)name );

}
//---------------------------------------------------------------------------
extern "C" void eole2_font_get_size( EIF_POINTER ip, EIF_POINTER p_size)
{

   g_hrStatusCode = E_IFont_get_Size ( ip, FALSE, ( CY* )  p_size);

}
//---------------------------------------------------------------------------
extern "C" void eole2_font_put_size( EIF_POINTER ip, EIF_POINTER size)
{
  g_hrStatusCode = E_IFont_put_Size( ip, FALSE, * ((CY *) size));

}
//---------------------------------------------------------------------------
extern "C" EIF_BOOLEAN eole2_font_get_bold ( EIF_POINTER ip)
{
  BOOL bold;

   g_hrStatusCode = E_IFont_get_Bold ( ip, FALSE, ( BOOL* )  &bold );
   return (EIF_BOOLEAN) bold;

}
//---------------------------------------------------------------------------
extern "C" void eole2_font_put_bold ( EIF_POINTER ip, EIF_BOOLEAN bold )
{
   g_hrStatusCode = E_IFont_put_Bold ( ip, FALSE, ( BOOL )  bold );

}
//---------------------------------------------------------------------------
extern "C" EIF_BOOLEAN eole2_font_get_italic( EIF_POINTER ip )

{
  BOOL italic;

   g_hrStatusCode = E_IFont_get_Italic ( ip, FALSE, ( BOOL* )  &italic);
   return (EIF_BOOLEAN) italic;

}
//---------------------------------------------------------------------------
extern "C" void eole2_font_put_italic ( EIF_POINTER ip, EIF_BOOLEAN italic )
{
   g_hrStatusCode = E_IFont_put_Italic ( ip, FALSE, ( BOOL )  italic );

}
//---------------------------------------------------------------------------
extern "C" EIF_BOOLEAN eole2_font_get_underline ( EIF_POINTER ip)
{
   BOOL  underline;

   g_hrStatusCode = E_IFont_get_Underline ( ip, FALSE, ( BOOL* )  &underline);
   return (EIF_BOOLEAN) underline;
}

//---------------------------------------------------------------------------
extern "C" void eole2_font_put_underline
                          ( EIF_POINTER ip,
                            EIF_BOOLEAN underline
                          )
{
  g_hrStatusCode = E_IFont_put_Underline ( ip, FALSE, ( BOOL )  underline);
}
//---------------------------------------------------------------------------
extern "C" EIF_BOOLEAN eole2_font_get_strikethrough ( EIF_POINTER ip )
{
   BOOL  strikethrough;

   g_hrStatusCode = E_IFont_get_Strikethrough
                          ( ip, FALSE,
                           ( BOOL* )  &strikethrough
                          );
    return (EIF_BOOLEAN) strikethrough;

}
//---------------------------------------------------------------------------
extern "C" void eole2_font_put_strikethrough
                          ( EIF_POINTER ip,
                            EIF_BOOLEAN strikethrough
                          )
{
   g_hrStatusCode = E_IFont_put_Strikethrough ( ip, FALSE,
                                                ( BOOL )  strikethrough
                                              );

}
//---------------------------------------------------------------------------
extern "C" EIF_INTEGER eole2_font_get_weight ( EIF_POINTER ip )
{
  short  weight;

  g_hrStatusCode = E_IFont_get_Weight( ip, FALSE,( short* )  &weight );
  return (EIF_INTEGER) weight;
}
//---------------------------------------------------------------------------
extern "C" void eole2_font_put_weight ( EIF_POINTER ip, EIF_INTEGER weight )
{
  g_hrStatusCode = E_IFont_put_Weight ( ip, FALSE, ( short )  weight );

}
//---------------------------------------------------------------------------
extern "C" EIF_INTEGER eole2_font_get_charset
                          ( EIF_POINTER ip
                          )
{
 short charset;

   g_hrStatusCode = E_IFont_get_Charset ( ip, FALSE, ( short* )  &charset );
   return (EIF_INTEGER) charset;
}
//---------------------------------------------------------------------------
extern "C" void eole2_font_put_charset( EIF_POINTER ip, EIF_INTEGER charset)
{
  g_hrStatusCode = E_IFont_put_Charset( ip, FALSE, ( short )  charset );
}
//---------------------------------------------------------------------------
extern "C" EIF_INTEGER eole2_font_get_h_font( EIF_POINTER ip )

{
 HFONT   hfont;

  g_hrStatusCode = E_IFont_get_hFont( ip, FALSE, ( HFONT* ) &hfont );
   return (EIF_INTEGER)  hfont;
}
//---------------------------------------------------------------------------
extern "C" EIF_POINTER eole2_font_clone( EIF_POINTER ip )

{
    IFont * pIFont;

    g_hrStatusCode = E_IFont_Clone( ip, FALSE, ( IFont** )  &pIFont );
    return (EIF_POINTER)pIFont;

}
//---------------------------------------------------------------------------
extern "C" void eole2_font_is_equal ( EIF_POINTER ip, EIF_POINTER font_other)
{
  g_hrStatusCode = E_IFont_IsEqual ( ip, FALSE, ( IFont* )  font_other );
}
//---------------------------------------------------------------------------
extern "C" void eole2_font_set_ratio
                          ( EIF_POINTER ip,
                            EIF_INTEGER cy_logical,
                            EIF_INTEGER cy_himetric
                          )
{
     g_hrStatusCode = E_IFont_SetRatio
                          ( ip, FALSE,
                           ( long )  cy_logical,
                           ( long )  cy_himetric
                          );

}
//---------------------------------------------------------------------------
extern "C" void  eole2_font_query_text_metrics( EIF_POINTER ip, EIF_POINTER ptm )
{

  g_hrStatusCode = E_IFont_QueryTextMetrics
                          ( ip, FALSE,
                           ( TEXTMETRICOLE* )  ptm
                          );

}
//---------------------------------------------------------------------------
extern "C" void eole2_font_add_ref_hfont ( EIF_POINTER ip, EIF_INTEGER hfont )
{
   g_hrStatusCode = E_IFont_AddRefHfont  ( ip, FALSE, ( HFONT )  hfont );

}
//---------------------------------------------------------------------------
extern "C" void eole2_font_release_hfont( EIF_POINTER ip, EIF_INTEGER hfont )
{
  g_hrStatusCode = E_IFont_ReleaseHfont ( ip, FALSE, ( HFONT )  hfont );
}
//---------------------------------------------------------------------------
extern "C" void eole2_font_set_hdc ( EIF_POINTER ip, EIF_INTEGER hdc )
{
   g_hrStatusCode = E_IFont_SetHdc( ip, FALSE, ( HDC )  hdc );

}
//---------------------------------------------------------------------------
