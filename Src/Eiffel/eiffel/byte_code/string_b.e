indexing
	description: "Byte code for Eiffel string (allocated each time)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class STRING_B

inherit
	EXPR_B
		redefine
			enlarged, is_simple_expr, allocates_memory, is_constant_expression
		end

create
	make

feature {NONE} -- Initialization

	make (v: STRING) is
			-- Assign `v' to `value'.
		require
			v_not_void: v /= Void
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_string_b (Current)
		end

feature -- Access

	value: STRING
			-- Character value

	is_dotnet_string: BOOLEAN
			-- Is current a manifest System.String constant?

feature -- Properties

	type: CL_TYPE_I is
			-- String type
		do
			if is_dotnet_string then
				Result := system_string_type
			else
				Result := string_type
			end
		end

	enlarged: STRING_BL is
			-- Enlarge node
		do
			create Result.make (value)
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- Register `r' is not used for string value computation
		do
		end

	is_simple_expr: BOOLEAN is True
			-- A string is a simple expression

	allocates_memory: BOOLEAN is True
			-- Current always allocates memory.

	is_constant_expression: BOOLEAN is True
			-- A string is a constant expression.

feature -- Settings

	set_is_dotnet_string (v: like is_dotnet_string) is
			-- Set `is_dotnet_string' with `v'.
		do
			is_dotnet_string := v
		ensure
			is_dotnet_string_set: is_dotnet_string = v
		end

feature {NONE} -- Implementation: types

	string_type: CL_TYPE_I is
			-- Type of STRING.
		once
			create Result.make (System.string_id)
		ensure
			string_type_not_void: Result /= Void
		end

	system_string_type: CL_TYPE_I is
			-- Type of SYSTEM_STRING.
		require
			il_generation: System.il_generation
		once
			create Result.make (System.system_string_id)
		ensure
			system_string_type_not_void: Result /= Void
		end

invariant
	value_not_void: value /= Void

indexing
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

end -- class STRING_B
