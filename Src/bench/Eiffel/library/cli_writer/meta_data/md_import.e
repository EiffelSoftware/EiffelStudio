indexing
	description: "Represents abstraction of IMetaDataImport.. classes"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_IMPORT

inherit
	COM_OBJECT
		export 
			{NONE} all;
		redefine
			make_by_pointer
		end
		
create
	make_by_pointer

feature {NONE} -- Initialisation

	make_by_pointer (an_item: POINTER) is
			-- Make Current IMetaDataImport encapsulation from the pointer `an_item'
		do
			Precursor {COM_OBJECT} (an_item)
		end

feature -- Enumerating collections

	close_enum (a_enum_hdl: INTEGER) is
			-- Frees the memory previously allocated for the enumeration.
			-- Note that the hEnum argument is that obtained from a previous
			-- EnumXXX call (for example, EnumTypeDefs) 
		do
			cpp_close_enum (item, a_enum_hdl)
		end

	count_enum (a_enum_hdl: INTEGER): INTEGER is
			-- Returns the number of items in the enumeration. 
			-- Note that the hEnum argument is that obtained from a previous
			-- EnumXXX call (for example, EnumTypeDefs). 
		do
			last_call_success := cpp_count_enum (item, a_enum_hdl, $Result)
		end	
		
	reset_enum (a_enum_hdl: INTEGER; a_pos: INTEGER) is
			-- Nb: 
			-- Reset the enumeration to the position specified by pulCount.
			-- So, if you reset the enumeration to the value 5, say,
			-- then a subsequent call to the corresponding EnumXXX method
			-- will return items, starting at the 5th (where counting starts
			-- at item number zero).  Note that the hEnum argument is that obtained
			-- from a previous EnumXXX call (for example, EnumTypeDefs)
		do
			last_call_success := cpp_reset_enum (item, a_enum_hdl, a_pos)
		end

	is_valid_token (a_tok: INTEGER): BOOLEAN is
			-- Returns true if tk is a valid metadata token in the current scope.
			-- [The method checks the token type is one of those in the CorTokenType 
			-- enumeration in CorHdr.h, and then that its RID is less than or equal
			-- to the current count of those token types]
		local
			l_result: INTEGER
		do
			l_result := cpp_is_valid_token (item, a_tok)
			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

	enum_type_defs (a_enum_hdl: TYPED_POINTER [INTEGER]; a_typedef: INTEGER; a_max_count: INTEGER): ARRAY [INTEGER] is
			-- Enumerates all TypedDefs within the current scope.  
			-- Note: the collection will contain Classes, Interfaces, etc,
			-- as well as any TypeDefs added via an extensibility mechanism.
		local
			l_md_size: INTEGER
			l_mp_tokens: MANAGED_POINTER
			l_count: INTEGER
		do
			l_md_size := sizeof_mdTypeDef
			create l_mp_tokens.make (a_max_count * l_md_size)

			last_call_success := cpp_enum_type_defs (item, a_enum_hdl, l_mp_tokens.item , a_max_count, $l_count)
			if 
				(last_call_success = 0 or last_call_success = 1 )
				and then l_count > 0 
			then
				Result := array_of_integer_from (l_mp_tokens, l_md_size, l_count)
			end
		end

	enum_members (a_enum_hdl: TYPED_POINTER [INTEGER]; a_typedef: INTEGER; a_max_count: INTEGER): ARRAY [INTEGER] is
			-- Enumerates all members (fields and methods, but not properties or events)
			-- defined by the class specified by cl.  
			-- This does not include any members inherited by that class;
			-- even in the case where this TypeDef actually implements an inherited method.
		local
			l_md_size: INTEGER
			l_mp_tokens: MANAGED_POINTER
			l_count: INTEGER
		do
			l_md_size := sizeof_mdToken
			create l_mp_tokens.make (a_max_count * l_md_size)

			last_call_success := cpp_enum_members (item, a_enum_hdl, a_typedef, l_mp_tokens.item , a_max_count, $l_count)
			if 
				(last_call_success = 0 or last_call_success = 1 )
				and then l_count > 0 
			then
				Result := array_of_integer_from (l_mp_tokens, l_md_size, l_count)
			end
		end

	enum_methods (a_enum_hdl: TYPED_POINTER [INTEGER]; a_typedef: INTEGER; a_max_count: INTEGER): ARRAY [INTEGER] is
			-- Enumerates all methods defined by the specified TypeDef.  
			-- Tokens are returned in the same order they were emitted.  
			-- If you supply a nil token for the cl argument the method will enumerate
			-- the global functions defined for the module as a whole.
		local
			l_md_size: INTEGER
			l_mp_tokens: MANAGED_POINTER
			l_count: INTEGER
		do
			l_md_size := sizeof_mdMethodDef
			create l_mp_tokens.make (a_max_count * l_md_size)

			last_call_success := cpp_enum_methods (item, a_enum_hdl, a_typedef, l_mp_tokens.item , a_max_count, $l_count)
			if 
				(last_call_success = 0 or last_call_success = 1 )
				and then l_count > 0 
			then
				Result := array_of_integer_from (l_mp_tokens, l_md_size, l_count)
			end
		end

	enum_fields (a_enum_hdl: TYPED_POINTER [INTEGER]; a_typedef: INTEGER; a_max_count: INTEGER): ARRAY [INTEGER] is
			-- Enumerates all fields defined on a specified TypeDef.  
			-- The tokens are returned in the same order as originally emitted into metadata.
			-- If you specify cl as nil, the method will enumerate all the global
			-- static data members defined in the current scope.
		local
			l_md_size: INTEGER
			l_mp_tokens: MANAGED_POINTER
			l_count: INTEGER
		do
			l_md_size := sizeof_mdFieldDef
			create l_mp_tokens.make (a_max_count * l_md_size)

			last_call_success := cpp_enum_fields (item, a_enum_hdl, a_typedef, l_mp_tokens.item , a_max_count, $l_count)

			if 
				(last_call_success = 0 or last_call_success = 1 )
				and then l_count > 0 
			then
				Result := array_of_integer_from (l_mp_tokens, l_md_size, l_count)
			end
		end

	enum_params (a_enum_hdl: TYPED_POINTER [INTEGER]; a_typedef: INTEGER; a_max_count: INTEGER): ARRAY [INTEGER] is
			-- Enumerates all attributed parameters for the method specified by md.  
			-- By attributed parameters, we mean those parameters of a method 
			-- which have been explicitly defined via a call to DefineParam
		local
			l_md_size: INTEGER
			l_mp_tokens: MANAGED_POINTER
			l_count: INTEGER
		do
			l_md_size := sizeof_mdParamDef
			create l_mp_tokens.make (a_max_count * l_md_size)

			last_call_success := cpp_enum_params (item, a_enum_hdl, a_typedef, l_mp_tokens.item , a_max_count, $l_count)
			if 
				(last_call_success = 0 or last_call_success = 1 )
				and then l_count > 0 
			then
				Result := array_of_integer_from (l_mp_tokens, l_md_size, l_count)
			end
		end

feature -- Finding specific item in MetaData

	find_type_def_by_name (a_name: STRING; a_encloser_tok: INTEGER): INTEGER is
		local
			l_name: UNI_STRING
		do
			create l_name.make (a_name)
			last_call_success := cpp_find_type_def_by_name (item, l_name.item, a_encloser_tok, $Result)			
		end

	find_member (a_typedef: INTEGER; a_name: STRING): INTEGER is
		local
			l_name: UNI_STRING
		do
			create l_name.make (a_name)
			last_call_success := cpp_find_member (item, a_typedef, l_name.item, 
					Default_pointer, 0, -- Signature purpose ...
					$Result)
		end

	find_method (a_typedef: INTEGER; a_name: STRING): INTEGER is
		local
			l_name: UNI_STRING
		do
			create l_name.make (a_name)
			last_call_success := cpp_find_method (item, a_typedef, l_name.item, 
					Default_pointer, 0, -- Signature purpose ...
					$Result)
		end

	find_field (a_typedef: INTEGER; a_name: STRING): INTEGER is
		local
			l_name: UNI_STRING
		do
			create l_name.make (a_name)
			last_call_success := cpp_find_field (item, a_typedef, l_name.item, 
					Default_pointer, 0, -- Signature purpose ...
					$Result)
		end
		
feature -- Obtaining Properties of a Specified Object

	get_typedef_props (a_tok: INTEGER): STRING is
			-- 
		local
			mp_name: MANAGED_POINTER
			l_rsize: INTEGER
			l_flag: POINTER
			l_tkext: INTEGER
		do
			create mp_name.make (256 * 2)

			last_call_success := cpp_get_typedef_props (item, a_tok, mp_name.item, 255, $l_rsize, l_flag, $l_tkext)
			Result := (create {UNI_STRING}.make_by_pointer (mp_name.item)).string
		end
		
	get_member_props (a_tok: INTEGER): STRING is
			-- 
		local
			mp_name: MANAGED_POINTER
			l_r_classtoken: INTEGER
			l_rsize: INTEGER
			l_flag: POINTER
			l_sig: POINTER
			l_sigsize: INTEGER
			l_code_rva: INTEGER
			l_pdwimpl_flags, l_cplustype_flag: POINTER
			l_cst_ppvalue: POINTER
			l_pcchvalue: INTEGER
			
		do
			create mp_name.make (256 * 2)

			last_call_success := cpp_get_member_props (item, a_tok, $l_r_classtoken, mp_name.item, 255, $l_rsize, l_flag, l_sig, $l_sigsize,
				$l_code_rva, l_pdwimpl_flags, l_cplustype_flag, l_cst_ppvalue, $l_pcchvalue)

			Result := (create {UNI_STRING}.make_by_pointer (mp_name.item)).string
		end		

	get_field_props (a_tok: INTEGER): STRING is
			-- 
		local
			mp_name: MANAGED_POINTER
			l_r_classtoken: INTEGER
			l_rsize: INTEGER
			l_flag: POINTER
			l_sig: POINTER
			l_sigsize: INTEGER
			l_pdwdef_type: POINTER
			l_ppvalue: POINTER
			l_pcbvalue: INTEGER
			
		do
			create mp_name.make (256 * 2)

			last_call_success := cpp_get_field_props (item, a_tok, $l_r_classtoken, mp_name.item, 255, $l_rsize, 
				l_flag, l_sig, $l_sigsize, l_pdwdef_type, l_ppvalue, $l_pcbvalue)

			Result := (create {UNI_STRING}.make_by_pointer (mp_name.item)).string
		end	

--feature -- obsolete
--
--	get_name_from_token (a_tok: INTEGER): STRING is
--		local
--			mp_name: MANAGED_POINTER
--		do
--			create mp_name.make (256 * 2)
--			last_call_success := cpp_get_name_from_token (item, a_tok, mp_name.item)
--			Result := (create {UNI_STRING}.make_by_pointer (mp_name.item)).string
--			
--		ensure
--			success: last_call_success = 0
--		end
		
feature {NONE} -- Implementation Enum...

	frozen cpp_close_enum (obj: POINTER; a_enum_hdl: INTEGER) is
		external
			"[
				C++ IMetaDataImport signature(HCORENUM) 
				use "cli_headers.h"
			]"
		alias
			"CloseEnum"
		end	

	frozen cpp_count_enum (obj: POINTER; a_enum_hdl: INTEGER; r_count: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ IMetaDataImport signature(HCORENUM, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"CountEnum"
		end		

	frozen cpp_reset_enum (obj: POINTER; a_enum_hdl: INTEGER; a_pos: INTEGER): INTEGER is
		external
			"[
				C++ IMetaDataImport signature(HCORENUM, ULONG): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"ResetEnum"
		end		

	frozen cpp_is_valid_token (obj: POINTER; a_tok: INTEGER): INTEGER is
		external
			"[
				C++ IMetaDataImport signature(mdToken): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"IsValidToken"
		end	

	frozen cpp_enum_type_defs (obj: POINTER; a_enum_hdl_p: TYPED_POINTER [INTEGER]; r_typedefs: POINTER; a_max: INTEGER; r_typedefs_count: POINTER): INTEGER is
		external
			"[
				C++ IMetaDataImport signature(HCORENUM*, mdTypeDef*, ULONG, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumTypeDefs"
		end	

	frozen cpp_enum_members (obj: POINTER; a_enum_hdl_p: TYPED_POINTER [INTEGER]; a_typedef: INTEGER; r_tokens: POINTER; a_max: INTEGER; r_tokens_count: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ IMetaDataImport signature(HCORENUM*, mdTypeDef, mdToken*, ULONG, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumMembers"
		end	

	frozen cpp_enum_methods (obj: POINTER; a_enum_hdl_p: TYPED_POINTER [INTEGER]; a_typedef: INTEGER; r_methods: POINTER; a_max: INTEGER; r_tokens_count: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ IMetaDataImport signature(HCORENUM*, mdTypeDef, mdMethodDef*, ULONG, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumMethods"
		end	

	frozen cpp_enum_fields (obj: POINTER; a_enum_hdl_p: TYPED_POINTER [INTEGER]; a_typedef: INTEGER; r_fields: POINTER; a_max: INTEGER; r_tokens_count: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ IMetaDataImport signature(HCORENUM*, mdTypeDef, mdFieldDef*, ULONG, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumFields"
		end	

	frozen cpp_enum_params (obj: POINTER; a_enum_hdl_p: TYPED_POINTER [INTEGER]; a_typedef: INTEGER; r_params: POINTER; a_max: INTEGER; r_tokens_count: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ IMetaDataImport signature(HCORENUM*, mdMethodDef, mdParamDef*, ULONG, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumParams"
		end	

feature {NONE} -- Implementation Finding

	frozen cpp_find_type_def_by_name (obj: POINTER; a_name: POINTER; a_token: INTEGER; 
			r_typedef: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ IMetaDataImport signature(LPCWSTR, mdToken, mdTypeDef*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"FindTypeDefByName"
		end	

	frozen cpp_find_member (obj: POINTER; md_typedef: INTEGER; a_name: POINTER;
			a_sig: POINTER; a_sig_size: INTEGER;
			r_mdtoken: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ IMetaDataImport signature(mdTypeDef, LPCWSTR, PCCOR_SIGNATURE, ULONG , mdToken*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"FindMember"
		end	

	frozen cpp_find_method (obj: POINTER; md_typedef: INTEGER; a_name: POINTER;
			a_sig: POINTER; a_sig_size: INTEGER;
			r_mdtoken: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ IMetaDataImport signature(mdTypeDef, LPCWSTR, PCCOR_SIGNATURE, ULONG , mdMethodDef*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"FindMethod"
		end	

	frozen cpp_find_field (obj: POINTER; md_typedef: INTEGER; a_name: POINTER;
			a_sig: POINTER; a_sig_size: INTEGER;
			r_mdtoken: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ IMetaDataImport signature(mdTypeDef, LPCWSTR, PCCOR_SIGNATURE, ULONG , mdFieldDef*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"FindField"
		end	

feature {NONE} -- Implementation Obtaining information

	frozen cpp_get_typedef_props (obj: POINTER; a_typedef: INTEGER; r_name: POINTER; 
										a_wcharsize: INTEGER; r_wchsize: POINTER; 
										r_flags: POINTER; r_ext: POINTER): INTEGER is
		external
			"[
				C++ IMetaDataImport signature(mdTypeDef, LPWSTR, ULONG, ULONG*, DWORD*, mdToken*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetTypeDefProps"
		end	

	frozen cpp_get_member_props (obj: POINTER; 
				a_member_token: INTEGER; r_class_token: TYPED_POINTER [INTEGER]; 
				r_name: POINTER; a_wcharsize: INTEGER; r_wchsize: TYPED_POINTER [INTEGER]; 
				r_pdwattr_flags: POINTER; 
				ppvsigblob: POINTER; pcbsigblob: TYPED_POINTER [INTEGER];
				pulcode_rva: TYPED_POINTER [INTEGER]; pdwimpl_flags: POINTER;
				pdwcplustype_flag: POINTER; a_cst_ppvalue: POINTER; 
				pcchvalue: TYPED_POINTER [INTEGER]
						): INTEGER is
		external
			"[
				C++ inline use "cli_headers.h"
			]"
		alias
			"[
   				((IMetaDataImport*)$obj)->GetMemberProps((mdToken)$a_member_token, (mdTypeDef*)$r_class_token,
						(LPWSTR)$r_name, (ULONG)$a_wcharsize, (ULONG*)$r_wchsize,
						(DWORD*)$r_pdwattr_flags, 
						(PCCOR_SIGNATURE*)$ppvsigblob, (ULONG*)$pcbsigblob,
						(ULONG*) $pulcode_rva, (DWORD*) $pdwimpl_flags,
						(DWORD*) $pdwcplustype_flag, (void const **) $a_cst_ppvalue,
						(ULONG*) $pcchvalue)
			]"
		end	

	frozen cpp_get_method_props (obj: POINTER; 
				a_method_token: INTEGER; r_class_token: TYPED_POINTER [INTEGER]; 
				r_name: POINTER; a_wcharsize: INTEGER; r_wchsize: TYPED_POINTER [INTEGER]; 
				r_flags: POINTER; 
				ppvsigblob: POINTER; pcbsigblob: TYPED_POINTER [INTEGER];
				pulcode_rva: POINTER; pdwimpl_flags: POINTER; 
						): INTEGER is
		external
			"[
				C++ inline use "cli_headers.h"
			]"
		alias
			"[
   				((IMetaDataImport*)$obj)->GetMethodProps((mdMethodDef)$a_method_token, (mdTypeDef*)$r_class_token,
						(LPWSTR)$r_name, (ULONG)$a_wcharsize, (ULONG*)$r_wchsize,
						(DWORD*)$r_flags, (PCCOR_SIGNATURE*)$ppvsigblob, (ULONG*)$pcbsigblob,
						(ULONG*)$pulcode_rva, (DWORD*)$pdwimpl_flags)
			]"
		end			

	frozen cpp_get_field_props (obj: POINTER; 
				a_field_token: INTEGER; r_class_token: TYPED_POINTER [INTEGER]; 
				r_name: POINTER; a_wcharsize: INTEGER; r_wchsize: TYPED_POINTER [INTEGER]; 
				r_flags: POINTER; ppvsigblob: POINTER; pcbsigblob: TYPED_POINTER [INTEGER];
				a_elt_type_cst_value: POINTER; a_def_val_p: POINTER; 
				a_def_val_byte_count: TYPED_POINTER [INTEGER]
						): INTEGER is
		external
			"[
				C++ inline use "cli_headers.h"
			]"
		alias
			"[
   				((IMetaDataImport*)$obj)->GetFieldProps((mdFieldDef)$a_field_token, (mdTypeDef*)$r_class_token,
						(LPWSTR)$r_name, (ULONG)$a_wcharsize, (ULONG*)$r_wchsize,
						(DWORD*)$r_flags, (PCCOR_SIGNATURE*)$ppvsigblob, (ULONG*)$pcbsigblob,
						(DWORD*)$a_elt_type_cst_value, (void const **)$a_def_val_p,
						(ULONG*)$a_def_val_byte_count)				
			]"
		end	

--	frozen cpp_get_name_from_token (obj: POINTER; a_tok: INTEGER; a_name: POINTER): INTEGER is
--		external
--			"[
--				C++ IMetaDataImport signature(mdToken, MDUTF8CSTR*): EIF_INTEGER 
--				use "cli_headers.h"
--			]"
--		alias
--			"GetNameFromToken"
--		end	
	
feature {NONE} -- Implementation

	sizeof_mdTypeDef: INTEGER is
			-- Number of bytes in a value of type `mdTypeDef'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(mdTypeDef)"
		end

	sizeof_mdToken: INTEGER is
			-- Number of bytes in a value of type `mdToken'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(mdToken)"
		end

	sizeof_mdMethodDef: INTEGER is
			-- Number of bytes in a value of type `mdMethodDef'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(mdMethodDef)"
		end

	sizeof_mdFieldDef: INTEGER is
			-- Number of bytes in a value of type `mdFieldDef'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(mdFieldDef)"
		end

	sizeof_mdParamDef: INTEGER is
			-- Number of bytes in a value of type `mdParamDef'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(mdParamDef)"
		end

	array_of_integer_from (a_mp: MANAGED_POINTER; a_elt_size: INTEGER; a_count: INTEGER): ARRAY [INTEGER] is
			-- ARRAY [INTEGER] filled with `a_count' elements from the MANAGED_POINTER `a_mp' with element of size `a_elt_size'.
		require
			value_source_not_void: a_mp /= Void
			element_size_valid: a_elt_size > 0
			not_empty: a_count > 0
		local
			l_mdtypedef_value: INTEGER
			i: INTEGER
		do
			from
				create Result.make (1, a_count)
				i := 1
			until
				i > a_count
			loop
				l_mdtypedef_value := a_mp.read_integer_32 ((i - 1) * a_elt_size)
				Result.put (l_mdtypedef_value, i)
				i := i + 1
			end		
		ensure
			result_not_void: Result /= Void
		end

end

