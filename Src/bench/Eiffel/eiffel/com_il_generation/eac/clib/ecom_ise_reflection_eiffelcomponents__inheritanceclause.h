/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS__INHERITANCECLAUSE_H__
#define __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS__INHERITANCECLAUSE_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_ISE_Reflection_EiffelComponents__InheritanceClause_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__InheritanceClause_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _InheritanceClause;
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
#ifndef __ecom_ISE_Reflection_EiffelComponents__InheritanceClause_INTERFACE_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__InheritanceClause_INTERFACE_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _InheritanceClause : public IDispatch
{
public:
	_InheritanceClause () {};
	~_InheritanceClause () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _InheritanceClause_ToString(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _InheritanceClause_Equals(  /* [in] */ VARIANT obj, /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _InheritanceClause_GetHashCode(  /* [out, retval] */ LONG * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _InheritanceClause_GetType(  /* [out, retval] */ LONG * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _InheritanceClause_SourceName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _InheritanceClause_StringRepresentation(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _InheritanceClause_EiffelKeyword(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _InheritanceClause_SetSourceName(  /* [in] */ BSTR a_source_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _InheritanceClause__internal_SourceName(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _InheritanceClause_set__internal_SourceName(  /* [in] */ BSTR p_ret_val ) = 0;



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