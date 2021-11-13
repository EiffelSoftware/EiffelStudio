note
	description: "AST representation of binary `>=' operation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class BIN_GE_AS

inherit
	COMPARISON_AS

	PREFIX_INFIX_NAMES

create
	initialize

feature -- Access

	op_name: ID_AS
			-- Name without the infix keyword.
		once
			create Result.initialize_from_id ({PREDEFINED_NAMES}.greater_equal_operator_name_id)
		end

	operator_id: like alias_id
			-- <Precursor>
		do
			Result := alias_id ({PREDEFINED_NAMES}.greater_equal_operator_name_id, is_valid_binary_kind_mask ⦶ is_binary_kind_mask)
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_bin_ge_as (Current)
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
