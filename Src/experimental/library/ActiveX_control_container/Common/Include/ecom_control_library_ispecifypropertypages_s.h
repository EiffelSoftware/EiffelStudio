/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_ISPECIFYPROPERTYPAGES_S_H__
#define __ECOM_CONTROL_LIBRARY_ISPECIFYPROPERTYPAGES_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_ISpecifyPropertyPages_FWD_DEFINED__
#define __ecom_control_library_ISpecifyPropertyPages_FWD_DEFINED__
namespace ecom_control_library
{
class ISpecifyPropertyPages;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagCAUUID_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_ISpecifyPropertyPages_INTERFACE_DEFINED__
#define __ecom_control_library_ISpecifyPropertyPages_INTERFACE_DEFINED__
namespace ecom_control_library
{
class ISpecifyPropertyPages : public IUnknown
{
public:
	ISpecifyPropertyPages () {};
	~ISpecifyPropertyPages () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetPages(  /* [out] */ ecom_control_library::tagCAUUID * p_pages ) = 0;



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