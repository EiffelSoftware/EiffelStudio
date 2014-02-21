/*-----------------------------------------------------------
String manipulation interface String Manipulator Library
-----------------------------------------------------------*/

#ifndef __ECOM_STRINGMANIPULATORLIB_ISTRING_H__
#define __ECOM_STRINGMANIPULATORLIB_ISTRING_H__

#include "decl_ecom_StringManipulatorLib_IString.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#ifndef __ecom_StringManipulatorLib_IString_INTERFACE_DEFINED__
#define __ecom_StringManipulatorLib_IString_INTERFACE_DEFINED__
namespace ecom_StringManipulatorLib
{
class IString : public IUnknown
{
public:
	IString () {};
	~IString () {};

	/*-----------------------------------------------------------
	Manipulated string
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP String(  /* [out, retval] */ LPSTR * a_string ) = 0;


	/*-----------------------------------------------------------
	Set manipulated string with `a_string'.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP SetString(  /* [in] */ LPSTR a_string ) = 0;


	/*-----------------------------------------------------------
	Copy the characters of `s' to positions `start_pos' .. `end_pos'.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP ReplaceSubstring(  /* [in] */ LPSTR s, /* [in] */ INT start_pos, /* [in] */ INT end_pos ) = 0;


	/*-----------------------------------------------------------
	Remove all occurrences of `c'.
	-----------------------------------------------------------*/
	 virtual STDMETHODIMP PruneAll(  /* [in] */ CHAR c ) = 0;



protected:


private:


};
}
#endif

#endif
