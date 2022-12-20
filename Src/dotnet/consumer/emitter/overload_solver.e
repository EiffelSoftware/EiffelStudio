note
	description: "Solve overloading for a given .NET type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	OVERLOAD_SOLVER

inherit
	SYSTEM_OBJECT

	REFLECTION

	SHARED_ASSEMBLY_MAPPING

	NAME_SOLVER

	METHOD_RETRIEVER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize solver
		do
			create method_table.make (20)
			create eiffel_names.make (50)
			create reserved_names.make (0)
		end

feature {NONE} -- Access

	eiffel_names: HASH_TABLE [HASH_TABLE [STRING, STRING], STRING]
			-- give hash_table of eiffel names for a dotnet type name.

	key_args (args: detachable NATIVE_ARRAY [detachable PARAMETER_INFO]; return_type, declared_type: detachable SYSTEM_TYPE): STRING
			-- return signature corresponding to args.
		local
			i: INTEGER
		do
			create Result.make_empty
			if args /= Void then
				from
					i := 0
				until
					args = Void or else i = args.count
				loop
					if attached args.item (i) as l_args and then attached l_args.parameter_type as l_type then
						Result.append (create {STRING_8}.make_from_cil (l_type.full_name))
					end
					i := i + 1
				end
			end
			if return_type /= Void then
				Result.append (create {STRING_8}.make_from_cil (return_type.full_name))
			end
			if declared_type /= Void then
				Result.append (create {STRING_8}.make_from_cil (declared_type.full_name))
			end
		ensure
			non_void_result: Result /= Void
		end


feature	-- Access

	unique_eiffel_name (a_dotnet_name: SYSTEM_STRING; args: detachable NATIVE_ARRAY [detachable PARAMETER_INFO]; return_type, declaring_type: detachable SYSTEM_TYPE): detachable STRING
		require
			non_void_a_dotnet_name: a_dotnet_name /= Void
		do
			if attached eiffel_names.item (a_dotnet_name) as l_names then
				Result := l_names.item (key_args (args, return_type, declaring_type))
			end
		end

feature -- Basic Operations

	solve
			-- Initialize `procedures' and `functions'.
			-- Can only be called once.
		require
			not_solved: not solved
		local
			method_list: SORTED_TWO_WAY_LIST [METHOD_SOLVER]
			first_method, method: METHOD_SOLVER
			name: STRING
			i, param_count: INTEGER
			is_unique: BOOLEAN
			number_of_methods_with_parameters: INTEGER
			eiffel_args: HASH_TABLE [STRING, STRING]
		do
			from
				method_table.start
			until
				method_table.after
			loop
				method_list := method_table.item_for_iteration
				method_list.start
				first_method := method_list.item
				param_count := first_method.arguments.count
				number_of_methods_with_parameters := 0
				from
					method_list.forth
					if
						not method_list.after and then
						not first_method.is_conversion_operator
					then
						number_of_methods_with_parameters := 1
					end
				until
					method_list.after
				loop
					method := method_list.item
					if method.is_conversion_operator then
						name := formatted_feature_name (method.starting_resolution_name)
					else
							-- Check starting resolution name (com import assemblies have version number suffixed names)
						name := formatted_feature_name (method.starting_resolution_name)
						is_unique := is_unique_signature (method, method_list, 0)
						if not is_unique then
							number_of_methods_with_parameters := number_of_methods_with_parameters + 1
							from
								i := 1
							until
								is_unique or i > method.arguments.count
							loop
								name.append_character ('_')
								name.append (
									formatted_variable_type_name (method.arguments.item (i).type.name))
								is_unique := is_unique_signature (method, method_list, i)
								i := i + 1
							end
						end
					end
					method.set_eiffel_name (unique_feature_name (name))
					method_list.forth
				end
				if number_of_methods_with_parameters > 1 then
					from
						name := formatted_feature_name (first_method.starting_resolution_name)
						i := 1
					until
						i > param_count
					loop
						name.append_character ('_')
						name.append (formatted_variable_type_name (
							first_method.arguments.item (i).type.name))
						i := i + 1
					end
					first_method.set_eiffel_name (unique_feature_name (name))
				else
					first_method.set_eiffel_name (unique_feature_name (
						first_method.starting_resolution_name))
				end
				method_table.forth
			end
			from
				method_table.start
			until
				method_table.after
			loop
				method_list := method_table.item_for_iteration
				from
					method_list.start
				until
					method_list.after
				loop
					method := method_list.item
					eiffel_names.search (method.dotnet_name)
					if eiffel_names.found and then attached eiffel_names.found_item as l_found_item then
						l_found_item.put (
							method.eiffel_name,
							key_args (method.internal_method.get_parameters,
								method.internal_method.return_type,
								method.internal_method.declaring_type))
					else
						create eiffel_args.make (1)
						eiffel_args.put (method.eiffel_name,
							key_args (method.internal_method.get_parameters,
								method.internal_method.return_type,
								method.internal_method.declaring_type))
						eiffel_names.put (eiffel_args, method.dotnet_name)
					end
					method_list.forth
				end
				method_table.forth
			end
			solved := True
		ensure
			solved: solved
		end

	is_unique_signature (method: METHOD_SOLVER; method_list: LIST [METHOD_SOLVER]; index: INTEGER): BOOLEAN
			-- Are parameter types starting from index `index' in `method' unique in `method_list'?
		require
			non_void_method: method /= Void
			non_void_list: method_list /= Void
			valid_list: method_list.has (method)
			valid_index: index >= 0
		local
			l_name: detachable STRING
			l_item_name: STRING
			meth: METHOD_SOLVER
			count, i: INTEGER
			cursor: CURSOR
		do
			Result := True
			if method.arguments.count /= 0 then
				cursor := method_list.cursor
				from
					method_list.start
				until
					method_list.after or not Result
				loop
					meth := method_list.item
					if meth /= method then
						count := meth.arguments.count.min (method.arguments.count)
						if count >= index then
							if l_name = Void then
								l_name := method.starting_resolution_name
							end
							l_item_name := meth.starting_resolution_name
							if l_name.is_equal (l_item_name) then
								from
									i := index
								until
									i > count or not Result
								loop
									Result := method_list.item = method or i > 0 and then
										not method_list.item.arguments.item (i).type.same_as
											(method.arguments.item (i).type)
									i := i + 1
								end
							end
						end
					end
					method_list.forth
				end
				method_list.go_to (cursor)
			end
		ensure
			method_list_position_identical: method_list.cursor.is_equal (old method_list.cursor)
		end

