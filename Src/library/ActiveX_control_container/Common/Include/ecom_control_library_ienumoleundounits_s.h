/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IENUMOLEUNDOUNITS_S_H__
#define __ECOM_CONTROL_LIBRARY_IENUMOLEUNDOUNITS_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IEnumOleUndoUnits_FWD_DEFINED__
#define __ecom_control_library_IEnumOleUndoUnits_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumOleUndoUnits;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
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
#ifndef __ecom_control_library_IEnumOleUndoUnits_INTERFACE_DEFINED__
#define __ecom_control_library_IEnumOleUndoUnits_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IEnumOleUndoUnits : public IUnknown
{
public:
	IEnumOleUndoUnits () {};
	~IEnumOleUndoUnits () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteNext(  /* [in] */ ULONG celt, /* [out] */ ecom_control_library::IOleUndoUnit * * rgelt, /* [out] */ ULONG * pcelt_fetched ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Skip(  /* [in] */ ULONG celt ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Reset( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Clone(  /* [out] */ ecom_control_library::IEnumOleUndoUnits * * ppenum ) = 0;



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