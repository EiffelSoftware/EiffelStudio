note
	description: "[
				    // we only support one Module per Assembly here; the Assembly manifest is implicitly generated
			        // assembly versioning, hasing, keys and cultures are not used
			        // no exported type defs, no Type forwarders, no interfaces
			        // all strings are utf-8
			
			        // qualifier: composite name,
			        // optionally with [assembly] prefix, namespace, etc.
			        // optionally with argument types (t1,t2,..), where tn are qualifiers or native type names
			        // optionally with '&' postfix (applicability is not checked by PeLib!)
			        // optionally with '[]' (multidim not yet supported) postfix; remember that arrays are objects, not values
			        // both valid: Namespace.Class and Namespace::Class
			        // both valid: OuterClass/InnerClass and OuterClass.InnerClass
			        // identifier start with alpha, #, $, @ or _ and continue with alphanumeric, ?, $, @, _ or `
			        
			        
			        Intially based on
			        	-- https://github.com/jvelilla/PeLib/blob/5311aa31c56a4fd48024c1f1b02444fd83aee672/SimpleApi.h
						-- https://github.com/jvelilla/PeLib/blob/5311aa31c56a4fd48024c1f1b02444fd83aee672/SimpleApi.cpp
						
					Review
						https://github.com/rochus-keller/Oberon/blob/master/ObxIlEmitter.h
						https://github.com/rochus-keller/Oberon/blob/master/ObxIlEmitter.cpp
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CIL_EMITTER_API

inherit

	REFACTORING_HELPER

feature -- Assembler

	write_assembler (a_path: STRING_32)
		do
			to_implement ("Add implementation")
		end

feature -- Module

	begin_module (a_module_name: STRING_32; a_module_kind: CIL_MODULE_KIND)
		do
			to_implement ("Add implementation")
		end

	end_module
		do
			to_implement ("Add implementation")
		end

	add_module_reference (a_module_name: STRING_32)
		do
			to_implement ("Add implementation")
		end

feature -- Namespace

	begin_namespace (a_name: STRING_32)
			--  namespaces can be nested, only apply to classes, structs and enums
		do
			to_implement ("Add implementation")
		end

	end_namespace
		do
			to_implement ("Add implementation")
		end

feature -- Method

	begin_method (a_method_name: STRING_32; is_public: BOOLEAN; a_mkind: CIL_METHOD_KIND; is_runtime: BOOLEAN)
			--  can be on top level or in a class/struct; cannot be in a method
		do
			to_implement ("Add implementation")
		end

	open_method (a_method_name: STRING_32)
			-- ignores args, returns first match with name
		do
			to_implement ("Add implementation")
		end

	end_method
		do
			to_implement ("Add implementation")
		end

