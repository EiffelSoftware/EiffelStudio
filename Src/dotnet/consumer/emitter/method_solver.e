note
	description: "Method to be consumed in Eiffel, intermediate structure used to solve overloading"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	METHOD_SOLVER

inherit
	COMPARABLE

	NAME_FORMATTER
		undefine
			is_equal
		end

	ARGUMENT_SOLVER
		rename
			arguments as solved_arguments
		undefine
			is_equal
		end

	SHARED_ASSEMBLY_MAPPING
		undefine
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (meth: METHOD_INFO; get_property: BOOLEAN)
			-- Set `internal_method' with `meth'.
		require
			non_void_method: meth /= Void
		do
			internal_method := meth
			is_get_property := get_property
			if
				internal_method.is_special_name and
				(internal_method.name.equals (op_explicit) or
					internal_method.name.equals (op_implicit))
			then
				if
					internal_method.get_parameters.count = 1 and
					not internal_method.return_type.equals_type (Void_type)
				then
					is_conversion_operator := True
				end
			end
			arguments := solved_arguments (meth)
		ensure
			method_set: internal_method = meth
			arguments_set: arguments /= Void
		end


feature -- Access

	dotnet_name: STRING
			-- .NET name
		do
			create Result.make_from_cil (internal_method.name)
		end

	starting_resolution_name: STRING
			-- .NET Name used to perform overloading resolution
		do
			Result := internal_start_name
			if Result = Void then
				Result := dotnet_name
				if is_get_property and then Result.substring_index ("get_", 1) = 1 then
					Result.remove_head (4)
				elseif is_conversion_operator then
					if internal_method.get_parameters.item (0).parameter_type.equals_type (internal_method.reflected_type) then
						Result := to_conversion_name.twin
						Result.append (
							formatted_variable_type_name (referenced_type_from_type (
								internal_method.return_type).name))
					else
						Result := from_conversion_name.twin
						Result.append (
							formatted_variable_type_name (referenced_type_from_type (
								internal_method.get_parameters.item (0).parameter_type).name))
					end
				end
				if is_com_interface_member then
					Result.append (com_member_suffix)
				end
				internal_start_name := Result
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			internal_start_name_set: internal_start_name = Result
		end

	eiffel_name: STRING
			-- Eiffel name

	arguments: ARRAY [CONSUMED_ARGUMENT]
			-- Method arguments

	is_get_property: BOOLEAN
			-- Is getter method of a property?

	is_conversion_operator: BOOLEAN
			-- Is Current a conversion operator?

	is_com_interface_member: BOOLEAN
			-- Is member from a COM interface	
		local
			l_source_type: SYSTEM_TYPE
		do
			l_source_type := internal_method.declaring_type
			Result := l_source_type.is_interface and l_source_type.is_import
		end

	com_member_suffix: STRING
			-- A COM member's suffix
		require
			is_com_interface_member: is_com_interface_member
		local
			l_type: SYSTEM_TYPE
			l_name: SYSTEM_STRING
			l_count, i: INTEGER
			l_stop: BOOLEAN
		do
			l_type := internal_method.declaring_type
			l_name := l_type.name
			Result ?= suffix_table.item (l_name)
			if Result = Void then
				if l_type.get_interfaces.count > 0 then
						-- Only version if a COM interface inherits another interface.
						-- There is no need to check if the inherited interfaces are COM interfaces, becasue they should be. If not
						-- then the COM binary will no load.
					l_count := l_name.length - 1
					from i := l_count until i < 0 or l_stop loop
						if l_name.chars (i).is_digit then
							i := i - 1
						else
							l_stop := True
							i := i + 1
						end
					end
					if i <= l_count then
						create Result.make_from_cil ({SYSTEM_STRING}.concat_string_string ("_", l_name.substring (i)))
					else
						create Result.make_empty
					end
				else
					create Result.make_empty
				end
				suffix_table.add (l_name, Result)
			end
		end

feature -- Element Settings

	set_eiffel_name (name: like eiffel_name)
			-- Set `eiffel_name' with `name'.
		require
			non_void_name: name /= Void
		do
			eiffel_name := name
		ensure
			name_set: eiffel_name = name
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			if arguments.count = other.arguments.count then
				Result := internal_method.is_public and not other.internal_method.is_public
			else
				Result := arguments.count < other.arguments.count
			end

		end

feature {METHOD_SOLVER, OVERLOAD_SOLVER} -- Implementation

	internal_method: METHOD_INFO
			-- Method to be consumed

feature {NONE} -- Implementation

	suffix_table: HASHTABLE
			--
		once
			create Result.make (100)
		ensure
			result_attached: Result /= Void
		end

	internal_start_name: STRING
			-- Cached version of `starting_resolution_name'

feature {NONE} -- Constants

	Void_type: SYSTEM_TYPE
			-- Void .NET type
		once
			Result := {SYSTEM_TYPE}.get_type_string (("System.Void").to_cil)
		end

	op_implicit: SYSTEM_STRING = "op_Explicit"
	op_explicit: SYSTEM_STRING = "op_Implicit"
			-- Special routine for conversion.

	from_conversion_name: STRING = "from_"
	to_conversion_name: STRING = "to_";
			-- Generated name corresponding to `op_xx'.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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


end -- class METHOD_SOLVER
