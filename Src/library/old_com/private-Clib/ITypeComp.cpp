/////////////////////////////////////////////////////////////////////////////
//
//     ITYPECOMP.CPP    Copyright (c) 1998 by ISE
//
//     Version:       0.00
//
//     Eiffel OLE 2 Library
//
//     ITypeComp support
//
//     Functions:
//       E_ITypeComp::Bind
//       E_ITypeComp::BindType
//       E_ITypeComp_Bind
//       E_ITypeComp_BindType
//       eole2_typecomp_bind
//       eole2_typecomp_bindtype
//     Globals:
//       None.
//     Notes:
//       None.
//

#include "eifole.h"
#include "eif_hector.h"

/////////////////////////////////////////////////////////////////////////////
//
// E_ITypeComp::E_ITypeComp
//
// Purpose:
//    Object's constructor.
//
// Parameters:
//    None.
//
// Return Value:
//    None.
//

E_ITypeComp::E_ITypeComp () {
}

/////////////////////////////////////////////////////////////////////////////
//
// E_ITypeComp::Bind
//
// Purpose:
//    Maps a name to a member of a type, or binds global variables and 
//		functions contained in a type library. 
//
// Parameters:
//    szName 
//		Name to be bound. 
//
//	  lHashVal 
//		Hash value for the name computed by LHashValOfNameSys. 
//
//	  wFlags 
//		Flags word containing one or more of the Invoke flags defined in the
//		INVOKEKIND enumeration. Specifies whether the name was referenced as 
//		a method or a property. When binding to a variable, specify the flag 
//		INVOKE_PROPERTYGET. Specify zero to bind to any type of member. 
//
//	  ppTInfo 
//		If a FUNCDESC or VARDESC was returned, then ppTInfo points to a pointer
//		to the type description that contains the item to which it is bound. 
//
//	  pDescKind 
//		Pointer to a DESCKIND enumerator that indicates whether the name bound to 
//		is a VARDESC, FUNCDESC, or TYPECOMP. If there was no match, points to 
//		DESCKIND_NONE. 
//
//	  pBindPtr 
//		On return, contains a pointer to the bound-to VARDESC, FUNCDESC, or 
//		ITypeComp interface.
//
// Return Value:
//    Ole error code.
//

STDMETHODIMP E_ITypeComp::Bind (OLECHAR FAR* szName, 
								unsigned long lHashVal,  
								unsigned short wFlags,  
								ITypeInfo FAR*FAR* ppTInfo,  
								DESCKIND FAR* pDescKind, 
								BINDPTR FAR* pBindPtr)
 
 {
   return E_ITypeComp_Bind (
                           GetEiffelCurrentPointer (), TRUE // Incoming Call!
						   , szName, lHashVal, wFlags,
						   ppTInfo, pDescKind, pBindPtr
                           );
}

/////////////////////////////////////////////////////////////////////////////
//
// E_ITypeComp::BindType
//
// Purpose:
//    Binds to the type descriptions contained within a type library.
//
// Parameters:
//    szName 
//		Name to be bound. 
//
//	  lHashVal 
//		Hash value for the name computed by LHashValOfName. 
//
//	  ppTInfo 
//		On return, contains a pointer to a pointer to an ITypeInfo of the type
//		to which the name was bound. 
//
//	  ppTComp 
//		Passes a valid pointer, such as the address of an ITypeComp* variable.
//
// Return Value:
//    Ole error code.
//

STDMETHODIMP E_ITypeComp::BindType (OLECHAR FAR* szName, 
								    unsigned long lHashVal,
								    ITypeInfo FAR* FAR* ppTInfo, 
								    ITypeComp FAR* FAR* ppTComp)
 
 {
   return E_ITypeComp_BindType (
                           GetEiffelCurrentPointer (), TRUE // Incoming Call!
						   , szName, lHashVal, ppTInfo, ppTComp
                           );
}

/////////////////////////////////////////////////////////////////////////////
//
// E_ITypeComp_Bind
//
// Purpose:
//    Maps a name to a member of a type, or binds global variables and 
//		functions contained in a type library. 
//
//

extern "C" HRESULT E_ITypeComp_Bind
                         ( void * ptr,
                           BOOL incomingCall,
                           OLECHAR FAR* szName, 
						   unsigned long lHashVal,  
						   unsigned short wFlags,  
					       ITypeInfo FAR*FAR* ppTInfo,  
						   DESCKIND FAR* pDescKind, 
					       BINDPTR FAR* pBindPtr) {

    return ((E_ITypeComp*) ptr)->Bind (szName,lHashVal, wFlags,
								    		ppTInfo, pDescKind, pBindPtr);
}

