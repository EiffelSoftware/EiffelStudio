/////////////////////////////////////////////////////////////////////////////
//
//     IUNKNOWN.CPP   Copyright (c) 1997 by ISE
//
//     Version:       1.00
//
//     Eiffel OLE 2 Library
//
//     IUnknown suppport
//
//     Functions:
//       E_IUnknown::E_IUnknown
//       E_IUnknown::SetEiffelCurrentPointer
//       E_IUnknown::GetEiffelCurrentPointer
//       E_IUnknown::QueryInterface
//       E_IUnknown::AddRef
//       E_IUnknown::Release
//       E_IUnknown_QueryInterface
//       E_IUnknown_AddRef
//       E_IUnknown_Release
//       eole2_error_succeeded
//       eole2_error_last_hresult
//       eole2_error_last_error_code
//       eole2_error_last_facility_code
//       eole2_error_user_hresult
//       eole2_error_set_error_code
//       eole2_error_set_error_facility
//       eole2_error_set_result_severity
//       eole2_error_set_status_code
//       eole2_create_interface_pointer
//       eole2_unknown_query_interface
//       eole2_unknown_add_ref
//       eole2_unknown_release
//     Globals:
//       g_hrStatusCode
//     Notes:
//       None.
//

#include "eifole.h"
#include "eif_cecil.h"
#include "eif_hector.h"

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

HRESULT g_hrStatusCode;
int user_error_code;
int user_error_facility;
int user_result_severity;

//---------------------------------------------------------------------------

extern "C" EIF_BOOLEAN eole2_error_succeeded() {
	return (EIF_BOOLEAN)SUCCEEDED (g_hrStatusCode);
	}
	
//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_error_last_hresult() {
	return (EIF_INTEGER)g_hrStatusCode;
	}
	
//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_error_last_error_code() {
	return (EIF_INTEGER)HRESULT_CODE (g_hrStatusCode);
	}
	
//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_error_last_facility_code() {
	return (EIF_INTEGER)HRESULT_FACILITY (g_hrStatusCode);
	}
	
//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_error_user_hresult() {
	return (EIF_INTEGER)MAKE_HRESULT (user_result_severity, user_error_facility, user_error_code);
	}
	
extern "C" void eole2_error_set_error_code (EIF_INTEGER code) {
	user_error_code = (int)code;
	}
	
extern "C" void eole2_error_set_error_facility (EIF_INTEGER facility) {
	user_error_facility = (int)facility;
	}
	
extern "C" void eole2_error_set_result_severity (EIF_BOOLEAN success) {
	if (success) 
		user_result_severity = 0;
	else 
		user_result_severity = 1;
	}

extern "C" void eole2_error_set_last_hresult (EIF_INTEGER code) {
	g_hrStatusCode = (HRESULT)code;
	}
	
//---------------------------------------------------------------------------

E_IUnknown::E_IUnknown()
{
    m_pEiffelCurrent = 0;
}

//---------------------------------------------------------------------------

void E_IUnknown::SetEiffelCurrentPointer( EIF_OBJ ptr )
{
		m_pEiffelCurrent = ptr;
}

//---------------------------------------------------------------------------

EIF_OBJ E_IUnknown::GetEiffelCurrentPointer( void ) const
{
    return m_pEiffelCurrent;
}

//---------------------------------------------------------------------------

STDMETHODIMP E_IUnknown::QueryInterface( REFIID riid, LPVOID FAR* ppvObj)
{  
   return E_IUnknown_QueryInterface( m_pEiffelCurrent, TRUE, riid, ppvObj );
}

//---------------------------------------------------------------------------

STDMETHODIMP_( ULONG ) E_IUnknown::AddRef( void )
{
   return E_IUnknown_AddRef( m_pEiffelCurrent, TRUE );
}

//---------------------------------------------------------------------------

