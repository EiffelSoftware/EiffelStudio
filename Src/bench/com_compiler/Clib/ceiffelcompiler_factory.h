/*-----------------------------------------------------------
CEiffelCompiler factory
-----------------------------------------------------------*/

#ifndef __CEIFFELCOMPILER_FACTORY_H__
#define __CEIFFELCOMPILER_FACTORY_H__
#ifdef __cplusplus
extern "C" {


class CEiffelCompiler_factory;

}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#include "ecom_eiffel_compiler_CEiffelCompiler_s.h"

#ifdef __cplusplus
extern "C" {
#endif

extern void LockModule (void);

extern void UnlockModule (void);

#ifdef __cplusplus
extern "C" {
class CEiffelCompiler_factory : public IClassFactory
{
public:
	CEiffelCompiler_factory ();
	virtual ~CEiffelCompiler_factory () {};
	/*-----------------------------------------------------------
	Is initialized?
	-----------------------------------------------------------*/
	BOOL IsInitialized;



	/*-----------------------------------------------------------
	Increment reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) AddRef();


	/*-----------------------------------------------------------
	Decrement reference count
	-----------------------------------------------------------*/
	STDMETHODIMP_(ULONG) Release();


	/*-----------------------------------------------------------
	Query Interface
	-----------------------------------------------------------*/
	STDMETHODIMP QueryInterface( REFIID riid, void ** ppv );


	/*-----------------------------------------------------------
	Create Instance
	-----------------------------------------------------------*/
	STDMETHODIMP CreateInstance( IUnknown *pIunknown, REFIID riid, void **ppv );


	/*-----------------------------------------------------------
	Lock Server
	-----------------------------------------------------------*/
	STDMETHODIMP LockServer( BOOL tmp_value );


	/*-----------------------------------------------------------
	Initialize
	-----------------------------------------------------------*/
	void Initialize();



protected:


private:
	/*-----------------------------------------------------------
	Component class id
	-----------------------------------------------------------*/
	EIF_TYPE_ID type_id;




};
}
#endif

#ifdef __cplusplus
}
#endif
#include "ecom_grt_globals_Eif_compiler.h"


#endif