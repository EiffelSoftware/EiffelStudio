/*-----------------------------------------------------------
 Help file: 
-----------------------------------------------------------*/

#ifndef __ECOM_ISE_REFLECTION_CODEGENERATOR_EIFFELCODEGENERATORDICTIONARY_H__
#define __ECOM_ISE_REFLECTION_CODEGENERATOR_EIFFELCODEGENERATORDICTIONARY_H__
#ifdef __cplusplus
extern "C" {


namespace ecom_ISE_Reflection_CodeGenerator
{
class EiffelCodeGeneratorDictionary;
}

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_grt_globals_ISE_c.h"

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
extern "C" {
namespace ecom_ISE_Reflection_CodeGenerator
{
class EiffelCodeGeneratorDictionary
{
public:
	EiffelCodeGeneratorDictionary ();
	EiffelCodeGeneratorDictionary (IUnknown * a_pointer);
	virtual ~EiffelCodeGeneratorDictionary ();

	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
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
#include "ecom_grt_globals_ISE_c.h"


#endif