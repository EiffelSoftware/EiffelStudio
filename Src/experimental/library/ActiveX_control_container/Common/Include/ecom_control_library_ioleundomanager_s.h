/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEUNDOMANAGER_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEUNDOMANAGER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleUndoManager_FWD_DEFINED__
#define __ecom_control_library_IOleUndoManager_FWD_DEFINED__
namespace ecom_control_library
{
class IOleUndoManager;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IOleParentUndoUnit_FWD_DEFINED__
#define __ecom_control_library_IOleParentUndoUnit_FWD_DEFINED__
namespace ecom_control_library
{
class IOleParentUndoUnit;
}
#endif



#ifndef __ecom_control_library_IOleUndoUnit_FWD_DEFINED__
#define __ecom_control_library_IOleUndoUnit_FWD_DEFINED__
namespace ecom_control_library
{
class IOleUndoUnit;
}
#endif



#ifndef __ecom_control_library_IEnumOleUndoUnits_FWD_DEFINED__
#define __ecom_control_library_IEnumOleUndoUnits_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumOleUndoUnits;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleUndoManager_INTERFACE_DEFINED__
#define __ecom_control_library_IOleUndoManager_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleUndoManager : public IUnknown
{
public:
	IOleUndoManager () {};
	~IOleUndoManager () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Open(  /* [in] */ ecom_control_library::IOleParentUndoUnit * p_puu ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Close(  /* [in] */ ecom_control_library::IOleParentUndoUnit * p_puu, /* [in] */ LONG f_commit ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Add(  /* [in] */ ecom_control_library::IOleUndoUnit * p_uu ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetOpenParentState(  /* [out] */ ULONG * pdw_state ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DiscardFrom(  /* [in] */ ecom_control_library::IOleUndoUnit * p_uu ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP UndoTo(  /* [in] */ ecom_control_library::IOleUndoUnit * p_uu ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RedoTo(  /* [in] */ ecom_control_library::IOleUndoUnit * p_uu ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumUndoable(  /* [out] */ ecom_control_library::IEnumOleUndoUnits * * ppenum ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumRedoable(  /* [out] */ ecom_control_library::IEnumOleUndoUnits * * ppenum ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetLastUndoDescription(  /* [out] */ BSTR * p_bstr ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetLastRedoDescription(  /* [out] */ BSTR * p_bstr ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Enable(  /* [in] */ LONG f_enable ) = 0;



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