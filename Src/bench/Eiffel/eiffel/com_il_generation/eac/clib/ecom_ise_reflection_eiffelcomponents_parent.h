/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS_PARENT_H__
#define __ECOM_ISE_REFLECTION_EIFFELCOMPONENTS_PARENT_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_ISE_Reflection_EiffelComponents
{
class Parent;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_ISE_Reflection_EiffelComponents__Parent.h"

#include "ecom_ISE_Reflection_EiffelComponents__SelectClause.h"

#include "ecom_ISE_Reflection_EiffelComponents__UndefineClause.h"

#include "ecom_ISE_Reflection_EiffelComponents__ExportClause.h"

#include "ecom_ISE_Reflection_EiffelComponents__RedefineClause.h"

#include "ecom_ISE_Reflection_EiffelComponents__RenameClause.h"

#include "ecom_grt_globals_ISE_c.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_ISE_Reflection_EiffelComponents
{
class Parent
{
public:
	Parent ();
	Parent (IUnknown * a_pointer);
	virtual ~Parent ();

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
	void ccom_add_select_clause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_SelectClause * a_clause );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_redefine_clauses(  /* [in] */ IDispatch * a_list );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_undefine_clauses(  /* [in] */ IDispatch * a_list );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_export_clauses(  /* [in] */ IDispatch * a_list );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_name(  /* [in] */ EIF_OBJECT a_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_rename_clauses(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_export_clauses(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_rename_clauses(  /* [in] */ IDispatch * a_list );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_undefine_clause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_UndefineClause * a_clause );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_name(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_export_clause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_ExportClause * a_clause );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_select_clauses(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_redefine_clause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_RedefineClause * a_clause );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_redefine_clauses(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_undefine_clauses(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_add_rename_clause(  /* [in] */ ecom_ISE_Reflection_EiffelComponents::_RenameClause * a_clause );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_make1(  /* [in] */ EIF_OBJECT a_name );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_select_clauses(  /* [in] */ IDispatch * a_list );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_x_internal_rename_clauses(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_ref__internal_rename_clauses(  /* [in] */ IDispatch * p_ret_val );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_x_internal_export_clauses(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_ref__internal_export_clauses(  /* [in] */ IDispatch * p_ret_val );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_x_internal_name(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set__internal_name(  /* [in] */ EIF_OBJECT p_ret_val );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_x_internal_select_clauses(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_ref__internal_select_clauses(  /* [in] */ IDispatch * p_ret_val );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_x_internal_redefine_clauses(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_ref__internal_redefine_clauses(  /* [in] */ IDispatch * p_ret_val );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_x_internal_undefine_clauses(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_set_ref__internal_undefine_clauses(  /* [in] */ IDispatch * p_ret_val );


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
	ecom_ISE_Reflection_EiffelComponents::_Parent * p__Parent;


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