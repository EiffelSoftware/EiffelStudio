/*-----------------------------------------------------------
String Manipulator String Manipulator Library
-----------------------------------------------------------*/

#ifndef __ECOM_STRINGMANIPULATORLIB_STRINGMANIPULATOR_H__
#define __ECOM_STRINGMANIPULATORLIB_STRINGMANIPULATOR_H__

#include "decl_ecom_StringManipulatorLib_StringManipulator.h"

#include "eif_com.h"

#include "eif_eiffel.h"

#include "eif_setup.h"

#include "eif_macros.h"

#include "ecom_StringManipulatorLib_IString.h"

namespace ecom_StringManipulatorLib
{
class StringManipulator
{
public:
	StringManipulator ();
	StringManipulator (IUnknown * a_pointer);
	virtual ~StringManipulator ();

	/*-----------------------------------------------------------
	Manipulated string
	-----------------------------------------------------------*/
	EIF_REFERENCE ccom_string(  );


	/*-----------------------------------------------------------
	Set manipulated string with `a_string'.
	-----------------------------------------------------------*/
	void ccom_set_string(  /* [in] */ EIF_OBJECT a_string );


	/*-----------------------------------------------------------
	Copy the characters of `s' to positions `start_pos' .. `end_pos'.
	-----------------------------------------------------------*/
	void ccom_replace_substring(  /* [in] */ EIF_OBJECT s,  /* [in] */ EIF_INTEGER start_pos,  /* [in] */ EIF_INTEGER end_pos );


	/*-----------------------------------------------------------
	Remove all occurrences of `c'.
	-----------------------------------------------------------*/
	void ccom_prune_all(  /* [in] */ EIF_CHARACTER c );


	/*-----------------------------------------------------------
	IUnknown interface
	-----------------------------------------------------------*/
	EIF_POINTER ccom_item();



protected:


private:
	/*-----------------------------------------------------------
	Interface pointer
	-----------------------------------------------------------*/
	ecom_StringManipulatorLib::IString * p_IString;


	/*-----------------------------------------------------------
	Default IUnknown interface pointer
	-----------------------------------------------------------*/
	IUnknown * p_unknown;




};
}

#endif