feature -- Status Report

	solved: BOOLEAN
			-- Was `solve' called?

feature -- Element Settings

	add_method (meth: METHOD_INFO)
			-- Include `meth' in overload solving process.
			-- Remove `get_' for properties getters.
		require
			non_void_meth: meth /= Void
		do
			internal_add_method (meth, False)
		end

	add_property (property: PROPERTY_INFO)
			-- Include `meth' in overload solving process.
			-- Remove `get_' for properties getters.
		require
			non_void_property: property /= Void
		local
			l_meth: detachable METHOD_INFO
		do
			l_meth := property_getter (property)
			if l_meth /= Void then
				if is_consumed_method (l_meth) then
					internal_add_method (l_meth, True)
				end
			end
			l_meth := property_setter (property)
			if l_meth /= Void then
				if is_consumed_method (l_meth) then
					internal_add_method (l_meth, False)
				end
			end
		end

	add_event (event: EVENT_INFO)
			-- Include `meth' in overload solving process.
			-- Remove `get_' for properties getters.
		require
			non_void_event: event /= Void
		local
			l_meth: detachable METHOD_INFO
		do
			l_meth := event_raiser (event)
			if l_meth /= Void then
				if is_consumed_method (l_meth) then
					internal_add_method (l_meth, False)
				end
			end
			l_meth := event_adder (event)
			if l_meth /= Void then
				if is_consumed_method (l_meth) then
					internal_add_method (l_meth, False)
				end
			end
			l_meth := event_remover (event)
			if l_meth /= Void then
				if is_consumed_method (l_meth) then
					internal_add_method (l_meth, False)
				end
			end
		end

feature {NONE} -- Internal Statur Setting	

	internal_add_method (meth: METHOD_INFO; get_property: BOOLEAN)
			-- Include `meth' in overload solving process.
			-- Remove `get_' for properties getters.
		require
			non_void_meth: meth /= Void
			is_consumed_method: is_consumed_method (meth)
		local
			l_dn_name: SYSTEM_STRING
			l_len: INTEGER
			name: STRING
			l_list: SORTED_TWO_WAY_LIST [METHOD_SOLVER]
		do
			l_dn_name := meth.name
			if attached l_dn_name then
				if get_property then
					l_len := get_prefix.length
					if l_dn_name.length > l_len and then {SYSTEM_STRING}.compare (get_prefix, l_dn_name.substring (0, l_len), True) = 0 then
						l_dn_name := l_dn_name.substring (l_len)
						if not attached l_dn_name then
							check from_documentation: False then end
						end
					end
				end
				name := l_dn_name
				method_table.search (name)
				if method_table.found and then attached method_table.found_item as l_found_item then
					l_found_item.extend (create {METHOD_SOLVER}.make (meth, get_property))
				else
					create l_list.make
					method_table.put (l_list, name)
					l_list.extend (create {METHOD_SOLVER}.make (meth, get_property))
				end
			else
				check
					method_name_attached: False
				end
			end
		end

feature {NONE} -- Implementation

	method_table: HASH_TABLE [SORTED_TWO_WAY_LIST [METHOD_SOLVER], STRING]
			-- Table of methods

	get_prefix: SYSTEM_STRING = "get_";
			-- Get property prefix

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
