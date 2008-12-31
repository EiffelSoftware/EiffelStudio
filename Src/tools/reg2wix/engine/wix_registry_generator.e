note
	description: "[
		Utility class to generated WiX registry include documents from {REG_FILE}s.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	WIX_REGISTRY_GENERATOR

inherit
	ERROR_HANDLER_PROVIDER

create
	make

feature {NONE} -- Access

	short_hive_name_table: HASH_TABLE [STRING, STRING]
			-- Table of short registry hive names indexed by their long name
			-- Key: Long hive name
			-- Value: Short hive name
		once
			create Result.make (5)
			Result.compare_objects
		ensure
			result_attached: Result /= Void
			result_compares_objects: Result.object_comparison
		end

	default_namespace: XM_NAMESPACE
			-- Default namespace
		once
			create Result.make ("", "")
		ensure
			result_attached: Result /= Void
		end

	working_file: REG_FILE
			-- File currently be generated

feature -- Status report

	is_generating: BOOLEAN
			-- Indicates if a document is currently being generated

feature -- Generation

	generate (a_reg: REG_FILE; a_options: IREG2WIX_OPTIONS): XM_DOCUMENT
			-- Generates a WiX document from the registry file `a_reg'
		require
			a_reg_attached: a_reg /= Void
			a_options_attached: a_options /= Void
			not_is_generating: not is_generating
		do
			is_generating := True
			working_file := a_reg

			create Result.make_with_root_named (include_tag_name, create {XM_NAMESPACE}.make ("", wix_namespace))

			if not a_reg.is_empty then
				a_reg.keys.do_all (agent generate_registry_key (?, Result.root_element, a_options))
			end

			working_file := Void
			is_generating := False
		ensure
			not_is_generating: not is_generating
		end

	generate_collection (a_reg_files: LINEAR [REG_FILE]; a_options: IREG2WIX_OPTIONS): XM_DOCUMENT
			-- Generates a WiX document from the collection fo registry files `a_reg_files'
		require
			a_reg_files_attached: a_reg_files /= Void
			a_reg_files_items_attached: not a_reg_files.has (Void)
			a_options_attached: a_options /= Void
		local
			l_files: LINEAR [REG_FILE]
			l_reg: REG_FILE
		do
			is_generating := True
			working_file := Void

			create Result.make_with_root_named (include_tag_name, create {XM_NAMESPACE}.make ("", wix_namespace))

			l_files := a_reg_files.twin
			from l_files.start until l_files.after loop
				l_reg := l_files.item
				if not l_reg.is_empty then
					working_file := l_reg
					l_reg.keys.do_all (agent generate_registry_key (?, Result.root_element, a_options))
				end
				l_files.forth
			end

			working_file := Void
			is_generating := False
		ensure
			not_is_generating: not is_generating
		end

feature {NONE} -- Generation

	generate_registry_key (a_key: REG_FILE_KEY; a_parent: XM_ELEMENT; a_options: IREG2WIX_OPTIONS)
			-- Generates a WiX RegistryKey element from `a_key'
		require
			a_key_attached: a_key /= Void
			a_parent_attached: a_parent /= Void
			a_options_attached: a_options /= Void
			is_generating: is_generating
		local
			l_elm: XM_ELEMENT
			l_default: REG_FILE_VALUE
			l_key_parts: like split_key_path
		do
			create l_elm.make (a_parent, registry_key_tag_name,  create {XM_NAMESPACE}.make ("", wix_namespace))
			l_elm.add_attribute (id_attribute_name, default_namespace, generate_new_id (once "Reg."))

			l_key_parts := split_key_path (a_key.name)
			l_elm.add_attribute (root_attribte_name, default_namespace, l_key_parts.root)
			if l_key_parts.key /= Void then
				l_elm.add_attribute (key_attribute_name, default_namespace, l_key_parts.key)
			end
			l_elm.add_attribute (action_attribute_name, default_namespace, action_value_create)

			l_default := a_key.default_value
			if l_default.has_value then
				generate_registry_value (l_default, l_elm, a_options)
			end
			a_key.named_values.do_all (agent generate_registry_value (?, l_elm, a_options))

			a_parent.force_last (l_elm)
		end

	generate_registry_value (a_value: REG_FILE_VALUE; a_parent: XM_ELEMENT; a_options: IREG2WIX_OPTIONS)
			-- Generates a WiX RegistryValue element from `a_value'
		require
			a_value_attached: a_value /= Void
			a_value_has_value: a_value.has_value
			a_parent_attached: a_parent /= Void
			a_options_attached: a_options /= Void
			is_generating: is_generating
		local
			l_elm: XM_ELEMENT
			l_tcs: STRING
			l_value: STRING
			l_named_value: REG_FILE_NAMED_VALUE
			l_generate: BOOLEAN
			l_fn: STRING
		do
			l_named_value ?= a_value
			if l_named_value = Void or else l_named_value.is_supported then
					-- Registry value type is supported
				create l_elm.make (a_parent, registry_value_tag_name, create {XM_NAMESPACE}.make ("", wix_namespace))
				l_elm.add_attribute (id_attribute_name, default_namespace, generate_new_id (once "RegVal."))

					-- Add attribute
				if l_named_value /= Void then
					l_elm.add_attribute (name_attribute_name, default_namespace, l_named_value.name)
				end

				l_value := a_value.value

					-- Determine type
				l_tcs := type_value_string
				if l_named_value /= Void then
					inspect l_named_value.value_type_code
					when {REG_FILE_NAMED_VALUE}.tc_string then
						l_tcs := type_value_string
					when {REG_FILE_NAMED_VALUE}.tc_dword then
						l_tcs := type_value_integer
						if l_value /= Void and then not l_value.is_empty then
							l_value := hex_string_to_natural (l_value).out
						end
					else
							-- Ensure support
						check False end
					end
				end

				l_elm.add_attribute (value_attribute_name, default_namespace, l_value)

				l_elm.add_attribute (type_attribute_name, default_namespace, l_tcs)
				a_parent.force_last (l_elm)
			else
					-- Unsupported value
				if working_file.has_source_file_name then
					l_fn := working_file.source_file_name
				else
						-- If no file name is set, we have not other option...
					l_fn := once "FILE"
				end
				error_handler.add_warning (create {RWWU}.make (l_fn, l_named_value.value))
			end
		end

