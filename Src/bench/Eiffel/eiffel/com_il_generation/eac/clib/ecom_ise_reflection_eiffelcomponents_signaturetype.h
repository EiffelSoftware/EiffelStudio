/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS_SIGNATURETYPE_H__
#define __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS_SIGNATURETYPE_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_ISE_Reflection_EiffelComponents
{
class SignatureType;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_ISE_Reflection_EiffelComponents__SignatureType.h"

#include "ecom_ISE_Reflection_EiffelComponents_ISignatureType.h"

#include "ecom_grt_globals_ISE_c.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_ISE_Reflection_EiffelComponents
{
class SignatureType
{
public:
	SignatureType ();
	SignatureType (IUnknown * a_pointer);
	virtual ~SignatureType ();

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
	EIF_REFERENCE ccom_internal_type_full_external_name(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_internal_type_eiffel_name(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_make1();


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_type_eiffel_name(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_type_full_external_name(  /* [in] */ EIF_OBJECT a_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_type_eiffel_name(  /* [in] */ EIF_OBJECT a_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_type_full_external_name(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_x_internal_internal_type_full_external_name(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set__internal_internal_type_full_external_name(  /* [in] */ EIF_OBJECT p_ret_val );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_x_internal_internal_type_eiffel_name(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set__internal_internal_type_eiffel_name(  /* [in] */ EIF_OBJECT p_ret_val );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_isignature_type_type_eiffel_name1(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_isignature_type_set_type_full_external_name1(  /* [in] */ EIF_OBJECT a_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_isignature_type_set_type_eiffel_name1(  /* [in] */ EIF_OBJECT a_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_isignature_type_type_full_external_name1(  );


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
	ecom_ISE_Reflection_EiffelComponents::_SignatureType * p__SignatureType;


	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_ISE_Reflection_EiffelComponents::ISignatureType * p_ISignatureType;


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