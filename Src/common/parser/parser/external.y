%{
indexing
	description: "External parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_PARSER

inherit

	EXTERNAL_PARSER_SKELETON

creation

	make

%}

%start		External_declaration

%token		TE_COLON, TE_LPARAN, TE_RPARAN, TE_COMMA
%token		TE_ADDRESS, TE_STAR, TE_LT, TE_GT, TE_DQUOTE
%token		TE_ACCESS, TE_C_LANGUAGE, TE_CPP_LANGUAGE, TE_INLINE
%token		TE_DELETE, TE_DLL_LANGUAGE, TE_DLLWIN_LANGUAGE, TE_ENUM
%token		TE_GET_PROPERTY, TE_IL_LANGUAGE, TE_MACRO, TE_FIELD
%token		TE_JAVA_LANGUAGE, TE_DEFERRED, TE_OPERATOR
%token		TE_SET_FIELD, TE_SET_PROPERTY, TE_SIGNATURE, TE_STATIC, TE_CREATOR
%token		TE_STATIC_FIELD, TE_SET_STATIC_FIELD, TE_STRUCT, TE_TYPE, TE_USE, TE_ID

%type <EXTERNAL_EXTENSION_AS>	External_declaration C_specification CPP_specification
								DLL_specification IL_specification CPP_specific
%type <SIGNATURE_AS>			Signature_opt Signature
%type <EXTERNAL_TYPE_AS>		Return_opt Type_identifier Type_access_opt
%type <ID_AS>					Identifier File_identifier
%type <BOOLEAN>					Pointer_opt Address_opt
%type <USE_LIST_AS>				Use_opt, Use, Use_list
%type <INTEGER>					Il_language

%type <EIFFEL_LIST [EXTERNAL_TYPE_AS]>		Arguments_opt Arguments Arguments_list_opt Arguments_list

%%


-- Root rule


External_declaration:
		TE_C_LANGUAGE C_specification
			{
				root_node := $2
			}
	|	TE_CPP_LANGUAGE CPP_specification
			{
				root_node := $2
			}
	|	TE_DLL_LANGUAGE DLL_specification
			{
				root_node := $2
			}
	|	TE_DLLWIN_LANGUAGE DLL_specification
			{
				root_node := $2
			}
	|	IL_specification
			{
				root_node := $1
			}
	;

C_specification:
		Signature_opt Use_opt
			{
				$$ := new_c_extension_as ($1, $2)
			}
	|	TE_STRUCT Identifier TE_ACCESS Identifier Type_access_opt Use
			{
					-- False because this is a C construct
				$$ := new_struct_extension_as ($2, $4, $5, $6, False)
			}
	|	TE_MACRO Signature_opt Use
			{
					-- False because this is a C construct
				$$ := new_macro_extension_as ($2, $3, False)
			}
	|	TE_INLINE Use_opt
			{
				$$ := new_inline_as
			}
	;

CPP_specification:
		CPP_specific
			{
				$$ := $1
			}
	|	TE_STRUCT Identifier TE_ACCESS Identifier Type_access_opt Use
			{
					-- True because this is a C++ construct
				$$ := new_struct_extension_as ($2, $4, $5, $6, True)
			}
	|	TE_MACRO Signature_opt Use
			{
					-- True because this is a C++ construct
				$$ := new_macro_extension_as ($2, $3, True)
			}
	|	TE_INLINE Use_opt
			{
				$$ := new_inline_as
			}
	;

CPP_specific:
		Identifier Signature_opt Use
			{
				$$ := new_cpp_extension_as (standard, $1, $2, $3)
			}
	|	TE_CREATOR Identifier Signature_opt Use
			{
				$$ := new_cpp_extension_as (creator, $2, $3, $4)
			}
	|	TE_DELETE Identifier Signature_opt Use
			{
				$$ := new_cpp_extension_as (delete, $2, $3, $4)
			}
	|	TE_STATIC Identifier Signature_opt Use
			{
				$$ := new_cpp_extension_as (static, $2, $3, $4)
			}
	;

DLL_specification:	Signature_opt Use
	;

