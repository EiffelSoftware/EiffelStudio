/*-----------------------------------------------------------
Implemented `IDocHostUIHandlerDispatch' Interface.
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDOCHOSTUIHANDLERDISPATCH_IMPL_STUB_S_H__
#define __ECOM_CONTROL_LIBRARY_IDOCHOSTUIHANDLERDISPATCH_IMPL_STUB_S_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_control_library
{
class IDocHostUIHandlerDispatch_impl_stub;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_server_rt_globals.h"



#include "ecom_control_library_IDocHostUIHandlerDispatch_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_control_library
{
class IDocHostUIHandlerDispatch_impl_stub : public ecom_control_library::IDocHostUIHandlerDispatch
{
public:
  IDocHostUIHandlerDispatch_impl_stub (EIF_OBJECT eif_obj);
  virtual ~IDocHostUIHandlerDispatch_impl_stub ();

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ShowContextMenu(  /* [in] */ ULONG dw_id, /* [in] */ ULONG x, /* [in] */ ULONG y, /* [in] */ IUnknown * pcmdt_reserved, /* [in] */ IDispatch * pdisp_reserved, /* [out, retval] */ HRESULT * dw_ret_val );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetHostInfo(  /* [in, out] */ ULONG * pdw_flags, /* [in, out] */ ULONG * pdw_double_click );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ShowUI(  /* [in] */ ULONG dw_id, /* [in] */ IUnknown * p_active_object, /* [in] */ IUnknown * p_command_target, /* [in] */ IUnknown * p_frame, /* [in] */ IUnknown * p_doc, /* [out, retval] */ HRESULT * dw_ret_val );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP HideUI( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP UpdateUI( void );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP EnableModeless(  /* [in] */ VARIANT_BOOL f_enable );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnDocWindowActivate(  /* [in] */ VARIANT_BOOL f_activate );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP OnFrameWindowActivate(  /* [in] */ VARIANT_BOOL f_activate );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP ResizeBorder(  /* [in] */ LONG left, /* [in] */ LONG top, /* [in] */ LONG right, /* [in] */ LONG bottom, /* [in] */ IUnknown * p_uiwindow, /* [in] */ VARIANT_BOOL f_frame_window );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP TranslateAccelerator(  /* [in] */ ULONG h_wnd, /* [in] */ ULONG n_message, /* [in] */ ULONG w_param, /* [in] */ ULONG l_param, /* [in] */ BSTR bstr_guid_cmd_group, /* [in] */ ULONG n_cmd_id, /* [out, retval] */ HRESULT * dw_ret_val );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetOptionKeyPath(  /* [out] */ BSTR * pbstr_key, /* [in] */ ULONG dw );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetDropTarget(  /* [in] */ IUnknown * p_drop_target, /* [out] */ IUnknown * * pp_drop_target );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP GetExternal(  /* [out] */ IDispatch * * pp_dispatch );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP TranslateUrl(  /* [in] */ ULONG dw_translate, /* [in] */ BSTR bstr_urlin, /* [out] */ BSTR * pbstr_urlout );


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  STDMETHODIMP FilterDataObject(  /* [in] */ IUnknown * p_do, /* [out] */ IUnknown * * pp_doret );


  /*-----------------------------------------------------------
  Get type info
  -----------------------------------------------------------*/
  STDMETHODIMP GetTypeInfo( unsigned int itinfo, LCID lcid, ITypeInfo **pptinfo );


  /*-----------------------------------------------------------
  Get type info count
  -----------------------------------------------------------*/
  STDMETHODIMP GetTypeInfoCount( unsigned int * pctinfo );


  /*-----------------------------------------------------------
  IDs of function names 'rgszNames'
  -----------------------------------------------------------*/
  STDMETHODIMP GetIDsOfNames( REFIID riid, OLECHAR ** rgszNames, unsigned int cNames, LCID lcid, DISPID *rgdispid );


  /*-----------------------------------------------------------
  Invoke function.
  -----------------------------------------------------------*/
  STDMETHODIMP Invoke( DISPID dispID, REFIID riid, LCID lcid, unsigned short wFlags, DISPPARAMS *pDispParams, VARIANT *pVarResult, EXCEPINFO *pExcepInfo, unsigned int *puArgErr );


  /*-----------------------------------------------------------
  Decrement reference count
  -----------------------------------------------------------*/
  STDMETHODIMP_(ULONG) Release();


  /*-----------------------------------------------------------
  Increment reference count
  -----------------------------------------------------------*/
  STDMETHODIMP_(ULONG) AddRef();


  /*-----------------------------------------------------------
  Query Interface
  -----------------------------------------------------------*/
  STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );



protected:


private:
  /*-----------------------------------------------------------
  Reference counter
  -----------------------------------------------------------*/
  LONG ref_count;


  /*-----------------------------------------------------------
  Corresponding Eiffel object
  -----------------------------------------------------------*/
  EIF_OBJECT eiffel_object;


  /*-----------------------------------------------------------
  Eiffel type id
  -----------------------------------------------------------*/
  EIF_TYPE_ID type_id;


  /*-----------------------------------------------------------
  Type information
  -----------------------------------------------------------*/
  ITypeInfo * pTypeInfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_control_interfaces2.h"


#endif
