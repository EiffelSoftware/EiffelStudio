/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLEPARENTUNDOUNIT_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLEPARENTUNDOUNIT_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleParentUndoUnit_FWD_DEFINED__
#define __ecom_control_library_IOleParentUndoUnit_FWD_DEFINED__
namespace ecom_control_library
{
class IOleParentUndoUnit;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IOleUndoUnit_s.h"

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



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleParentUndoUnit_INTERFACE_DEFINED__
#define __ecom_control_library_IOleParentUndoUnit_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleParentUndoUnit : public ecom_control_library::IOleUndoUnit
{
public:
	IOleParentUndoUnit () {};
	~IOleParentUndoUnit () {};

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
	virtual STDMETHODIMP FindUnit(  /* [in] */ ecom_control_library::IOleUndoUnit * p_uu ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetParentState(  /* [out] */ ULONG * pdw_state ) = 0;



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