IL_specification:
		Il_language Signature_opt TE_USE Identifier
			{
				$$ := new_il_extension_as ($1, normal_type, $2, $4)
			}
	|	Il_language TE_DEFERRED Signature_opt TE_USE Identifier
			{
				$$ := new_il_extension_as ($1, deferred_type, $3, $5)
			}
	|	Il_language TE_CREATOR Signature_opt TE_USE Identifier
			{
				$$ := new_il_extension_as ($1, creator_type, $3, $5)
			}
	|	Il_language TE_FIELD Signature_opt TE_USE Identifier
			{
				$$ := new_il_extension_as ($1, field_type, $3, $5)
			}
	|	Il_language TE_STATIC_FIELD Signature_opt TE_USE Identifier
			{
				$$ := new_il_extension_as ($1, static_field_type, $3, $5)
			}
	|	Il_language TE_ENUM Signature_opt TE_USE Identifier
			{
				$$ := new_il_extension_as ($1, enum_field_type, $3, $5)
			}
	|	Il_language TE_SET_STATIC_FIELD Signature_opt TE_USE Identifier
			{
				$$ := new_il_extension_as ($1, set_static_field_type, $3, $5)
			}
	|	Il_language TE_SET_FIELD Signature_opt TE_USE Identifier
			{
				$$ := new_il_extension_as ($1, set_field_type, $3, $5)
			}
	|	Il_language TE_STATIC Signature_opt TE_USE Identifier
			{
				$$ := new_il_extension_as ($1, static_type, $3, $5)
			}
	|	Il_language TE_GET_PROPERTY Signature_opt TE_USE Identifier
			{
				$$ := new_il_extension_as ($1, get_property_type, $3, $5)
			}
	|	Il_language TE_SET_PROPERTY Signature_opt TE_USE Identifier
			{
				$$ := new_il_extension_as ($1, set_property_type, $3, $5)
			}
	|	Il_language TE_OPERATOR Signature_opt TE_USE Identifier
			{
				$$ := new_il_extension_as ($1, operator_type, $3, $5)
			}
	;

Il_language:
		TE_IL_LANGUAGE
			{
				$$ := msil_language
			}
	|	TE_JAVA_LANGUAGE
			{
				$$ := java_language
			}
	;

Signature_opt: -- Empty
	|	Signature
		{$$ := $1}
	;

Signature:
		TE_SIGNATURE Arguments_opt Return_opt
			{ $$ := new_signature_as ($2, $3)}
	;

Arguments_opt:	-- Empty
			-- {$$ := Void}
	|	Arguments
			{$$ := $1}
	;

Arguments:
		TE_LPARAN Arguments_list_opt TE_RPARAN
			{$$ := $2}
	;

Arguments_list_opt:	-- Empty
			-- {$$ := Void}
	|	Arguments_list
			{$$ := $1}
	;

Arguments_list:	Type_identifier
		{
			$$ := new_eiffel_list_external_type_as (Argument_list_initial_size)
			$$.extend ($1)
		} 
	|	Arguments_list TE_COMMA Type_identifier
		{
			$$ := $1
			$$.extend ($3)
		}
	;

Return_opt:	-- Empty
			-- {$$ := Void}
	|	TE_COLON Type_identifier
			{$$ := $2}
	;

Type_identifier:
		Identifier Pointer_opt Address_opt
			{
					-- False because no `struct' keyword.
				$$ := new_external_type_as ($1, False, $2, $3, False)
			}
	|	TE_STRUCT Identifier Pointer_opt Address_opt
			{
					-- True because `struct' keyword.
				$$ := new_external_type_as ($2, True, $3, $4, False)
			}
	;

Type_access_opt:	-- Empty
	|	TE_TYPE Type_identifier 
		{
			$$ := $2
		}
	;

Pointer_opt:	-- Empty
		{$$ := False}
	|	TE_STAR
		{$$ := True}
	;

Address_opt:	-- Empty
		{$$ := False}
	|	TE_ADDRESS
		{$$ := True}
	;

Use_opt:	-- Empty
			-- {$$ := Void}
	|	Use
			{$$ := $1}
	;

Use:
		TE_USE Use_list
			{$$ := $2}
	;

Use_list: File_Identifier
		{
			$$ := new_use_list_as (Argument_list_initial_size)
			$$.extend ($1)
		} 
	|	Use_list TE_COMMA File_identifier
		{
			$$ := $1
			$$.extend ($3)
		}
	;

File_identifier:
		TE_DQUOTE TE_ID TE_DQUOTE
		{
			$$ := new_double_quote_id_as (token_buffer)
		}
	|	TE_LT TE_ID TE_GT
		{
			$$ := new_system_id_as (token_buffer)
		}
	|	TE_ID
		{
			$$ := new_double_quote_id_as (token_buffer)
		}
	;

Identifier:	TE_ID
		{ $$ := new_id_as (token_buffer) }
	;

%%

end -- class EIFFEL_PARSER


--|----------------------------------------------------------------
--| Copyright (C) 1992-1999, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
