/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS__PARENT_H__
#define __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS__PARENT_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_ISE_Reflection_EiffelComponents__Parent_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__Parent_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _Parent;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_ISE_Reflection_EiffelComponents__SelectClause_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__SelectClause_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _SelectClause;
}
#endif



#ifndef __ecom_ISE_Reflection_EiffelComponents__UndefineClause_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__UndefineClause_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _UndefineClause;
}
#endif



#ifndef __ecom_ISE_Reflection_EiffelComponents__ExportClause_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__ExportClause_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _ExportClause;
}
#endif



#ifndef __ecom_ISE_Reflection_EiffelComponents__RedefineClause_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__RedefineClause_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _RedefineClause;
}
#endif



#ifndef __ecom_ISE_Reflection_EiffelComponents__RenameClause_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__RenameClause_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _RenameClause;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_ISE_Reflection_EiffelComponents__Parent_INTERFACE_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__Parent_INTERFACE_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _Parent : public IDispatch
{
public:
	_Parent () {};
	~_Parent () {};

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ToString(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Equals(  /* [in] */ VARIANT obj, /* [out, retval] */ VARIANT_BOOL * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetHashCode(  /* [out, retval] */ LONG * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GetType(  /* [out, retval] */ LONG * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddSelectClause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_SelectClause * a_clause ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetRedefineClauses(  /* [in] */ IDispatch * a_list ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetUndefineClauses(  /* [in] */ IDispatch * a_list ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetExportClauses(  /* [in] */ IDispatch * a_list ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetName(  /* [in] */ BSTR a_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RenameClauses(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP ExportClauses(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetRenameClauses(  /* [in] */ IDispatch * a_list ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddUndefineClause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_UndefineClause * a_clause ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Name(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddExportClause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_ExportClause * a_clause ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SelectClauses(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddRedefineClause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_RedefineClause * a_clause ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP RedefineClauses(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP UndefineClauses(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AddRenameClause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_RenameClause * a_clause ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Make(  /* [in] */ BSTR a_name ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP SetSelectClauses(  /* [in] */ IDispatch * a_list ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_RenameClauses(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_RenameClauses(  /* [in] */ IDispatch * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_ExportClauses(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_ExportClauses(  /* [in] */ IDispatch * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_Name(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set__internal_Name(  /* [in] */ BSTR p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_SelectClauses(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_SelectClauses(  /* [in] */ IDispatch * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_RedefineClauses(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_RedefineClauses(  /* [in] */ IDispatch * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_UndefineClauses(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_UndefineClauses(  /* [in] */ IDispatch * p_ret_val ) = 0;



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