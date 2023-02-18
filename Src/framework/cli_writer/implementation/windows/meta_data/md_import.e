note
	description: "Represents abstraction of IMetaDataImport.. classes"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_IMPORT

inherit
	ANY

	COM_OBJECT
		export
			{NONE} all;
		redefine
			make_by_pointer, dispose
		end

create
	make_by_pointer

feature {NONE} -- Initialisation

	make_by_pointer (an_item: POINTER)
			-- Make Current IMetaDataImport encapsulation from the pointer `an_item'
		do
			Precursor {COM_OBJECT} (an_item)
		end

feature -- dispose

	clean_on_dispose
			-- Clean as this object was about to be disposed
		local
			l_nb_ref: INTEGER
		do
			if item /= Default_pointer then
				l_nb_ref := {CLI_COM}.release (item)
				item := default_pointer
			end
		end

	dispose
			-- Free `item'.
		do
			clean_on_dispose
		end

feature -- Enumerating collections

	close_enum (a_enum_hdl: POINTER)
			-- Frees the memory previously allocated for the enumeration.
			-- Note that the hEnum argument is that obtained from a previous
			-- EnumXXX call (for example, EnumTypeDefs)
		do
			cpp_close_enum (item, a_enum_hdl)
		end

	count_enum (a_enum_hdl: POINTER): INTEGER
			-- Returns the number of items in the enumeration.
			-- Note that the hEnum argument is that obtained from a previous
			-- EnumXXX call (for example, EnumTypeDefs).
		do
			last_call_success := cpp_count_enum (item, a_enum_hdl, $Result)
		end

	reset_enum (a_enum_hdl: POINTER; a_pos: INTEGER)
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

	enum_type_defs (a_enum_hdl: TYPED_POINTER [POINTER]; a_typedef: NATURAL_32; a_max_count: INTEGER): detachable ARRAY [NATURAL_32]
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
				Result := array_of_mdtoken_from (l_mp_tokens, l_md_size, l_count)
			end
		end

	enum_interface_impls (a_enum_hdl: TYPED_POINTER [POINTER]; a_typedef: NATURAL_32; a_size: INTEGER): detachable ARRAY [NATURAL_32]
			-- Enumerates all interfaces implemented by the specified TypeDef.
			-- Tokens will be returned in the order the interfaces were specified
			-- (through DefineTypeDef or SetTypeDefProps).
			-- [See GetInterfaceImplProps for more detail of how this method works]
		local
			l_md_size: INTEGER
			l_mp_tokens: MANAGED_POINTER
			l_count: INTEGER
		do
			l_md_size := sizeof_mdInterfaceImpl
			create l_mp_tokens.make (a_size * l_md_size)

			last_call_success := cpp_enum_interface_impls (item, a_enum_hdl, a_typedef, l_mp_tokens.item, a_size, $l_count)
			if
				(last_call_success = 0 or last_call_success = 1 )
				and then l_count > 0
			then
				Result := array_of_mdtoken_from (l_mp_tokens, l_md_size, l_count)
			end
		end

	enum_members (a_enum_hdl: TYPED_POINTER [POINTER]; a_typedef: NATURAL_32; a_max_count: INTEGER): detachable ARRAY [NATURAL_32]
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
				Result := array_of_mdtoken_from (l_mp_tokens, l_md_size, l_count)
			end
		end

	enum_methods (a_enum_hdl: TYPED_POINTER [POINTER]; a_typedef: NATURAL_32; a_max_count: INTEGER): detachable ARRAY [NATURAL_32]
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
				Result := array_of_mdtoken_from (l_mp_tokens, l_md_size, l_count)
			end
		end

	enum_fields (a_enum_hdl: TYPED_POINTER [POINTER]; a_typedef: NATURAL_32; a_max_count: INTEGER): detachable ARRAY [NATURAL_32]
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
				Result := array_of_mdtoken_from (l_mp_tokens, l_md_size, l_count)
			end
		end

	enum_properties (a_enum_hdl: TYPED_POINTER [POINTER]; a_typedef: NATURAL_32; a_max_count: INTEGER): detachable ARRAY [NATURAL_32]
			-- Enumerates all properties defined on a specified TypeDef.
			-- The tokens are returned in the same order as originally emitted into metadata.
			-- If you specify cl as nil, the method will enumerate all the global
			-- static data members defined in the current scope.
		local
			l_md_size: INTEGER
			l_mp_tokens: MANAGED_POINTER
			l_count: INTEGER
		do
			l_md_size := sizeof_mdProperty
			create l_mp_tokens.make (a_max_count * l_md_size)

			last_call_success := cpp_enum_properties (item, a_enum_hdl, a_typedef, l_mp_tokens.item , a_max_count, $l_count)

			if
				(last_call_success = 0 or last_call_success = 1 )
				and then l_count > 0
			then
				Result := array_of_mdtoken_from (l_mp_tokens, l_md_size, l_count)
			end
		end

	enum_params (a_enum_hdl: TYPED_POINTER [POINTER]; a_typedef: NATURAL_32; a_max_count: INTEGER): detachable ARRAY [NATURAL_32]
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
				Result := array_of_mdtoken_from (l_mp_tokens, l_md_size, l_count)
			end
		end

