note
	description: "Encapsulation of IMetaDataAssemblyEmit"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_ASSEMBLY_EMIT

inherit
	COM_OBJECT

create
	make_by_pointer

feature -- Access

	define_assembly_ref (assembly_name: CLI_STRING; assembly_info: MD_ASSEMBLY_INFO;
			public_key_token: MD_PUBLIC_KEY_TOKEN): INTEGER
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_info_not_void: assembly_info /= Void
		local
			null: POINTER
		do
			if public_key_token /= Void then
				last_call_success := c_define_assembly_ref (item, public_key_token.item.item,
					public_key_token.item.count,
					assembly_name.item, assembly_info.item, null, 0, 0, $Result)
			else
				last_call_success := c_define_assembly_ref (item, null, 0,
					assembly_name.item, assembly_info.item, null, 0, 0, $Result)
			end
		ensure
			success: last_call_success = 0
			valid_result: Result > 0
		end

feature -- Definition

	define_assembly (assembly_name: CLI_STRING; assembly_flags: INTEGER;
			assembly_info: MD_ASSEMBLY_INFO; public_key: detachable MD_PUBLIC_KEY): INTEGER

			-- Define a new assembly `assembly_name' with characteristics
			-- `assembly_flags' and `assembly_info', and if not void with
			-- a public key `public_key'.
			-- Possible values of `assembly_flags' are defined in MD_ASSEMBLY_FLAGS.
		require
			assembly_name_not_void: assembly_name /= Void
			assembly_info_not_void: assembly_info /= Void
			valid_flags: public_key /= Void implies assembly_flags &
				{MD_ASSEMBLY_FLAGS}.public_key = {MD_ASSEMBLY_FLAGS}.public_key
		do
			if public_key = Void then
				last_call_success := c_define_assembly (item, default_pointer, 0,
					{MD_HASH_IDS}.sha1, assembly_name.item, assembly_info.item,
					assembly_flags, $Result)
			else
				last_call_success := c_define_assembly (item, public_key.item.item,
					public_key.item.count, {MD_HASH_IDS}.sha1, assembly_name.item,
					assembly_info.item, assembly_flags, $Result)
			end
		ensure
			success: last_call_success = 0
			valid_result: Result > 0
		end

	define_exported_type (type_name: CLI_STRING; implementation_token: INTEGER;
			type_def_token: INTEGER; type_flags: INTEGER): INTEGER

				-- Ensure that `type_name' type defined in `implementation_token' with
				-- `type_def_token' and `type_flags' is exported from Current assembly.
		require
			type_name_not_void: type_name /= Void
		do
			last_call_success := c_define_exported_type (item, type_name.item, implementation_token,
				type_def_token, type_flags, $Result)
		ensure
			success: last_call_success = 0
			valid_result: Result > 0
		end

	define_file (file_name: CLI_STRING; hash_value: MANAGED_POINTER;
			file_flags: INTEGER): INTEGER
			-- Define a new entry in file table.
		require
			file_name_not_void: file_name /= Void
			file_name_not_empty: not file_name.is_empty
			hash_value_not_void: hash_value /= Void
			hash_value_not_empty: hash_value.count > 0
		do
			last_call_success := c_define_file (item, file_name.item, hash_value.item,
				hash_value.count, file_flags, $Result)
		ensure
			success: last_call_success = 0
			valid_result: Result > 0
		end

	define_manifest_resource (resource_name: CLI_STRING; implementation_token: INTEGER
			offset, resource_flags: INTEGER): INTEGER

			-- Define a new entry in manifest resource table.
		require
		do
			last_call_success := c_define_manifest_resource (item, resource_name.item,
				implementation_token, offset, resource_flags, $Result)
		ensure
			success: last_call_success = 0
			valid_result: Result > 0
		end

feature {NONE} -- Implementation

	c_define_assembly (an_item: POINTER; public_key: POINTER; key_length: INTEGER;
			hash_alg: INTEGER; assembly_name: POINTER; assembly_metadata: POINTER;
			assembly_flags: INTEGER; assembly_token: POINTER): INTEGER

			-- Call `IMetaDataAssemblyEmit->DefineAssembly'.
		external
			"[
				C++ IMetaDataAssemblyEmit signature
					(void *, ULONG, ULONG, LPCWSTR, ASSEMBLYMETADATA *,
					DWORD, mdAssembly *): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"DefineAssembly"
		end

	c_define_exported_type (an_item: POINTER; type_name: POINTER; implementation_token: INTEGER;
			type_def_token: INTEGER; type_flags: INTEGER; exported_type_token: POINTER): INTEGER

			-- Call `IMetaDataAssemblyEmit->DefineExportedType'.
		external
			"[
				C++ IMetaDataAssemblyEmit signature
					(LPCWSTR, mdToken, mdTypeDef, DWORD, mdExportedType *): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"DefineExportedType"
		end

	c_define_file (an_item: POINTER; file_name: POINTER; hash_value: POINTER; hash_length: INTEGER;
			file_flags: INTEGER; file_token: POINTER): INTEGER

			-- Call `IMetaDataAssemblyEmit->DefineFile'.
		external
			"[
				C++ IMetaDataAssemblyEmit signature
					(LPCWSTR, void *, ULONG, DWORD, mdFile *): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"DefineFile"
		end

	c_define_manifest_resource (an_item: POINTER; resource_name: POINTER;
			implementation_token, offset, resource_flags: INTEGER; resource_token: POINTER): INTEGER

			-- Call `IMetaDataAssemblyEmit->DefineManifestResource'.
		external
			"[
				C++ IMetaDataAssemblyEmit signature
					(LPCWSTR, mdToken, DWORD, DWORD, mdManifestResource *): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"DefineManifestResource"
		end

	c_define_assembly_ref (an_item: POINTER; public_key: POINTER; key_length: INTEGER;
			assembly_name: POINTER; assembly_metadata: POINTER; hash_value: POINTER;
			hash_length: INTEGER; assembly_flags: INTEGER; assembly_token: POINTER): INTEGER

			-- Call `IMetaDataAssemblyEmit->DefineAssemblyRef'.
		external
			"[
				C++ IMetaDataAssemblyEmit signature
					(void *, ULONG, LPCWSTR, ASSEMBLYMETADATA *,
					void *, ULONG, DWORD, mdAssembly *): EIF_INTEGER
				use <cor.h>
			]"
		alias
			"DefineAssemblyRef"
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

end -- class MD_ASSEMBLY_EMIT
