/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IBINDCTX_S_H__
#define __ECOM_CONTROL_LIBRARY_IBINDCTX_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IBindCtx_FWD_DEFINED__
#define __ecom_control_library_IBindCtx_FWD_DEFINED__
namespace ecom_control_library
{
class IBindCtx;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagBIND_OPTS2_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IRunningObjectTable_FWD_DEFINED__
#define __ecom_control_library_IRunningObjectTable_FWD_DEFINED__
namespace ecom_control_library
{
class IRunningObjectTable;
}
#endif



#ifndef __ecom_control_library_IEnumString_FWD_DEFINED__
#define __ecom_control_library_IEnumString_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumString;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IBindCtx_INTERFACE_DEFINED__
#define __ecom_control_library_IBindCtx_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IBindCtx : public IUnknown
{
public:
	IBindCtx () {};
	~IBindCtx () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RegisterObjectBound(  /* [in] */ IUnknown * punk ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RevokeObjectBound(  /* [in] */ IUnknown * punk ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ReleaseBoundObjects( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteSetBindOptions(  /* [in] */ ecom_control_library::tagBIND_OPTS2 * pbindopts ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteGetBindOptions(  /* [in, out] */ ecom_control_library::tagBIND_OPTS2 * pbindopts ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetRunningObjectTable(  /* [out] */ ecom_control_library::IRunningObjectTable * * pprot ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RegisterObjectParam(  /* [in] */ LPWSTR psz_key, /* [in] */ IUnknown * punk ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetObjectParam(  /* [in] */ LPWSTR psz_key, /* [out] */ IUnknown * * ppunk ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumObjectParam(  /* [out] */ ecom_control_library::IEnumString * * ppenum ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RevokeObjectParam(  /* [in] */ LPWSTR psz_key ) = 0;



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