/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEUNDOUNIT_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEUNDOUNIT_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleUndoUnit_FWD_DEFINED__
#define __ecom_control_library_IOleUndoUnit_FWD_DEFINED__
namespace ecom_control_library
{
class IOleUndoUnit;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IOleUndoManager_FWD_DEFINED__
#define __ecom_control_library_IOleUndoManager_FWD_DEFINED__
namespace ecom_control_library
{
class IOleUndoManager;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleUndoUnit_INTERFACE_DEFINED__
#define __ecom_control_library_IOleUndoUnit_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleUndoUnit : public IUnknown
{
public:
	IOleUndoUnit () {};
	~IOleUndoUnit () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Do(  /* [in] */ ecom_control_library::IOleUndoManager * p_undo_manager ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetDescription(  /* [out] */ BSTR * p_bstr ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetUnitType(  /* [out] */ GUID * p_clsid, /* [out] */ LONG * pl_id ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP OnNextAdd( void ) = 0;



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