feature -- Class

	begin_class (a_class_name: STRING_32; is_public: BOOLEAN; a_super_class_qualifier: STRING_32)
			-- Classes can be nested.
		do
			to_implement ("Add implementation")
		end

	open_class (a_class_name: STRING_32)
		do
			to_implement ("Add implementation")
		end

	set_super_class (a_super_class_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	end_class
		do
			to_implement ("Add implementation")
		end

feature -- Structs

	begin_struct (a_name: STRING_32; is_public: BOOLEAN)
			-- Structs can be nested.
		do
			to_implement ("Add implementation")
		end

	end_struct
		do
			to_implement ("Add implementation")
		end

feature -- Enums

	add_enum (a_enum_name: STRING_32; is_public: BOOLEAN; a_enum_items: LIST [TUPLE [name: STRING_32; index: INTEGER]]; a_with_runtime: BOOLEAN)
		do
			to_implement ("Add implementation")
		end

feature -- Fields

	add_field (a_field_name: STRING_32; a_type_qualifier: STRING_32; is_public: BOOLEAN; is_static: BOOLEAN)
			-- on top level or in class.
		do
			to_implement ("Add implementation")
		end

feature -- Locals

	add_local (a_type_qualifier: STRING_32; a_name: STRING_32)
		do
			to_implement ("Add implementation")
		end

feature -- Arguments

	add_argument (a_type_qualifier: STRING_32; a_name: STRING)
		do
			to_implement ("Add implemenation")
		end

	set_var_args
		do
			to_implement ("Add Implementation")
		end

feature -- Return Type.

	set_return_type (a_type_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

feature -- Label

	new_label: INTEGER
		do
			to_implement ("Add implementation")
		end

feature -- Base Instructions

	ADD (a_with_overflow: BOOLEAN; a_with_unsigned_overflow: BOOLEAN)
		do
			to_implement ("Add implementation")
		end
	AND_
		do
			to_implement ("Add implementation")
		end

	BEQ (a_label: INTEGER)
		do
			to_implement ("Add implementation")
		end

	BGE (a_label: INTEGER; a_with_unsigned: BOOLEAN)
		do
			to_implement ("Add implementation")
		end

	BGT (a_label: INTEGER; a_with_unsigned: BOOLEAN)
		do
			to_implement ("Add implementation")
		end

	BLE (a_label: INTEGER; a_with_unsigned: BOOLEAN)
		do
			to_implement ("Add implementation")
		end

	BLT (a_label: INTEGER; a_withUnsigned: BOOLEAN)
		do
			to_implement ("Add implementation")
		end

	BNE (a_label: INTEGER)
		do
			to_implement ("Add implementation")
		end

	BR (a_label: INTEGER)
		do
			to_implement ("Add implementation")
		end

	BREAK (a_label: INTEGER)
		do
			to_implement ("Add implementation")
		end

	BRFALSE (a_label: INTEGER)
		do
			to_implement ("Add implementation")
		end

	BRNULL (a_label: INTEGER)
		do
			to_implement ("Add implementation")
		end

	BRZERO (a_label: INTEGER)
		do
			to_implement ("Add implementation")
		end

	BRTRUE (a_label: INTEGER)
		do
			to_implement ("Add implementation")
		end

	BRINST (a_label: INTEGER)
		do
			to_implement ("Add implementation")
		end

	CALL (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

--	CALLI
--	CEQ, CGT, CLT
--	Ckfinite

	CONV (a_type: CIL_TO_TYPE; a_with_overflow: BOOLEAN; a_with_unsigned_overflow: BOOLEAN)
		do
			to_implement ("Add implementation")
		end

--	Cpblk

	DIV (a_with_unsigned: BOOLEAN)
		do
			to_implement ("Add implementation")
		end

	DUP
		do
			to_implement ("Add implementation")
		end

-- endfilter, endfinally
-- initblk
-- JMP

	LDARG (a_arg_num: INTEGER)
		do
			to_implement ("Add implementation")
		end

	LDARGA (a_arg_num: INTEGER)
		do
			to_implement ("Add implementation")
		end

	LDC_INT (a_val: INTEGER)
		do
			to_implement ("Add implementation")
		end

	LDC_INT_64 (a_val: INTEGER_64)
		do
			to_implement ("Add implementation")
		end

	LDC_REAL_32 (a_val: REAL_32)
		do
			to_implement ("Add implementation")
		end

	LDC_REAL_64 (a_val: REAL_64)
		do
			to_implement ("Add implementation")
		end

--  void LDFTN( const QByteArray& qualifier );

	LDIND (a_ind_type: CIL_IND_TYPE)
		do
			to_implement ("Add implementation")
		end

	LDLOC (a_loc_num: INTEGER)
		do
			to_implement ("Add implementation")
		end

	LDLOCA (a_loc_num: INTEGER)
		do
			to_implement ("Add implementation")
		end

	LDNULL
		do
			to_implement ("Add implementation")
		end

-- leave
-- localloc

	MUL (a_with_overflow: BOOLEAN; a_with_unsigned_overflow: BOOLEAN)
		do
			to_implement ("Add implementation")
		end

	NEG
		do
			to_implement ("Add implementation")
		end

	NOP
		do
			to_implement ("Add implementation")
		end

	NOT_
		do
			to_implement ("Add implementation")
		end

	OR_
		do
			to_implement ("Add implementation")
		end

	POP
		do
			to_implement ("Add implementation")
		end

	REM (a_with_unsigned: BOOLEAN)
		do
			to_implement ("Add implementation")
		end

	RET
		do
			to_implement ("Add implementation")
		end

	SHL
		do
			to_implement ("Add implementation")
		end

	SHR (a_with_Unsigned: BOOLEAN)
		do
			to_implement ("Add implementation")
		end

	STARG (a_arg_num: INTEGER)
		do
			to_implement ("Add implementation")
		end

	STIND (a_ind_type: CIL_IND_TYPE)
			-- only subset I, R, Int, Ref supported!
		do
			to_implement ("Add implementation")
		end

	STLOC (a_loc_num: INTEGER)
		do
			to_implement ("Add implementation")
		end

	SUB (a_with_Overflow: BOOLEAN; a_with_Unsigned_Overflow: BOOLEAN)
		do
			to_implement ("Add implementation")
		end

-- switch

	XOR_
		do
			to_implement ("Add implementation")
		end

--        // Object model instructions:
	BOX (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	CALLVIRT (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	CASTCLASS (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

--        // copobj
	INITOBJ (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	ISINST (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	LDELEM_STR (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	LDELEM_IND_TYPE (a_ind_type: CIL_IND_TYPE)
		do
			to_implement ("Add implementation")
		end

	LDELEMA (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	LDFLD (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	LDFLDA (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	LDLEN
		do
			to_implement ("Add implementation")
		end

	LDOBJ (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	LDSFLD (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	LDSFLDA (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	LDSTR (a_string: STRING_32)
		do
			to_implement ("Add implementation")
		end

	LDTOKEN (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	LDVIRTFTN (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

--        // mkrefany
	NEWARR (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	NEWOBJ (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

--        // refanytype, refanyval
--        // rethrow
--        // sizeof
	STELEM_STR (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

	STELEM_IND_TYPE (a_ind_type: CIL_IND_TYPE)
			-- only subset I, R, Int, Ref supported
		do
			to_implement ("Add implementation")
		end

	STFLD (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

--        // stobj
	STSFLD (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

--        // throw
	UNBOX (a_qualifier: STRING_32)
		do
			to_implement ("Add implementation")
		end

end
