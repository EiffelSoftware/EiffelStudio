/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_CODEGENERATOR__EIFFELCODEGENERATORFROMXML_H__
#define __ECOM_ISE_REFLECTION_CODEGENERATOR__EIFFELCODEGENERATORFROMXML_H__
#ifdef __cplusplus
extern "C" {


#ifndef __ecom_ISE_Reflection_CodeGenerator__EiffelCodeGeneratorFromXml_FWD_DEFINED__
#define __ecom_ISE_Reflection_CodeGenerator__EiffelCodeGeneratorFromXml_FWD_DEFINED__
namespace ecom_ISE_Reflection_CodeGenerator
{
class _EiffelCodeGeneratorFromXml;
}
#endif

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifndef __ecom_ISE_Reflection_EiffelComponents__EiffelClass_FWD_DEFINED__
#define __ecom_ISE_Reflection_EiffelComponents__EiffelClass_FWD_DEFINED__
namespace ecom_ISE_Reflection_EiffelComponents
{
class _EiffelClass;
}
#endif



#ifndef __ecom_ISE_Reflection_CodeGenerator__EiffelCodeGenerator_FWD_DEFINED__
#define __ecom_ISE_Reflection_CodeGenerator__EiffelCodeGenerator_FWD_DEFINED__
namespace ecom_ISE_Reflection_CodeGenerator
{
class _EiffelCodeGenerator;
}
#endif



#ifdef __cplusplus
extern "C" {
#ifndef __ecom_ISE_Reflection_CodeGenerator__EiffelCodeGeneratorFromXml_INTERFACE_DEFINED__
#define __ecom_ISE_Reflection_CodeGenerator__EiffelCodeGeneratorFromXml_INTERFACE_DEFINED__
namespace ecom_ISE_Reflection_CodeGenerator
{
class _EiffelCodeGeneratorFromXml : public IDispatch
{
public:
	_EiffelCodeGeneratorFromXml () {};
	~_EiffelCodeGeneratorFromXml () {};

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
	virtual STDMETHODIMP GenerateEiffelCodeFromXmlAndPath(  /* [in] */ BSTR type_description_filename, /* [in] */ BSTR a_path ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EiffelAssembly(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP GenerateEiffelCodeFromXml(  /* [in] */ BSTR type_description_filename ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP EiffelClassFromXml(  /* [in] */ BSTR type_description_filename, /* [out, retval] */ ecom_ISE_Reflection_EiffelComponents::_EiffelClass * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP a_EiffelCodeGenerator(  /* [out, retval] */ ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP MakeFromInfo(  /* [in] */ BSTR an_assembly_description_filename ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP AssemblyDescriptionFilename(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP UpdateAssemblyDescription(  /* [in] */ BSTR new_path ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP MakeFromInfoAndPath(  /* [in] */ BSTR an_assembly_description_filename, /* [in] */ BSTR new_path ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP DotnetLibraryRelativePath(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP Make( void ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_EiffelAssembly(  /* [out, retval] */ IDispatch * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_EiffelAssembly(  /* [in] */ IDispatch * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_EiffelCodeGenerator(  /* [out, retval] */ ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator * * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set_ref__internal_EiffelCodeGenerator(  /* [in] */ ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP _internal_AssemblyDescriptionFilename(  /* [out, retval] */ BSTR * p_ret_val ) = 0;


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	virtual STDMETHODIMP set__internal_AssemblyDescriptionFilename(  /* [in] */ BSTR p_ret_val ) = 0;



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