/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS__EIFFELCOMPONENTS_H__
#define __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS__EIFFELCOMPONENTS_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_ISE_Reflection_EiffelComponents__EiffelComponents_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__EiffelComponents_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _EiffelComponents;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_ISE_Reflection_EiffelComponents__ExportClause_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__ExportClause_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _ExportClause;
}
#endif



#ifndef __ecom_ISE_Reflection_EiffelComponents__NamedSignatureType_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__NamedSignatureType_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _NamedSignatureType;
}
#endif



#ifndef __ecom_ISE_Reflection_EiffelComponents__SelectClause_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__SelectClause_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _SelectClause;
}
#endif



#ifndef __ecom_ISE_Reflection_EiffelComponents__EiffelClass_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__EiffelClass_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _EiffelClass;
}
#endif



#ifndef __ecom_ISE_Reflection_EiffelComponents__FormalNamedSignatureType_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__FormalNamedSignatureType_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _FormalNamedSignatureType;
}
#endif



#ifndef __ecom_ISE_Reflection_EiffelComponents__RenameClause_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__RenameClause_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _RenameClause;
}
#endif



#ifndef __ecom_ISE_Reflection_EiffelComponents__RedefineClause_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__RedefineClause_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _RedefineClause;
}
#endif



#ifndef __ecom_ISE_Reflection_EiffelComponents__UndefineClause_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__UndefineClause_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _UndefineClause;
}
#endif



#ifndef __ecom_ISE_Reflection_EiffelComponents__EiffelAssemblyFactory_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__EiffelAssemblyFactory_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _EiffelAssemblyFactory;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_ISE_Reflection_EiffelComponents__EiffelComponents_INTERFACE_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__EiffelComponents_INTERFACE_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _EiffelComponents : public IDispatch
{
public:
	_EiffelComponents () {};
	~_EiffelComponents () {};

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
	virtual STDMETHODIMP a_ExportClause(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_ExportClause * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP a_NamedSignatureType(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_NamedSignatureType * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP a_SelectClause(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_SelectClause * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP a_EiffelClass(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_EiffelClass * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP a_FormalNamedSignatureType(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_FormalNamedSignatureType * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP a_RenameClause(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_RenameClause * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP a_RedefineClause(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_RedefineClause * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP a_UndefineClause(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_UndefineClause * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Make( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AssemblyFactory(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_EiffelAssemblyFactory * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_ExportClause(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_ExportClause * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_ExportClause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_ExportClause * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_NamedSignatureType(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_NamedSignatureType * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_NamedSignatureType(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_NamedSignatureType * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_SelectClause(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_SelectClause * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_SelectClause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_SelectClause * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_EiffelClass(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_EiffelClass * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_EiffelClass(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_EiffelClass * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_FormalNamedSignatureType(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_FormalNamedSignatureType * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_FormalNamedSignatureType(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_FormalNamedSignatureType * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_RenameClause(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_RenameClause * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_RenameClause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_RenameClause * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_RedefineClause(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_RedefineClause * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_RedefineClause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_RedefineClause * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_UndefineClause(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_UndefineClause * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_UndefineClause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_UndefineClause * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_AssemblyFactory(  /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_EiffelAssemblyFactory * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_AssemblyFactory(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_EiffelAssemblyFactory * p_ret_val ) = 0;



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