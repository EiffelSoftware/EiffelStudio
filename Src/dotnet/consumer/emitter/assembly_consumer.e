note
	description: "[
			Generate XML from given .NET assembly.
			The XML can be used to consume the types
			defined in the assembly from Eiffel.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	ASSEMBLY_CONSUMER

inherit
	SYSTEM_OBJECT

	ASSEMBLY_CONSUMPTION_ERRORS

	REFLECTION

	CALLBACK_INTERFACE

	COMMON_PATH
		export
			{NONE} all
		end

	SHARED_ASSEMBLY_MAPPING
		export
			{NONE} all
		end

	NAME_FORMATTER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_writer: CACHE_WRITER)
			-- create new assembly consumer
		require
			non_void_writer: a_writer /= Void
		do
			create type_consumers.make (0)
			create assembly_ids.make
			create destination_path.make_empty
			cache_writer := a_writer
		ensure
			cache_writer_set: cache_writer = a_writer
		end

feature -- Basic Operations

	consume (ass: ASSEMBLY; a_loader: ASSEMBLY_LOADER; a_info_only: BOOLEAN)
			-- Consumes assembly `ass' into EAC.
		require
			non_void_assembly: ass /= Void
			non_void_destination_path: destination_path /= Void
			valid_destination_path: (create {DIRECTORY}.make_with_path (destination_path)).exists
			a_loader_attached: a_loader /= Void
		local
			count: INTEGER
		do
			{SYSTEM_DLL_TRACE}.write_line ({SYSTEM_STRING}.format ("Beginning consumption for assembly '{0}'.", ass.to_string))
			{SYSTEM_DLL_TRACE}.write_line ({SYSTEM_STRING}.format ("Consuming into '{0}'.", destination_path.name.to_cil))

			reset_assembly_mapping
			if
				attached ass.get_referenced_assemblies as referenced_assemblies and then
				attached ass.location as l_ass_location and then
				attached ass.full_name as l_ass_full_name and then
				attached cache_writer.consumed_assembly_from_path (create {STRING_32}.make_from_cil (l_ass_location)) as ca
			then
				count := referenced_assemblies.count
				assembly_ids.wipe_out
				last_index := 1
				assembly_ids.extend (ca)
				assembly_mapping.put (last_index, l_ass_full_name)
				assembly_mapping.compare_objects
				build_referenced_assemblies (ass, a_loader)
				prepare_consumed_types (ass, a_info_only)
				serialize_consumed_types (a_info_only)
			end
		end

feature -- Access

	destination_path: PATH
			-- Path where XML files are generated

	cache_writer: CACHE_WRITER
			-- Cache writer used to write consumed assembly information to cache

feature -- Element Settings

	set_destination_path (path: PATH)
			-- Set `destination_path' with `path'.
		require
			non_void_path: path /= Void
			valid_path: (create {DIRECTORY}.make_with_path (path)).exists
		do
			destination_path := path
		ensure
			destination_path_set: destination_path = path
		end

