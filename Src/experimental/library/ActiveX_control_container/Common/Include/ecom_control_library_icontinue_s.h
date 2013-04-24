/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ICONTINUE_S_H__
#define __ECOM_CONTROL_LIBRARY_ICONTINUE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IContinue_FWD_DEFINED__
#define __ecom_control_library_IContinue_FWD_DEFINED__
namespace ecom_control_library
{
class IContinue;
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
#ifndef __ecom_control_library_IContinue_INTERFACE_DEFINED__
#define __ecom_control_library_IContinue_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IContinue : public IUnknown
{
public:
	IContinue () {};
	~IContinue () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP FContinue( void ) = 0;



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