/////////////////////////////////////////////////////////////////////////////
//
// E_ITypeComp_BindType
//
// Purpose:
//    Binds to the type descriptions contained within a type library.
//
//

extern "C" HRESULT E_ITypeComp_BindType
                         ( void * ptr,
                           BOOL incomingCall,
                           OLECHAR FAR* szName, 
						   unsigned long lHashVal,
						   ITypeInfo FAR* FAR* ppTInfo, 
						   ITypeComp FAR* FAR* ppTComp) {

    return ((E_ITypeComp*) ptr)->BindType (szName,lHashVal,
								    		ppTInfo, ppTComp);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_typecomp_bind
//
// Purpose:
//    Maps a name to a member of a type, or binds global variables and 
//		functions contained in a type library. 
//

extern "C" EIF_OBJ eole2_typecomp_bind (EIF_POINTER pITypeCompThis,
											EIF_POINTER Name,
											EIF_INTEGER wFlags)
	{
	ITypeInfo FAR* FAR* ppTInfo;
	DESCKIND FAR* pDescKind;
	BINDPTR FAR* pBindPtr;
	ULONG lHashVal;
	OLECHAR FAR* szName;
	EIF_OBJ Result;
	EIF_PROC eif_set_tinfo;
	EIF_PROC eif_set_dkind;
	EIF_PROC eif_set_bptr;
	EIF_TYPE_ID res_id;
	
	szName = Eif2OleString (Name);
	lHashVal = LHashValOfName (0, szName);
	ppTInfo = (ITypeInfo FAR* FAR*)malloc (sizeof (ITypeInfo FAR*));
	pDescKind = (DESCKIND FAR  *)malloc (sizeof (DESCKIND));
	pBindPtr = (BINDPTR FAR *)malloc (sizeof (BINDPTR));
	
	g_hrStatusCode = E_ITypeComp_Bind (
                             pITypeCompThis, FALSE // Call from Eiffel!
							 , (OLECHAR FAR *)szName,
							 lHashVal, (USHORT)wFlags,
							 ppTInfo, pDescKind, pBindPtr
                             );
	res_id = eif_type_id ("EOLE_BIND_RESULT");	
	Result = eif_create (res_id);
	eif_set_tinfo = eif_proc ("set_type_info", res_id);
	eif_set_dkind = eif_proc ("set_desc_kind", res_id);
	eif_set_bptr = eif_proc ("set_bind_ptr", res_id);
	eif_set_tinfo (eif_access (Result), (EIF_POINTER)*ppTInfo);
	eif_set_dkind (eif_access (Result), (EIF_INTEGER)*pDescKind);
	if (*pDescKind == DESCKIND_FUNCDESC)
		eif_set_bptr (eif_access (Result), (EIF_POINTER)((*pBindPtr).lpfuncdesc));
	if (*pDescKind == DESCKIND_VARDESC)
		eif_set_bptr (eif_access (Result), (EIF_POINTER)((*pBindPtr).lpvardesc));
	if (*pDescKind == DESCKIND_TYPECOMP)
		eif_set_bptr (eif_access (Result), (EIF_POINTER)((*pBindPtr).lptcomp));
	return eif_access (Result);
}

/////////////////////////////////////////////////////////////////////////////
//
// eole2_typecomp_bind_type
//
// Purpose:
//    Binds to the type descriptions contained within a type library.
//
//

extern "C" EIF_POINTER eole2_typecomp_bind_type (EIF_POINTER pITypeCompThis,
											EIF_POINTER Name)
	{
	OLECHAR FAR * szName;
	ULONG lHashVal;
	ITypeInfo FAR* FAR* ppTInfo;

	szName = Eif2OleString (Name);
	lHashVal = LHashValOfName (0, szName);
	ppTInfo = (ITypeInfo FAR* FAR*)malloc (sizeof (ITypeInfo FAR*));

	g_hrStatusCode = E_ITypeComp_BindType (
                             pITypeCompThis, FALSE // Call from Eiffel!
							 , (OLECHAR FAR *)szName,
							 lHashVal, ppTInfo, (ITypeComp **) &pITypeCompThis
                             );
	return (EIF_POINTER) *ppTInfo;
}
 
/////// END OF FILE /////////////////////////////////////////////////////////

