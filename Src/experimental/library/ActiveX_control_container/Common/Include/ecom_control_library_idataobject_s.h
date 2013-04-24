/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDATAOBJECT_S_H__
#define __ECOM_CONTROL_LIBRARY_IDATAOBJECT_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IDataObject_FWD_DEFINED__
#define __ecom_control_library_IDataObject_FWD_DEFINED__
namespace ecom_control_library
{
class IDataObject;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagFORMATETC_s.h"

#include "ecom_aliases.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IEnumFORMATETC_FWD_DEFINED__
#define __ecom_control_library_IEnumFORMATETC_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumFORMATETC;
}
#endif



#ifndef __ecom_control_library_IAdviseSink_FWD_DEFINED__
#define __ecom_control_library_IAdviseSink_FWD_DEFINED__
namespace ecom_control_library
{
class IAdviseSink;
}
#endif



#ifndef __ecom_control_library_IEnumSTATDATA_FWD_DEFINED__
#define __ecom_control_library_IEnumSTATDATA_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumSTATDATA;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IDataObject_INTERFACE_DEFINED__
#define __ecom_control_library_IDataObject_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IDataObject : public IUnknown
{
public:
  IDataObject () {};
  ~IDataObject () {};

  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetData(  /* [in] */ ecom_control_library::tagFORMATETC * pformatetc_in, /* [out] */ ecom_control_library::_userSTGMEDIUM * * p_medium ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetDataHere(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in, out] */ ecom_control_library::_userSTGMEDIUM * * p_medium ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP QueryGetData(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP GetCanonicalFormatEtc(  /* [in] */ ecom_control_library::tagFORMATETC * pformatect_in, /* [out] */ ecom_control_library::tagFORMATETC * pformatetc_out ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP SetData(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in] */ ecom_control_library::_userFLAG_STGMEDIUM * * pmedium, /* [in] */ LONG f_release ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP EnumFormatEtc(  /* [in] */ ULONG dw_direction, /* [out] */ ecom_control_library::IEnumFORMATETC * * ppenum_format_etc ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP DAdvise(  /* [in] */ ecom_control_library::tagFORMATETC * p_formatetc, /* [in] */ ULONG advf, /* [in] */ ecom_control_library::IAdviseSink * p_adv_sink, /* [out] */ ULONG * pdw_connection ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP DUnadvise(  /* [in] */ ULONG dw_connection ) = 0;


  /*-----------------------------------------------------------
  No description available.
  -----------------------------------------------------------*/
  virtual STDMETHODIMP EnumDAdvise(  /* [out] */ ecom_control_library::IEnumSTATDATA * * ppenum_advise ) = 0;



protected:


private:


};
}
#endif
}
#endif

#ifdef __cplusplus
}
#endif

#endif
