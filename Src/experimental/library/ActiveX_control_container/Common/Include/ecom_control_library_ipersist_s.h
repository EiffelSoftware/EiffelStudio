/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IPERSIST_S_H__
#define __ECOM_CONTROL_LIBRARY_IPERSIST_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IPersist_FWD_DEFINED__
#define __ecom_control_library_IPersist_FWD_DEFINED__
namespace ecom_control_library
{
class IPersist;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IPersist_INTERFACE_DEFINED__
#define __ecom_control_library_IPersist_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IPersist : public IUnknown
{
public:
	IPersist () {};
	~IPersist () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP IPersist_GetClassID(  /* [out] */ GUID * p_class_id ) = 0;



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