/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ASSEMBLYMANAGERINTERFACE_ASSEMBLYMANAGERINTERFACE_H__
#define __ECOM_ASSEMBLYMANAGERINTERFACE_ASSEMBLYMANAGERINTERFACE_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_AssemblyManagerInterface
{
class AssemblyManagerInterface;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_AssemblyManagerInterface_IAssemblyManagerInterface.h"

#include "ecom_grt_globals_AssemblyManagerInterface_c.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_AssemblyManagerInterface
{
class AssemblyManagerInterface
{
public:
	AssemblyManagerInterface ();
	AssemblyManagerInterface (IUnknown * a_pointer);
	virtual ~AssemblyManagerInterface ();

	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_imported_assemblies(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_last_importation_successful(  );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assembly_location(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_OBJECT version,  /* [in] */ EIF_OBJECT culture,  /* [in] */ EIF_OBJECT public_key );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_local_assembly_dependencies(  /* [in] */ EIF_OBJECT filename );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_assembly_dependencies(  /* [in] */ EIF_OBJECT name,  /* [in] */ EIF_OBJECT version,  /* [in] */ EIF_OBJECT culture,  /* [in] */ EIF_OBJECT public_key );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	EIF_BOOLEAN ccom_is_signed(  /* [in] */ EIF_OBJECT filename );


	/*-----------------------------------------------------------
	No description available.
	-----------------------------------------------------------*/
	void ccom_clean_assemblies();


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_AssemblyManagerInterface::IAssemblyManagerInterface * p_IAssemblyManagerInterface;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_AssemblyManagerInterface_c.h"


#endif