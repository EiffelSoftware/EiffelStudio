/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_CODEGENERATOR_EIFFELCODEGENERATORFROMXML_H__
#define __ECOM_ISE_REFLECTION_CODEGENERATOR_EIFFELCODEGENERATORFROMXML_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_ISE_Reflection_CodeGenerator
{
class EiffelCodeGeneratorFromXml;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_ISE_Reflection_CodeGenerator__EiffelCodeGeneratorFromXml.h"

#include "ecom_ISE_Reflection_EiffelComponents__EiffelClass.h"

#include "ecom_ISE_Reflection_CodeGenerator__EiffelCodeGenerator.h"

#include "ecom_grt_globals_ISE_c.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_ISE_Reflection_CodeGenerator
{
class EiffelCodeGeneratorFromXml
{
public:
	EiffelCodeGeneratorFromXml ();
	EiffelCodeGeneratorFromXml (IUnknown * a_pointer);
	virtual ~EiffelCodeGeneratorFromXml ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_to_string(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_equals(  /* [in] */ VARIANT * obj );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_get_hash_code(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_get_type(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_eiffel_code_from_xml_and_path(  /* [in] */ EIF_OBJECT type_description_filename,  /* [in] */ EIF_OBJECT a_path );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_eiffel_assembly(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_generate_eiffel_code_from_xml(  /* [in] */ EIF_OBJECT type_description_filename );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_eiffel_class_from_xml(  /* [in] */ EIF_OBJECT type_description_filename );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_eiffel_code_generator(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_make_from_info(  /* [in] */ EIF_OBJECT an_assembly_description_filename );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assembly_description_filename(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_update_assembly_description(  /* [in] */ EIF_OBJECT new_path );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_make_from_info_and_path(  /* [in] */ EIF_OBJECT an_assembly_description_filename,  /* [in] */ EIF_OBJECT new_path );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_dotnet_library_relative_path(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_make1();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_x_internal_eiffel_assembly(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_ref__internal_eiffel_assembly(  /* [in] */ IDispatch * p_ret_val );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_x_internal_eiffel_code_generator(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_ref__internal_eiffel_code_generator(  /* [in] */ ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGenerator * p_ret_val );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_x_internal_assembly_description_filename(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set__internal_assembly_description_filename(  /* [in] */ EIF_OBJECT p_ret_val );


	/*-----------------------------------------------------------
	Last error code
	-----------------------------------------------------------*/
	EIF_INTEGER ccom_last_error_code();


	/*-----------------------------------------------------------
	Last source of exception
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_source_of_exception();


	/*-----------------------------------------------------------
	Last error description
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_description();


	/*-----------------------------------------------------------
	Last error help file
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_last_error_help_file();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_ISE_Reflection_CodeGenerator::_EiffelCodeGeneratorFromXml * p__EiffelCodeGeneratorFromXml;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;


	/*-----------------------------------------------------------
	Exception information
	-----------------------------------------------------------*/
	EXCEPINFO * excepinfo;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_ISE_c.h"


#endif