feature -- Finding specific item in MetaData

	find_type_def_by_name (a_name: STRING; a_encloser_tok: NATURAL_32): NATURAL_32
		require
			a_name_attached: a_name /= Void
		local
			l_name: UNI_STRING
		do
			create l_name.make (a_name)
			last_call_success := cpp_find_type_def_by_name (item, l_name.item, a_encloser_tok, $Result)
		end

	find_member (a_typedef: NATURAL_32; a_name: STRING): NATURAL_32
		require
			a_name_attached: a_name /= Void
		local
			l_name: UNI_STRING
		do
			create l_name.make (a_name)
			last_call_success := cpp_find_member (item, a_typedef, l_name.item,
					Default_pointer, 0, -- Signature purpose ...
					$Result)
		end

	find_method (a_typedef: NATURAL_32; a_name: STRING): NATURAL_32
		require
			a_name_attached: a_name /= Void
		local
			l_name: UNI_STRING
		do
			create l_name.make (a_name)
			last_call_success := cpp_find_method (item, a_typedef, l_name.item,
					Default_pointer, 0, -- Signature purpose ...
					$Result)
		end

	find_field (a_typedef: NATURAL_32; a_name: STRING): NATURAL_32
		require
			a_name_attached: a_name /= Void
		local
			l_name: UNI_STRING
		do
			create l_name.make (a_name)
			last_call_success := cpp_find_field (item, a_typedef, l_name.item,
					Default_pointer, 0, -- Signature purpose ...
					$Result)
		end