feature {NONE} -- Basic operations

	split_key_path (a_key: STRING): TUPLE [root: STRING; key: STRING]
			-- Splits a registry key path `a_key' into a hive root and a key path
		require
			a_key_attached: a_key /= Void
			not_a_key_is_empty: not a_key.is_empty
		local
			l_pos: INTEGER
			l_count: INTEGER
			l_root: STRING
			l_key: STRING
		do
			l_count := a_key.count
			l_pos := a_key.index_of ('\', 1)
			if l_pos > 1 then
				l_root := a_key.substring (1, l_pos - 1)
				if l_pos < l_count then
					l_key := a_key.substring (l_pos + 1, l_count)
				end
			else
				l_root := a_key
			end
			if l_key /= Void and then l_key.is_empty then
				l_key := Void
			end
			Result := [short_hive_name (l_root), l_key]
		ensure
			result_root_attached: Result.root /= Void
			not_result_root_is_empty: not Result.root.is_empty
			not_result_key_is_empty: Result.key /= Void implies not Result.key.is_empty
		end

	short_hive_name (a_name: STRING): STRING
			-- Generates a short registry hive name from `a_name'
		local
			l_names: like short_hive_name_table
			l_name: STRING
			l_parts: LIST [STRING]
			l_item: STRING
			l_count, i: INTEGER
		do
			l_names := short_hive_name_table
			l_name := a_name.as_upper
			Result := l_names.item (l_name)
			if Result = Void then
				create Result.make (4)
				l_parts := a_name.split ('_')
				from l_parts.start until l_parts.after loop
					l_item := l_parts.item
					if l_parts.isfirst then
						if l_item.is_case_insensitive_equal (once "HKEY") then
							Result.append (once "HK")
						end
					else
						if not l_item.is_empty then
							Result.append_character (l_item.item (1))
						end
					end
					l_parts.forth
				end
				Result.to_upper
				l_names.put (Result, l_name)
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			short_hive_name_table_has_result: short_hive_name_table.has (Result)
		end

	generate_new_id (a_prefix: STRING): STRING
			-- Generates a new registry id
		require
			not_a_prefix_is_empty: a_prefix /= Void implies not a_prefix.is_empty
		do
			create Result.make (50)
			if a_prefix /= Void then
				Result.append (a_prefix)
			else
				Result.append_character ('_')
			end
			Result.append (uuid_generator.generate_uuid.out)
			Result.prune_all ('-')
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	uuid_generator: UUID_GENERATOR
			-- Generator used to create new registry ids.
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Conversion routines

	hex_string_to_natural (a_string: STRING): NATURAL
			-- Converts string `a_string' to a {NATURAL} number
		require
			a_string_attached: a_string /= Void
			not_a_string_is_empty: not a_string.is_empty
		local
			l_count, i: INTEGER
		do
			l_count := a_string.count
			from i := 3 until i > l_count loop
				Result := 16 * Result
				inspect a_string.item (i)
				when '0' then
				when '1' then
					Result := Result + 1
				when '2' then
					Result := Result + 2
				when '3' then
					Result := Result + 3
				when '4' then
					Result := Result + 4
				when '5' then
					Result := Result + 5
				when '6' then
					Result := Result + 6
				when '7' then
					Result := Result + 7
				when '8' then
					Result := Result + 8
				when '9' then
					Result := Result + 9
				when 'a', 'A' then
					Result := Result + 10
				when 'b', 'B' then
					Result := Result + 11
				when 'c', 'C' then
					Result := Result + 12
				when 'd', 'D' then
					Result := Result + 13
				when 'e','E' then
					Result := Result + 14
				when 'f', 'F' then
					Result := Result + 15
				else
					-- Just ignore it
				end
				i := i + 1
			end
		end


feature {NONE} -- Constants

	wix_namespace: STRING = "http://schemas.microsoft.com/wix/2006/wi"

	include_tag_name: STRING = "Include"
	registry_key_tag_name: STRING = "RegistryKey"
	registry_value_tag_name: STRING = "RegistryValue"

	id_attribute_name: STRING = "Id"
	root_attribte_name: STRING = "Root"
	key_attribute_name: STRING = "Key"
	action_attribute_name: STRING = "Action"
	name_attribute_name: STRING = "Name"
	type_attribute_name: STRING = "Type"
	value_attribute_name: STRING = "Value"

	type_value_string: STRING = "string"
	type_value_integer: STRING = "integer"
	action_value_create_and_remove_on_uninstall: STRING = "createAndRemoveOnUninstall"
	action_value_create: STRING = "create"
	is_win64_value: STRING = "$(var.IsWin64)"

invariant
	working_file_attached: is_generating implies working_file /= Void

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
