/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IDROPTARGET_S_H__
#define __ECOM_CONTROL_LIBRARY_IDROPTARGET_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IDropTarget_FWD_DEFINED__
#define __ecom_control_library_IDropTarget_FWD_DEFINED__
namespace ecom_control_library
{
class IDropTarget;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library__POINTL_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IDataObject_FWD_DEFINED__
#define __ecom_control_library_IDataObject_FWD_DEFINED__
namespace ecom_control_library
{
class IDataObject;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IDropTarget_INTERFACE_DEFINED__
#define __ecom_control_library_IDropTarget_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IDropTarget : public IUnknown
{
public:
	IDropTarget () {};
	~IDropTarget () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DragEnter(  /* [in] */ ecom_control_library::IDataObject * p_data_obj, /* [in] */ ULONG grf_key_state, /* [in] */ ecom_control_library::_POINTL pt, /* [in, out] */ ULONG * pdw_effect ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DragOver(  /* [in] */ ULONG grf_key_state, /* [in] */ ecom_control_library::_POINTL pt, /* [in, out] */ ULONG * pdw_effect ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DragLeave( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Drop(  /* [in] */ ecom_control_library::IDataObject * p_data_obj, /* [in] */ ULONG grf_key_state, /* [in] */ ecom_control_library::_POINTL pt, /* [in, out] */ ULONG * pdw_effect ) = 0;



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