feature -- Obtaining Properties of a Specified Object

	get_typedef_props (a_tok: NATURAL_32): detachable STRING_32
			-- Get information stored in metadata for `a_tok'
		local
			mp_name: MANAGED_POINTER
			l_rsize: INTEGER
			l_flag: POINTER
			l_tkext: NATURAL_32
		do
			create mp_name.make (256 * 2)

			last_call_success := cpp_get_typedef_props (item, a_tok, mp_name.item, 255, $l_rsize, l_flag, $l_tkext)
			if mp_name.item /= Default_pointer then
				Result := (create {UNI_STRING}.make_by_pointer (mp_name.item)).string_32
			end
		end

	get_interface_impl_props (a_interface_impl: NATURAL_32): NATURAL_32
			-- Gets the information stored in metadata for a specified interface implementation
		local
			l_interf_tok: NATURAL_32
		do
			last_call_success := cpp_get_interface_impl_props (item, a_interface_impl, $Result, $l_interf_tok)
		end

	get_member_props (a_tok: NATURAL_32): detachable TUPLE [name: STRING_32; flag: INTEGER]
			-- Get member 's name property
		local
			mp_name: MANAGED_POINTER
			l_r_classtoken: NATURAL_32
			l_rsize: INTEGER
			l_flag: INTEGER
			l_sig: POINTER
			l_sigsize: INTEGER
			l_code_rva: INTEGER
			l_pdwimpl_flags, l_cplustype_flag: POINTER
			l_cst_ppvalue: POINTER
			l_pcchvalue: INTEGER
		do
			create mp_name.make (256 * 2)

			last_call_success := cpp_get_member_props (item, a_tok, $l_r_classtoken, mp_name.item, 255, $l_rsize,
				$l_flag,
				l_sig, $l_sigsize,
				$l_code_rva, l_pdwimpl_flags, l_cplustype_flag, l_cst_ppvalue, $l_pcchvalue)
			if mp_name.item /= Default_pointer then
				Result := [(create {UNI_STRING}.make_by_pointer (mp_name.item)).string_32, l_flag]
			end
		end

	get_method_props (a_tok: NATURAL_32): detachable STRING_32
			-- Get method 's name property
		local
			mp_name: MANAGED_POINTER
			l_r_classtoken: NATURAL_32
			l_rsize: INTEGER
			l_flag: POINTER
			l_sig: POINTER
			l_sigsize: INTEGER
			l_rva: POINTER
			l_pdw: POINTER
		do
			create mp_name.make (256 * 2)

			last_call_success := cpp_get_method_props (item, a_tok, $l_r_classtoken, mp_name.item, 255, $l_rsize,
				l_flag, l_sig, $l_sigsize, $l_rva, $l_pdw)
			if mp_name.item /= Default_pointer then
				Result := (create {UNI_STRING}.make_by_pointer (mp_name.item)).string_32
			end
		end

	get_field_props (a_tok: NATURAL_32): detachable STRING_32
			-- Get field 's name property
		local
			mp_name: MANAGED_POINTER
			l_r_classtoken: NATURAL_32
			l_rsize: INTEGER
			l_sig: POINTER
			l_sigsize: INTEGER
			l_pdwdef_type: POINTER
			l_ppvalue: POINTER
			l_pcbvalue: INTEGER
		do
			create mp_name.make (256 * 2)

			last_call_success := cpp_get_field_props (item, a_tok, $l_r_classtoken, mp_name.item, 255, $l_rsize,
				$last_get_field_dwattr, l_sig, $l_sigsize, l_pdwdef_type, l_ppvalue, $l_pcbvalue)

			if mp_name.item /= Default_pointer then
				Result := (create {UNI_STRING}.make_by_pointer (mp_name.item)).string_32
			end
		end

	get_property_props (a_tok: NATURAL_32): detachable TUPLE [name: STRING_32; getter: NATURAL_32; flag: INTEGER]
			-- Get field 's name property
		local
			mp_name: MANAGED_POINTER
			l_r_classtoken: NATURAL_32
			l_rsize: INTEGER
			l_sig: POINTER
			l_sigsize: INTEGER
			l_pdwdef_type: POINTER
			l_ppvalue: POINTER
			l_pcbvalue: INTEGER
			l_setter: NATURAL_32
			l_getter: NATURAL_32
			l_cmax: INTEGER
			l_pcothermethod: INTEGER
			l_mp_tokens: MANAGED_POINTER
			last_get_property_flags: INTEGER
		do
			l_cmax := 1
			create l_mp_tokens.make (l_cmax * sizeof_mdMethodDef)

			create mp_name.make (256 * 2)
			last_call_success := cpp_get_property_props (item, a_tok, $l_r_classtoken, mp_name.item, 255, $l_rsize,
				$last_get_property_flags, l_sig, $l_sigsize, l_pdwdef_type, l_ppvalue, $l_pcbvalue,
				$l_setter, $l_getter, l_mp_tokens.item, l_cmax, $l_pcothermethod
				)
			if mp_name.item /= Default_pointer then
				Result := [(create {UNI_STRING}.make_by_pointer (mp_name.item)).string_32, l_getter, last_get_property_flags]
			end
		end

	last_field_is_static: BOOLEAN
			-- Last `get_field_props' is_static property
		do
			Result := (last_get_field_dwattr & fdStatic) /= 0
		end

	last_field_is_literal: BOOLEAN
			-- Last `get_field_props' is_literal property
		do
			Result := (last_get_field_dwattr & fdLiteral) /= 0
		end

	last_get_field_dwattr: INTEGER
			-- Last `get_field_props' property