STDMETHODIMP_( ULONG ) E_IUnknown::Release( void )
{
   return E_IUnknown_Release( m_pEiffelCurrent, TRUE );
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

extern "C" HRESULT E_IUnknown_QueryInterface( void* ptr, BOOL incomingCall,
        REFIID riid, LPVOID FAR* ppvObj)
{
     if( incomingCall )
    {
        *ppvObj = (void*)Ocxdisp_UnknownQueryInterface (eif_access (eoleOcxDisp), eif_access (ptr),
                                                   GuidToEiffelString (riid));
        return Ocxdisp_UnknownGetStatusCode (eif_access (eoleOcxDisp), eif_access (ptr));
    }
   return ((E_IUnknown*)ptr)->QueryInterface( riid, ppvObj );
}

//---------------------------------------------------------------------------

extern "C" ULONG E_IUnknown_AddRef( void* ptr, BOOL incomingCall )
{
    if( incomingCall )
    {
        return Ocxdisp_UnknownAddRef (eif_access (eoleOcxDisp), eif_access (ptr));
    }

   return ((E_IUnknown*)ptr)->AddRef();
}

//---------------------------------------------------------------------------

extern "C" ULONG E_IUnknown_Release( void *ptr, BOOL incomingCall )
{
    if( incomingCall )
    {
        return Ocxdisp_UnknownRelease (eif_access (eoleOcxDisp), eif_access (ptr));
    }

   return ((E_IUnknown*)ptr)->Release();
}

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_create_interface_pointer( EIF_OBJ eiffelObject,
      EIF_POINTER string_id )
{
   GUID tmpIID;
   EIF_POINTER result = 0;
   
   EiffelStringToGuid( string_id, &tmpIID );

   if( IsEqualGUID( tmpIID, IID_IUnknown ) )
   {
      result = (EIF_POINTER) new E_IUnknown;
   }

/*   else if (IsEqualGUID (tmpIID, IID_IAdviseSink))
   {
      result = (EIF_POINTER) new E_IAdviseSink;
   }
   else if( IsEqualGUID( tmpIID, IID_IAdviseSink2 ) )
   {
      result = (EIF_POINTER) new E_IAdviseSink2;
   }
*/
   else if( IsEqualGUID( tmpIID, IID_IClassFactory ) )
   {
      result = (EIF_POINTER) new E_IClassFactory;
   }
/*
   else if( IsEqualGUID( tmpIID, IID_IClassFactory2 ) )
   {
      result = (EIF_POINTER) new E_IClassFactory2;
   }
*/   
	else if( IsEqualGUID( tmpIID, IID_IConnectionPointContainer ) )
   {
      result = (EIF_POINTER) new E_IConnectionPointContainer;
   }

   else if( IsEqualGUID( tmpIID, IID_IConnectionPoint ) )
   {
      result = (EIF_POINTER) new E_IConnectionPoint;
   }

/*
   else if( IsEqualGUID( tmpIID, IID_ICreateErrorInfo ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_ICreateTypeInfo ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_ICreateTypeLib ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IDataAdviseHolder ) )
   {
   }

   else if( IsEqualGUID( tmpIID, IID_IDataObject ) )
   {
   }*/

   else if (IsEqualGUID (tmpIID, IID_IDispatch)) {
      result = (EIF_POINTER) new E_IDispatch;
   }

/* else if( IsEqualGUID( tmpIID, IID_IDropSource ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IDropTarget ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IErrorInfo ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IExternalConnection ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_ILockBytes ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IMalloc ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IMarshal ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IMessageFilter ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IMoniker ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IOleAdviseHolder ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IOleCache ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IOleCache2 ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IOleCacheControl ) )
   {
   }*/
/*   else if( IsEqualGUID( tmpIID, IID_IOleClientSite ) )
   {
      result = (EIF_POINTER) new E_IOleClientSite;
   }

   else if( IsEqualGUID( tmpIID, IID_IOleContainer ) )
   {
      result = (EIF_POINTER) new E_IOleContainer;
   }
 
   else if( IsEqualGUID( tmpIID, IID_IOleControl ) )
   {
      result = (EIF_POINTER) new E_IOleControl;
   }

   else if( IsEqualGUID( tmpIID, IID_IOleControlSite ) )
   {
      result = (EIF_POINTER) new E_IOleControlSite;
   }

   else if( IsEqualGUID( tmpIID, IID_IOleInPlaceActiveObject ) )
   {
   }

   else if( IsEqualGUID( tmpIID, IID_IOleInPlaceFrame ) )
   {
      result = (EIF_POINTER) new E_IOleInPlaceFrame;
   }

   else if( IsEqualGUID( tmpIID, IID_IOleInPlaceObject ) )
   {
      result = (EIF_POINTER) new E_IOleInPlaceObject;
   }

   else if( IsEqualGUID( tmpIID, IID_IOleInPlaceSite ) )
   {
      result = (EIF_POINTER) new E_IOleInPlaceSite;
   }

   else if( IsEqualGUID( tmpIID, IID_IOleInPlaceUIWindow ) )
   {
      result = (EIF_POINTER)new E_IOleInPlaceUIWindow;
   }
*/
/* else if( IsEqualGUID( tmpIID, IID_IOleItemContainer ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IOleLink ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IOleObject ) )
   {
      result = (EIF_POINTER) new E_IOleObject;
   }
   else if( IsEqualGUID( tmpIID, IID_IOleWindow ) )
   {
      result = (EIF_POINTER) new E_IOleWindow;
   }
   else if( IsEqualGUID( tmpIID, IID_IParseDisplayName ) )
   {
      result = (EIF_POINTER) new E_IParseDisplayName;
   }
   else if( IsEqualGUID( tmpIID, IID_IPerPropertyBrowsing ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IPersist ) )
   {
      result = (EIF_POINTER) new E_IPersist;
   }
   else if( IsEqualGUID( tmpIID, IID_IPersistFile ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IPersistStorage ) )
   {
      result = (EIF_POINTER) new E_IPersistStorage;
   }
*/
   else if( IsEqualGUID( tmpIID, IID_IPersistStream ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IPersistStreamInit ) )
   {
   }

/*   else if( IsEqualGUID( tmpIID, IID_IPropertyNotifySink ) )
   {
      result = (EIF_POINTER) new E_IPropertyNotifySink;
   }
   else if( IsEqualGUID( tmpIID, IID_IPropertyPage ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IPropertyPage2 ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IPropertyPageSite ) )
   {
   }
*/
   else if( IsEqualGUID( tmpIID, IID_IProvideClassInfo ) )
   {
      result = (EIF_POINTER) new E_IProvideClassInfo;
   }
/*   else if( IsEqualGUID( tmpIID, IID_IPSFactory ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IRootStorage ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IROTData ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IRpcChannelBuffer ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IRpcProxyBuffer ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IRpcStubBuffer ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IRunnableObject ) )
   {
      result = (EIF_POINTER) new E_IRunnableObject;
   }
   else if( IsEqualGUID( tmpIID, IID_IRunningObjectTable ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_ISimpleFrameSite ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_ISpecifyPropertyPages ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IStdMarshalInfo ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IStorage ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IStream ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_ISupportErrorInfo ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_ITypeComp ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_ITypeInfo ) )
   {
   }*/
   else if( IsEqualGUID( tmpIID, IID_ITypeLib ) )
   {
      result = (EIF_POINTER) new E_ITypeLib;
   }
/* else if( IsEqualGUID( tmpIID, IID_IUnknown ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IViewObject ) )
   {
      result = (EIF_POINTER) new E_IViewObject;
   }
   else if( IsEqualGUID( tmpIID, IID_IViewObject2 ) )
   {
      result = (EIF_POINTER) new E_IViewObject2;
   }
*/
   else if( IsEqualGUID( tmpIID, IID_IEnumFORMATETC ) )
   {
   }
/*
   else if( IsEqualGUID( tmpIID, IID_IEnumMoniker ) )
   {
   }
*/
   else if( IsEqualGUID( tmpIID, IID_IEnumOLEVERB ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IEnumSTATDATA ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IEnumSTATSTG ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IEnumVARIANT ) )
   {
   }
   else if( IsEqualGUID( tmpIID, IID_IEnumUnknown ) )
   {
  	  result = (EIF_POINTER) new E_IEnumUnknown;
   }
   else if( IsEqualGUID( tmpIID, IID_IEnumConnectionPoints ) )
   {
  	  result = (EIF_POINTER) new E_IEnumConnectionPoints;
   }
   else if( IsEqualGUID( tmpIID, IID_IEnumConnections ) )
   {
  	  result = (EIF_POINTER) new E_IEnumConnections;
   }
   else if( IsEqualGUID( tmpIID, IID_IFont ) )
   {
  	  result = (EIF_POINTER) new E_IFont;
   }
/*   else if( IsEqualGUID( tmpIID, IID_IFontDisp ) )
   {
 	  result = (EIF_POINTER) new E_IFontDisp;
   }
*/
   else if( IsEqualGUID( tmpIID, IID_IPicture ) )
   {
 	  result = (EIF_POINTER) new E_IPicture;
   }
   else
   {
      result = 0;
   }

   if(result)
   {
	  eiffelObject = henter (eiffelObject);
      ((E_IUnknown*)result)->SetEiffelCurrentPointer(eiffelObject);
   }
   return (EIF_POINTER)result;
}

//---------------------------------------------------------------------------

extern "C" EIF_POINTER eole2_unknown_query_interface( EIF_POINTER ip,
      EIF_POINTER string_iid )
{
   EIF_POINTER result_ptr = 0;
   GUID tmpIID;

   EiffelStringToGuid( string_iid, &tmpIID );
   g_hrStatusCode = E_IUnknown_QueryInterface( ip, FALSE, tmpIID, (void**)(&result_ptr) );
   
   return (EIF_POINTER)result_ptr;
}
  
//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_unknown_add_ref( EIF_POINTER ip )
{
   return (EIF_INTEGER)E_IUnknown_AddRef( ip, FALSE );
}

//---------------------------------------------------------------------------

extern "C" EIF_INTEGER eole2_unknown_release( EIF_POINTER ip )
{
   return (EIF_INTEGER)E_IUnknown_Release( ip, FALSE );
}

//---------------------------------------------------------------------------

extern "C" void eole2_update_interface (EIF_REFERENCE unk, EIF_POINTER ptr)
{
//	EIF_OBJ eiffel_object;

//	eiffel_object = ((E_IUnknown*)ptr)->GetEiffelCurrentPointer();
//	if (eiffel_object)
//		eif_wean( eiffel_object );
	((E_IUnknown*)ptr)->SetEiffelCurrentPointer (henter (unk));
}

//---------------------------------------------------------------------------

extern "C" void cpp_delete ( EIF_POINTER ip )
{
   delete ip;
}

/////// END OF FILE /////////////////////////////////////////////////////////

