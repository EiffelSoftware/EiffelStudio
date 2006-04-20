indexing

	description: "Byte code for once manifest string (pre-allocated)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ONCE_STRING_B

inherit
	EXPR_B
		redefine
			enlarged,
			is_simple_expr, is_type_fixed, allocates_memory, size
		end

create
	make

feature {NONE} -- Initialization

	make (v: STRING; n: INTEGER) is
			-- Create object for `n'-th once manifest string with value `v'.
		require
			v_not_void: v /= Void
			positive_n: n > 0
		do
			value := v
			number := n
		ensure
			value_set: value = v
			number_set: number = n
		end

feature -- Access

	value: STRING
			-- Character value

	number: INTEGER
			-- Ordinal number of once manifest string in routine

	is_dotnet_string: BOOLEAN
			-- Is current a manifest System.String constant?

feature -- Status report

	is_type_fixed: BOOLEAN is True
			-- Is type of the expression statically fixed,
			-- so that there is no variation at run-time?

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_once_string_b (Current)
		end

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

	enlarged: ONCE_STRING_BL is
			-- Enlarge node
		do
			create Result.make (value, number)
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- Register `r' is not used for string value computation
		do
		end

	is_simple_expr: BOOLEAN is True
			-- A string is a simple expression

	allocates_memory: BOOLEAN is
			-- Does the expression allocates memory?
		do
				-- Current always allocates memory
			Result := True
		end

	size: INTEGER is
		do
				-- Inlining will not be done for once string as they need to
				-- be generated in the context of the feature were they are defined.
			Result := 101	-- equal to maximum size of inlining + 1 (Found in FREE_OPTION_SD)
		end

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
			-- Type of STRING
		once
			create Result.make (System.string_id)
		ensure
			string_type_not_void: Result /= Void
		end

	system_string_type: CL_TYPE_I is
			-- Type of SYSTEM_STRING
		require
			il_generation: System.il_generation
		once
			create Result.make (System.system_string_id)
		ensure
			system_string_type_not_void: Result /= Void
		end

feature {BYTE_NODE_VISITOR} -- Implementation: numbering

	body_index: INTEGER is
			-- Original body index with this once manifest string
		do
			Result := context.original_body_index
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

end
