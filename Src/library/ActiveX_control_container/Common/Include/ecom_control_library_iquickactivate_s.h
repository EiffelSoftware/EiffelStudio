/*-----------------------------------------------------------
Control interfaces. Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY_IQUICKACTIVATE_S_H__
#define __ECOM_CONTROL_LIBRARY_IQUICKACTIVATE_S_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_control_library_IQuickActivate_FWD_DEFINED__
#define __ecom_control_library_IQuickActivate_FWD_DEFINED__
namespace ecom_control_library
{
class IQuickActivate;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_control_library_tagQACONTAINER_s.h"

#include "ecom_control_library_tagQACONTROL_s.h"

#include "ecom_control_library_tagSIZEL_s.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
#ifndef __ecom_control_library_IQuickActivate_INTERFACE_DEFINED__
#define __ecom_control_library_IQuickActivate_INTERFACE_DEFINED__
namespace ecom_control_library
{
class IQuickActivate : public IUnknown
{
public:
	IQuickActivate () {};
	~IQuickActivate () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RemoteQuickActivate(  /* [in] */ ecom_control_library::tagQACONTAINER * p_qa_container, /* [out] */ ecom_control_library::tagQACONTROL * p_qa_control ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetContentExtent(  /* [in] */ ecom_control_library::tagSIZEL * psizel ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetContentExtent(  /* [out] */ ecom_control_library::tagSIZEL * psizel ) = 0;



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