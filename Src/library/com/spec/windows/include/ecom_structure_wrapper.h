//--------------------------------------------------------------------------
//
//  EiffelCOM
//  Copyright (C) Interactive Software Engineering, 1998.
//
//  File:		ecom_structure_wrappers.h
//
//  Contents:	C to Eiffel structure wrappers.
//
//
//--------------------------------------------------------------------------

#ifndef __ECOM_STRUCTURE_WRAPPERS_H_INC__
#define __ECOM_STRUCTURE_WRAPPERS_H_INC__

#include "eif_cecil.h"
#include <objbase.h>

class CStructureWrapper
{
private:
	EIF_TYPE_ID etiRealTypeId		;
	EIF_TYPE_ID etiDoubleTypeId		;
	EIF_TYPE_ID etiBooleanTypeId	;
	EIF_TYPE_ID etiCharacterTypeId	;
	EIF_TYPE_ID etiIntegerTypeId	;
	EIF_TYPE_ID etiPointerTypeId	;

	EIF_PROC eprRealCreate		;
	EIF_PROC eprDoubleCreate	;
	EIF_PROC eprBooleanCreate	;
	EIF_PROC eprCharacterCreate	;
	EIF_PROC eprIntegerCreate	;
	EIF_PROC eprPointerCreate	;

	EIF_FN_FLOAT		efrReal			;
	EIF_FN_DOUBLE		efdDouble		;
	EIF_FN_BOOL			efbBoolean		;
	EIF_FN_CHAR			efcCharacter	;
	EIF_FN_INT			efiInteger		;
	EIF_FN_POINTER		efpPointer		;

public:
	CStructureWrapper();
	~CStructureWrapper();

	EIF_OBJ RealWrapper			( float		Value );
	EIF_OBJ DoubleWrapper		( double	Value );
	EIF_OBJ BooleanWrapper		( short		Value );
	EIF_OBJ CharacterWrapper	( char		Value );
	EIF_OBJ IntegerWrapper		( long		Value );
	EIF_OBJ PointerWrapper		( long		Value );

	float	Real		( EIF_OBJ eojRealWrapper		);
	double	Double		( EIF_OBJ eojDoubleWrapper		);
	short	Boolean		( EIF_OBJ eojBooleanWrapper		);
	char	Character	( EIF_OBJ eojCharacterWrapper	);
	long	Integer		( EIF_OBJ eojIntegerWrapper		);
};

#endif // !__ECOM_STRUCTURE_WRAPPERS_H_INC__
