/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IOLECONTAINER_S_H__
#define __ECOM_CONTROL_LIBRARY_IOLECONTAINER_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IOleContainer_FWD_DEFINED__
#define __ecom_control_library_IOleContainer_FWD_DEFINED__
namespace ecom_control_library
{
class IOleContainer;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_IParseDisplayName_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_control_library_IEnumUnknown_FWD_DEFINED__
#define __ecom_control_library_IEnumUnknown_FWD_DEFINED__
namespace ecom_control_library
{
class IEnumUnknown;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IOleContainer_INTERFACE_DEFINED__
#define __ecom_control_library_IOleContainer_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IOleContainer : public ecom_control_library::IParseDisplayName
{
public:
	IOleContainer () {};
	~IOleContainer () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EnumObjects(  /* [in] */ ULONG grf_flags, /* [out] */ ecom_control_library::IEnumUnknown * * ppenum ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP LockContainer(  /* [in] */ LONG f_lock ) = 0;



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