feature -- Status

	is_valid_token (a_tok: NATURAL_32): BOOLEAN
			-- Returns true if tk is a valid metadata token in the current scope.
			-- [The method checks the token type is one of those in the CorTokenType
			-- enumeration in CorHdr.h, and then that its RID is less than or equal
			-- to the current count of those token types]
		do
			Result := cpp_is_valid_token (item, a_tok) /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

	is_global (a_tok: NATURAL_32): BOOLEAN
			-- is type, field or method identified by `_a_tok' global ?
		local
			r: INTEGER
		do
			last_call_success := cpp_is_global (item, a_tok, $r)
			Result := r /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

feature -- Queries

	field_tokens (a_class_token: NATURAL_32): detachable ARRAYED_LIST [NATURAL_32]
		require
			a_class_token > 0
		do
			Result := enum_tokens (a_class_token, agent enum_fields)
		end

	property_tokens (a_class_token: NATURAL_32): detachable ARRAYED_LIST [NATURAL_32]
		require
			a_class_token > 0
		do
			Result := enum_tokens (a_class_token, agent enum_properties)
		end

	enum_tokens (   a_class_token: NATURAL_32;
					enum_agent: FUNCTION [TYPED_POINTER [POINTER], NATURAL_32, INTEGER, detachable ARRAY [NATURAL_32]];
				): detachable ARRAYED_LIST [NATURAL_32]
		require
			a_class_token > 0
			enum_agent_attached: enum_agent /= Void
		local
			l_tp: TYPED_POINTER [POINTER]
			l_tokens: ARRAYED_LIST [NATURAL_32]
			l_tokens_array: ARRAY [NATURAL_32]
			l_t_index: INTEGER
			l_t_upper: INTEGER
			l_tokens_count: INTEGER
			l_enum_hdl: POINTER
		do
				--| Get inherited "direct" entry
			create l_tokens.make (5)

--			l_enum_hdl := Default_pointer
			l_tp := $l_enum_hdl --| BUG: ... TUPLE with typed_pointer !!!
			l_tokens_array := enum_agent.item ([l_tp, a_class_token, 10])
			l_tokens_count := count_enum (l_enum_hdl)
			if l_tokens_array /= Void and l_tokens_count > 0 then
				if l_tokens_count > l_tokens.capacity - l_tokens.count then
					l_tokens.resize (l_tokens.count + l_tokens_count)
				end
				from
					l_t_upper := l_tokens_array.upper
					l_t_index := l_tokens_array.lower
				until
					l_t_index > l_t_upper
				loop
					l_tokens.force (l_tokens_array.item (l_t_index))
					l_t_index := l_t_index + 1
				end
				if l_tokens_count > l_tokens_array.count then
						-- We need to retrieve the rest of the data

					l_tokens_array := enum_agent.item ([l_tp, a_class_token, l_tokens_count - 10])
					check l_tokens_array /= Void then
						from
							l_t_upper := l_tokens_array.upper
							l_t_index := l_tokens_array.lower
						until
							l_t_index > l_t_upper
						loop
							l_tokens.force (l_tokens_array.item (l_t_index))
							l_t_index := l_t_index + 1
						end
					end
				end
			end
			close_enum (l_enum_hdl)
			Result := l_tokens
		end

feature {NONE} -- Implementation Enum...

	frozen cpp_close_enum (obj: POINTER; a_enum_hdl: POINTER)
		external
			"[
				C++ IMetaDataImport signature(HCORENUM) 
				use "cli_headers.h"
			]"
		alias
			"CloseEnum"
		end

	frozen cpp_count_enum (obj: POINTER; a_enum_hdl: POINTER; r_count: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ IMetaDataImport signature(HCORENUM, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"CountEnum"
		end

	frozen cpp_reset_enum (obj: POINTER; a_enum_hdl: POINTER; a_pos: INTEGER): INTEGER
		external
			"[
				C++ IMetaDataImport signature(HCORENUM, ULONG): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"ResetEnum"
		end

	frozen cpp_enum_type_defs (obj: POINTER; a_enum_hdl_p: TYPED_POINTER [POINTER]; r_typedefs: POINTER; a_max: INTEGER; r_typedefs_count: POINTER): INTEGER
		external
			"[
				C++ IMetaDataImport signature(HCORENUM*, mdTypeDef*, ULONG, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumTypeDefs"
		end

	frozen cpp_enum_interface_impls (obj: POINTER; a_enum_hdl_p: TYPED_POINTER [POINTER]; a_typedef: NATURAL_32; r_tokens: POINTER; a_tokens_size: INTEGER; r_tokens_count: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ IMetaDataImport signature(HCORENUM*, mdTypeDef, mdInterfaceImpl*, ULONG, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumInterfaceImpls"
		end

	frozen cpp_enum_members (obj: POINTER; a_enum_hdl_p: TYPED_POINTER [POINTER]; a_typedef: NATURAL_32; r_tokens: POINTER; a_max: INTEGER; r_tokens_count: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ IMetaDataImport signature(HCORENUM*, mdTypeDef, mdToken*, ULONG, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumMembers"
		end

	frozen cpp_enum_methods (obj: POINTER; a_enum_hdl_p: TYPED_POINTER [POINTER]; a_methoddef: NATURAL_32; r_methods: POINTER; a_max: INTEGER; r_tokens_count: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ IMetaDataImport signature(HCORENUM*, mdTypeDef, mdMethodDef*, ULONG, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumMethods"
		end

	frozen cpp_enum_fields (obj: POINTER; a_enum_hdl_p: TYPED_POINTER [POINTER]; a_typedef: NATURAL_32; r_fields: POINTER; a_max: INTEGER; r_tokens_count: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ IMetaDataImport signature(HCORENUM*, mdTypeDef, mdFieldDef*, ULONG, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumFields"
		end

	frozen cpp_enum_properties (obj: POINTER; a_enum_hdl_p: TYPED_POINTER [POINTER]; a_typedef: NATURAL_32; r_properties: POINTER; a_max: INTEGER; r_tokens_count: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ IMetaDataImport signature(HCORENUM*, mdTypeDef, mdProperty*, ULONG, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumProperties"
		end

	frozen cpp_enum_params (obj: POINTER; a_enum_hdl_p: TYPED_POINTER [POINTER]; a_methoddef: NATURAL_32; r_params: POINTER; a_max: INTEGER; r_tokens_count: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ IMetaDataImport signature(HCORENUM*, mdMethodDef, mdParamDef*, ULONG, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumParams"
		end

feature {NONE} -- Implementation Finding

	frozen cpp_find_type_def_by_name (obj: POINTER; a_name: POINTER; a_token: NATURAL_32;
			r_typedef: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ IMetaDataImport signature(LPCWSTR, mdToken, mdTypeDef*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"FindTypeDefByName"
		end

	frozen cpp_find_member (obj: POINTER; md_typedef: NATURAL_32; a_name: POINTER;
			a_sig: POINTER; a_sig_size: INTEGER;
			r_mdtoken: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ IMetaDataImport signature(mdTypeDef, LPCWSTR, PCCOR_SIGNATURE, ULONG , mdToken*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"FindMember"
		end

	frozen cpp_find_method (obj: POINTER; md_typedef: NATURAL_32; a_name: POINTER;
			a_sig: POINTER; a_sig_size: INTEGER;
			r_mdtoken: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ IMetaDataImport signature(mdTypeDef, LPCWSTR, PCCOR_SIGNATURE, ULONG , mdMethodDef*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"FindMethod"
		end

	frozen cpp_find_field (obj: POINTER; md_typedef: NATURAL_32; a_name: POINTER;
			a_sig: POINTER; a_sig_size: INTEGER;
			r_mdtoken: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ IMetaDataImport signature(mdTypeDef, LPCWSTR, PCCOR_SIGNATURE, ULONG , mdFieldDef*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"FindField"
		end

feature {NONE} -- Implementation Obtaining information

	frozen cpp_get_typedef_props (obj: POINTER; a_typedef: NATURAL_32; r_name: POINTER;
										a_wcharsize: INTEGER; r_wchsize: POINTER;
										r_flags: POINTER; r_ext: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ IMetaDataImport signature(mdTypeDef, LPWSTR, ULONG, ULONG*, DWORD*, mdToken*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetTypeDefProps"
		end

	frozen cpp_get_interface_impl_props (obj: POINTER; a_inter_impl: NATURAL_32; r_class_token: TYPED_POINTER [NATURAL_32];
										r_interface_token: TYPED_POINTER [NATURAL_32]
										): INTEGER
		external
			"[
				C++ IMetaDataImport signature(mdInterfaceImpl, mdTypeDef*, mdToken*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetInterfaceImplProps"
		end

	frozen cpp_get_member_props (obj: POINTER;
				a_member_token: NATURAL_32; r_class_token: TYPED_POINTER [NATURAL_32];
				r_name: POINTER; a_wcharsize: INTEGER; r_wchsize: TYPED_POINTER [INTEGER];
				r_pdwattr_flags: POINTER;
				ppvsigblob: POINTER; pcbsigblob: TYPED_POINTER [INTEGER];
				pulcode_rva: TYPED_POINTER [INTEGER]; pdwimpl_flags: POINTER;
				pdwcplustype_flag: POINTER; a_cst_ppvalue: POINTER;
				pcchvalue: TYPED_POINTER [INTEGER]
						): INTEGER
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
				a_method_token: NATURAL_32; r_class_token: TYPED_POINTER [NATURAL_32];
				r_name: POINTER; a_wcharsize: INTEGER; r_wchsize: TYPED_POINTER [INTEGER];
				r_flags: POINTER;
				ppvsigblob: POINTER; pcbsigblob: TYPED_POINTER [INTEGER];
				pulcode_rva: POINTER; pdwimpl_flags: POINTER;
						): INTEGER
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
				a_field_token: NATURAL_32; r_class_token: TYPED_POINTER [NATURAL_32];
				r_name: POINTER; a_wcharsize: INTEGER; r_wchsize: TYPED_POINTER [INTEGER];
				r_flags: POINTER; ppvsigblob: POINTER; pcbsigblob: TYPED_POINTER [INTEGER];
				a_elt_type_cst_value: POINTER; a_def_val_p: POINTER;
				a_def_val_byte_count: TYPED_POINTER [INTEGER]
						): INTEGER
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

	frozen cpp_get_property_props (obj: POINTER;
				a_property_token: NATURAL_32; r_class_token: TYPED_POINTER [NATURAL_32];
				r_name: POINTER; a_wcharsize: INTEGER; r_wchsize: TYPED_POINTER [INTEGER];
				r_flags: POINTER; ppvsigblob: POINTER; pcbsigblob: TYPED_POINTER [INTEGER];
				a_elt_type_cst_value: POINTER; a_def_val_p: POINTER;
				a_def_val_byte_count: TYPED_POINTER [INTEGER];
				a_setter: TYPED_POINTER [NATURAL_32]; a_getter: TYPED_POINTER [NATURAL_32];
				a_othermethod: POINTER;	a_cmax: INTEGER; a_pcothermethod: TYPED_POINTER [INTEGER]
						): INTEGER
		external
			"[
				C++ inline use "cli_headers.h"
			]"
		alias
			"[
   				((IMetaDataImport*)$obj)->GetPropertyProps((mdProperty)$a_property_token, (mdTypeDef*)$r_class_token,
						(LPWSTR)$r_name, (ULONG)$a_wcharsize, (ULONG*)$r_wchsize,
						(DWORD*)$r_flags, (PCCOR_SIGNATURE*)$ppvsigblob, (ULONG*)$pcbsigblob,
						(DWORD*)$a_elt_type_cst_value, (void const **)$a_def_val_p,
						(ULONG*)$a_def_val_byte_count,
						(mdMethodDef*)$a_setter,
						(mdMethodDef*)$a_getter,
						(mdMethodDef*)$a_othermethod,
        				(ULONG)$a_cmax, 
        				(ULONG*)$a_pcothermethod)
			]"
		end

feature {NONE} -- Implementation Status

	frozen cpp_is_valid_token (obj: POINTER; a_tok: NATURAL_32): INTEGER
		external
			"[
				C++ IMetaDataImport signature(mdToken): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"IsValidToken"
		end

	frozen cpp_is_global (obj: POINTER;
				a_md_token: NATURAL_32; r_b_global: TYPED_POINTER [INTEGER];
							): INTEGER
		external
			"[
				C++ IMetaDataImport signature(mdToken, int*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"IsGlobal"
		end

feature {NONE} -- Implementation

	sizeof_mdTypeDef: INTEGER
			-- Number of bytes in a value of type `mdTypeDef'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(mdTypeDef)"
		end

	sizeof_mdToken: INTEGER
			-- Number of bytes in a value of type `mdToken'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(mdToken)"
		end

	sizeof_mdMethodDef: INTEGER
			-- Number of bytes in a value of type `mdMethodDef'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(mdMethodDef)"
		end

	sizeof_mdFieldDef: INTEGER
			-- Number of bytes in a value of type `mdFieldDef'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(mdFieldDef)"
		end

	sizeof_mdProperty: INTEGER
			-- Number of bytes in a value of type `mdProperty'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(mdProperty)"
		end

	sizeof_mdParamDef: INTEGER
			-- Number of bytes in a value of type `mdParamDef'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(mdParamDef)"
		end

	sizeof_mdInterfaceImpl: INTEGER
			-- Number of bytes in a value of type `mdInterfaceImpl'
		external
			"C++ macro use %"cli_headers.h%" "
		alias
			"sizeof(mdInterfaceImpl)"
		end

	array_of_mdtoken_from (a_mp: MANAGED_POINTER; a_elt_size: INTEGER; a_count: INTEGER): ARRAY [NATURAL_32]
			-- ARRAY [INTEGER] filled with `a_count' elements from the MANAGED_POINTER `a_mp' with element of size `a_elt_size'.
		require
			value_source_not_void: a_mp /= Void
			element_size_valid: a_elt_size > 0
			not_empty: a_count > 0
		local
			i: INTEGER
		do
			from
				create Result.make_filled (0, 1, a_count)
				i := 1
			until
				i > a_count
			loop
				Result.put (a_mp.read_natural_32 ((i - 1) * a_elt_size), i)
				i := i + 1
			end
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation : helper

	frozen fdStatic: INTEGER
		external
			"[
				C++ macro use "cli_headers.h"
			]"
		alias
			"fdStatic"
		end

	frozen fdLiteral: INTEGER
		external
			"[
				C++ macro use "cli_headers.h"
			]"
		alias
			"fdLiteral"
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
