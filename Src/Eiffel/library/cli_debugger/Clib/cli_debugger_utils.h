#ifndef __PE_DEBUGGER_UTILS_H_
#define __PE_DEBUGGER_UTILS_H_

#include "eif_eiffel.h"
#include <windows.h>
#include "cli_debugger_headers.h"



#ifdef __cplusplus
extern "C" {
#endif


#ifdef __cplusplus
}
#endif

/* ------------------------------------------------------------------------- *
 * ICorDebugHandleValue
 * ------------------------------------------------------------------------- */

#ifndef __ICorDebugHandleValue_INTERFACE_DEFINED__
#define __ICorDebugHandleValue_INTERFACE_DEFINED__

typedef enum CorDebugHandleType
    {	HANDLE_STRONG	= 1,
	HANDLE_WEAK_TRACK_RESURRECTION	= 2
    } 	CorDebugHandleType;


/* interface ICorDebugHandleValue */
/* [unique][uuid][object] */ 

EXTERN_C const IID IID_ICorDebugHandleValue;

	MIDL_INTERFACE("029596E8-276B-46a1-9821-732E96BBB00B")
	ICorDebugHandleValue : public IUnknown
	{
	public:
		virtual HRESULT STDMETHODCALLTYPE GetHandleType( 
			/* [out] */ CorDebugHandleType *pType) = 0;
		
		virtual HRESULT STDMETHODCALLTYPE Dispose( void) = 0;
		
	};

#endif

/* ------------------------------------------------------------------------- *
 * ICorDebugHeapValue2
 * ------------------------------------------------------------------------- */

#ifndef __ICorDebugHeapValue2_INTERFACE_DEFINED__
#define __ICorDebugHeapValue2_INTERFACE_DEFINED__

/* interface ICorDebugHeapValue2 */
/* [unique][uuid][object] */ 


EXTERN_C const IID IID_ICorDebugHeapValue2;

	MIDL_INTERFACE("E3AC4D6C-9CB7-43e6-96CC-B21540E5083C")
	ICorDebugHeapValue2 : public IUnknown
	{
	public:
		virtual HRESULT STDMETHODCALLTYPE CreateHandle( 
			/* [in] */ CorDebugHandleType type,
			/* [out] */ ICorDebugHandleValue **ppHandle) = 0;
		
	};
    

#endif



#ifdef __cplusplus

#endif /* __cplusplus */

#endif