feature {NONE} -- Implementation

	fetch_module_types (a_mod: MODULE): NATIVE_ARRAY [detachable SYSTEM_TYPE]
			-- Retrieves a module's types, respecting that a security exception
			-- may prevent retrieval.
		local
			retried: BOOLEAN
		do
			if not retried and then attached a_mod.get_types as l_types then
				Result := l_types
			else
				Result := create {NATIVE_ARRAY [detachable SYSTEM_TYPE]}.make (0)
			end
		ensure
			result_attached: Result /= Void
		rescue
			retried := True
			retry
		end

	last_index: INTEGER
			-- Last index where has been added a referened assembly.

	build_referenced_assemblies (ass: ASSEMBLY; a_loader: ASSEMBLY_LOADER)
			-- build referenced assemblies.
		require
			non_void_assembly: ass /= Void
			positive_last_index: last_index > 0
			assembly_mapping_object_comparison: assembly_mapping.object_comparison
			a_loader_attached: a_loader /= Void
		local
			referenced_assemblies: detachable NATIVE_ARRAY [detachable ASSEMBLY_NAME]
			i, count: INTEGER
			ca: detachable CONSUMED_ASSEMBLY
		do
			referenced_assemblies := ass.get_referenced_assemblies
			if referenced_assemblies /= Void then
				count := referenced_assemblies.count
				from
					i := 1
				until
					i > count
				loop
					if
						attached referenced_assemblies.item (i - 1) as l_assembly_name and then
						attached a_loader.load (l_assembly_name) as l_ref_ass and then
						attached l_ref_ass.location as l_ref_ass_location and then
						attached l_ref_ass.full_name as l_ref_ass_full_name
					then
						ca := cache_writer.consumed_assembly_from_path (create {STRING_32}.make_from_cil (l_ref_ass_location))
						if ca /= Void and then not assembly_mapping.has (l_ref_ass_full_name) then
							last_index := last_index + 1
							assembly_ids.extend (ca)
							assembly_mapping.put (last_index, l_ref_ass_full_name)
								-- add also referenced assemblies of assembly referenced.
							build_referenced_assemblies (l_ref_ass, a_loader)
						end
					end
					i := i + 1
				end
			end
		end

	prepare_consumed_types (ass: ASSEMBLY; a_info_only: BOOLEAN)
			-- Build `consumed_types'.
		require
			non_void_assembly: ass /= Void
		local
			i, j, type_count, module_count, generated_count: INTEGER
			done: BOOLEAN
			type_consumer: TYPE_CONSUMER
			module_types: NATIVE_ARRAY [detachable SYSTEM_TYPE]
			t: SYSTEM_TYPE
			type_name: TYPE_NAME_SOLVER
			simple_name, dotnet_name: STRING
			list: SORTED_TWO_WAY_LIST [TYPE_NAME_SOLVER]
			used_names: HASH_TABLE [STRING, STRING]
			names: HASH_TABLE [SORTED_TWO_WAY_LIST [TYPE_NAME_SOLVER], STRING]
			l_string_tuple: like string_tuple
		do
			create names.make (1024)
			if attached ass.get_modules as modules then
				module_count := modules.count
				from
					i := 0
				until
					i >= module_count or done
				loop
					if attached modules.item (i) as l_module then
						from
							module_types := fetch_module_types (l_module)
							type_count := module_types.count
							j := 0
						until
							j >= type_count
						loop
							t := module_types.item (j)
							if t /= Void and then is_consumed_type (t) then
								generated_count := generated_count + 1
								create type_name.make (t)
								simple_name := type_name.simple_name
								names.search (simple_name)
								if names.found and attached names.found_item as l_names then
									l_names.extend (type_name)
								else
									create list.make
									list.extend (type_name)
									names.put (list, simple_name)
								end
							end
							j := j + 1
						end
					end
					if attached status_querier as l_status_querier then
						done := l_status_querier.item (Void)
					end
					i := i + 1
				end
			end

			create used_names.make (generated_count)
			create type_consumers.make (generated_count)
			from
				names.start
			until
				names.after or done
			loop
				list := names.item_for_iteration
				from
					list.start
				until
					list.after
				loop
					type_name := list.item
					create dotnet_name.make_from_cil (type_name.internal_type.full_name)
					simple_name := formatted_type_name (dotnet_name, used_names)
					type_name.set_eiffel_name (simple_name)
					list.forth
				end
				if attached status_querier as l_status_querier then
					done := l_status_querier.item (Void)
				end
				names.forth
			end
			used_names := Void

			from
				l_string_tuple := string_tuple
				names.start
			until
				names.after or done
			loop
				list := names.item_for_iteration
				from
					list.start
				until
					list.after
				loop
					type_name := list.item
					if a_info_only then
						create {TYPE_INFO_ONLY_CONSUMER}type_consumer.make (type_name.internal_type, type_name.eiffel_name)
					else
						create type_consumer.make (type_name.internal_type, type_name.eiffel_name)
					end

					type_consumers.put (type_consumer, type_name.eiffel_name)
					if attached status_printer as l_status_printer then
						l_string_tuple.put ({STRING_32} "Analyzed " +
							create {STRING_32}.make_from_cil (type_name.internal_type.full_name), 1)
						l_status_printer.call (l_string_tuple)
					end
					if attached status_querier as l_status_querier then
						done := l_status_querier.item (Void)
					end
					list.forth
				end
				if attached status_querier as l_status_querier then
					done := l_status_querier.item (Void)
				end
				names.forth
			end
		end

	serialize_consumed_types (a_info_only: BOOLEAN)
			-- Build `consumed_types'.
		local
			type_consumer: TYPE_CONSUMER
			serializer: EIFFEL_SERIALIZER
			s: PATH
			done: BOOLEAN
			type: CONSUMED_TYPE
			parent: detachable CONSUMED_REFERENCED_TYPE
			types: CONSUMED_ASSEMBLY_TYPES
			mapping: CONSUMED_ASSEMBLY_MAPPING
			l_string_tuple: like string_tuple
			l_is_delegate, l_is_value_type: BOOLEAN
			l_file_position: INTEGER
		do
			create_consumed_assembly_folders

			serializer := {EIFFEL_SERIALIZATION}.serializer
			create types.make (type_consumers.count)
			l_string_tuple := string_tuple

			from
				type_consumers.start
			until
				type_consumers.after or done
			loop
				type_consumer := type_consumers.item_for_iteration
				type_consumers.remove (type_consumers.key_for_iteration)
				if not a_info_only then
					type_consumer.initialize
					if not type_consumer.initialized then
							-- An error occurred during the initialization of type.
							-- Notice the problem on this specific type and try the next type.
						if type_consumer.consumed_type.dotnet_name /= Void then
							set_error (Type_initialization_error, {STRING_32} "One of the features of " + type_consumer.consumed_type.dotnet_name +" is invalid.")
						else
							set_error (Type_initialization_error, {STRING_32} "")
						end
					else
						type := type_consumer.consumed_type
						parent := type.parent
						if parent /= Void then
							l_is_value_type := parent.name.is_equal (once "System.ValueType")
							l_is_delegate := parent.name.is_equal (once "System.MulticastDelegate") or parent.name.is_equal (once "System.Delegate")
						end

							-- do not add base types in types.xml
						if not is_base_type (type.dotnet_name) then
							types.put (type.dotnet_name, type.eiffel_name, type.is_interface, type.is_enum, l_is_delegate, l_is_value_type, l_file_position)

								-- Delete constructor of System.Object for compiler
							if type.dotnet_name.is_equal (once "System.Object") then
								type.set_constructors (create {ARRAYED_LIST [CONSUMED_CONSTRUCTOR]}.make (0))
							end
							s := destination_path.extended (classes_file_name)

							serializer.serialize (type, s.name, True)
							l_file_position := serializer.last_file_position
							if not serializer.successful and attached error_printer as l_error_printer then
								if attached serializer.error_message as err then
									set_error (Serialization_error,{STRING_32} "" + type.eiffel_name + ", " + err)
								else
									set_error (Serialization_error, {STRING_32} "" + type.eiffel_name + ", error")
								end
								l_string_tuple.put (error_message, 1)
								l_error_printer.call (l_string_tuple)
							else
								if attached status_printer as l_status_printer then
									l_string_tuple.put ({STRING_32} "Written " + s.name + ": " + type.dotnet_name, 1)
									l_status_printer.call (l_string_tuple)
								end
								if attached status_querier as l_status_querier then
									done := l_status_querier.item (Void)
								end
							end
						end
					end
				else
						-- Consume only info
					type := type_consumer.consumed_type
					if not is_base_type (type.dotnet_name) then
						types.put (type.dotnet_name, type.eiffel_name, type.is_interface, type.is_enum, False, False, 0)
					end
				end
			end

			create mapping.make (assembly_ids)
			serializer.serialize (types, destination_path.extended (Assembly_types_file_name).name, False)
			serializer.serialize (mapping, destination_path.extended (Assembly_mapping_file_name).name, False)
		end

	create_consumed_assembly_folders
			-- creates consumed assembly folders
		require
			non_void_destination_path: destination_path /= Void
			valid_destination_path: not destination_path.is_empty
		local
			l_dir: DIRECTORY
		do
			create l_dir.make_with_path (destination_path)
			if not l_dir.exists then
				l_dir.create_dir
			end
		end

	type_consumers: STRING_TABLE [TYPE_CONSUMER]
			-- Assembly type consumers

	assembly_ids: LINKED_LIST [CONSUMED_ASSEMBLY]
			-- Assembly ids

	is_base_type (a_type_name: READABLE_STRING_GENERAL): BOOLEAN
			-- is `a_type_name' a base type?
		require
			non_void_a_type_name: a_type_name /= Void
			not_empty_a_type_name: not a_type_name.is_empty
		do
			Result := base_types.has (a_type_name)
		end

feature {NONE} -- Constants

	string_tuple: TUPLE [STRING_32]
			-- Tuple that contain only a string object.
		once
			create Result
		end

	base_types: STRING_TABLE [BOOLEAN]
			-- base types.
		once
			create Result.make (15)
			Result.put (True, "System.Byte")
			Result.put (True, "System.Int16")
			Result.put (True, "System.Int32")
			Result.put (True, "System.Int64")
			Result.put (True, "System.IntPtr")
			Result.put (True, "System.UInt16")
			Result.put (True, "System.UInt32")
			Result.put (True, "System.UInt64")
			Result.put (True, "System.UIntPtr")
			Result.put (True, "System.Single")
			Result.put (True, "System.Double")
			Result.put (True, "System.Char")
			Result.put (True, "System.Boolean")
			Result.put (True, "System.SByte")
			Result.put (True, "EiffelSoftware.Runtime.ANY")
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
