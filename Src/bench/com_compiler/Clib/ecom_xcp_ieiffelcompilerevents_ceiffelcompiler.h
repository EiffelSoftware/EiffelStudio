/*-----------------------------------------------------------
To deal with identity relationship of IConnectionPoin,
IEiffelCompilerEvents-specific inner class.
-----------------------------------------------------------*/

#ifndef __ECOM_XCP_IEIFFELCOMPILEREVENTS_CEIFFELCOMPILER_H__
#define __ECOM_XCP_IEIFFELCOMPILEREVENTS_CEIFFELCOMPILER_H__
#ifdef __cplusplus
extern "C" {


class ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler;

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_IEiffelCompilerEvents_s.h"

#ifdef __cplusplus
extern "C" {
#endif

namespace ecom_eiffel_compiler
{
class CEiffelCompiler;
}



#ifdef __cplusplus
extern "C" {
class ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler : public IConnectionPoint
{
public:
	ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler (ecom_eiffel_compiler::CEiffelCompiler * an_outer, EIF_OBJECT an_object, EIF_TYPE_ID a_type_id);
	virtual ~ecom_XCP_IEiffelCompilerEvents_CEiffelCompiler () {};
	/*-----------------------------------------------------------
	Pointer to coclass.
	-----------------------------------------------------------*/
	ecom_eiffel_compiler::CEiffelCompiler * outer;



	/*-----------------------------------------------------------
	QueryInterface
	-----------------------------------------------------------*/
	STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );


	/*-----------------------------------------------------------
	AddRef
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) AddRef( void );


	/*-----------------------------------------------------------
	Release
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) Release( void );


	/*-----------------------------------------------------------
	GetConnectionInterface
	-----------------------------------------------------------*/
	STDMETHODIMP GetConnectionInterface( IID * piid );


	/*-----------------------------------------------------------
	GetConnectionPointContainer
	-----------------------------------------------------------*/
	STDMETHODIMP GetConnectionPointContainer( IConnectionPointContainer ** ppcpc );


	/*-----------------------------------------------------------
	Advise
	-----------------------------------------------------------*/
	STDMETHODIMP Advise( IUnknown * pUnk, DWORD * pdwCookie );


	/*-----------------------------------------------------------
	Unadvise
	-----------------------------------------------------------*/
	STDMETHODIMP Unadvise( DWORD dwCookie );


	/*-----------------------------------------------------------
	EnumConnections
	-----------------------------------------------------------*/
	STDMETHODIMP EnumConnections( IEnumConnections ** ppEnum );



protected:


private:
	/*-----------------------------------------------------------
	Eiffel object.
	-----------------------------------------------------------*/
	EIF_OBJECT eiffel_object;


	/*-----------------------------------------------------------
	Eiffel object's type ID.
	-----------------------------------------------------------*/
	EIF_TYPE_ID type_id;




};
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_eiffel_compiler_CEiffelCompiler_s.h"

#include "ecom_grt_globals_Eif_compiler.h"


#endif