//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		structure_wrappers.cpp
//
//  Contents:	C to Eiffel structure wrappers.
//
//
//--------------------------------------------------------------------------


#include "ecom_structure_wrapper.h"

#include "eif_cecil.h"
#include "eif_hector.h"
#include "ecom_string_convert.h"
#include <windows.h>

CStructureWrapper::CStructureWrapper()
{
	etiRealTypeId		= eif_type_id( "REAL_REF"		);
	etiDoubleTypeId		= eif_type_id( "DOUBLE_REF"		);
	etiBooleanTypeId 	= eif_type_id( "BOOLEAN_REF"	);
	etiCharacterTypeId 	= eif_type_id( "CHARACTER_REF"	);
	etiIntegerTypeId 	= eif_type_id( "INTEGER_REF"	);

	eprRealCreate 		= eif_proc(
									"set_item",
									etiRealTypeId		);
	eprDoubleCreate 	= eif_proc(
									"set_item",
									etiDoubleTypeId		);
	eprBooleanCreate 	= eif_proc(
									"set_item",
									etiBooleanTypeId	);
	eprCharacterCreate 	= eif_proc(
									"set_item",
									etiCharacterTypeId	);
	eprIntegerCreate 	= eif_proc(
									"set_item",
									etiIntegerTypeId	);
}

CStructureWrapper::~CStructureWrapper()
{
}

EIF_OBJ CStructureWrapper::RealWrapper( float Value )
{
	EIF_OBJ eojRes = eif_create( etiRealTypeId );
	eprRealCreate( eif_access( eojRes ), ( EIF_REAL )Value );
	return eojRes;
}

EIF_OBJ CStructureWrapper::DoubleWrapper( double Value )
{
	EIF_OBJ eojRes = eif_create( etiDoubleTypeId );
	eprDoubleCreate( eif_access( eojRes ), ( EIF_DOUBLE )Value );
	return eojRes;
}

EIF_OBJ CStructureWrapper::BooleanWrapper( short Value )
{
	EIF_OBJ eojRes = eif_create( etiBooleanTypeId );
	eprBooleanCreate( eif_access( eojRes ), ( EIF_BOOLEAN )Value );
	return eojRes;
}

EIF_OBJ CStructureWrapper::CharacterWrapper( char Value )
{
	EIF_OBJ eojRes = eif_create( etiCharacterTypeId );
	eprCharacterCreate( eif_access( eojRes ), ( EIF_CHARACTER )Value );
	return eojRes;
}

EIF_OBJ CStructureWrapper::IntegerWrapper( long Value )
{
	EIF_OBJ eojRes = eif_create( etiIntegerTypeId );
	eprIntegerCreate( eif_access( eojRes ), ( EIF_INTEGER )Value );
	return eojRes;
}

float CStructureWrapper::Real( EIF_OBJ eojRealWrapper )
{
	return (float)( *( EIF_REAL* )( eif_access( eojRealWrapper ) ) );
}

double CStructureWrapper::Double( EIF_OBJ eojDoubleWrapper )
{
	return (double)( *( EIF_DOUBLE* )( eif_access( eojDoubleWrapper ) ) );
}

short CStructureWrapper::Boolean( EIF_OBJ eojBooleanWrapper )
{
	return (short)( *( EIF_BOOLEAN* )( eif_access( eojBooleanWrapper ) ) );
}

char CStructureWrapper::Character( EIF_OBJ eojCharacterWrapper )
{
	return (char)( *( EIF_CHARACTER* )( eif_access( eojCharacterWrapper ) ) );
}

long CStructureWrapper::Integer( EIF_OBJ eojIntegerWrapper )
{
	return (long)( *( EIF_INTEGER* )( eif_access( eojIntegerWrapper ) ) );
}
