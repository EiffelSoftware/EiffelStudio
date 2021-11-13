note
	description: "AST representation of binary `and then' operation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_AND_THEN_AS

inherit
	BINARY_AS
		rename
			operator as and_keyword,
			operator_index as and_keyword_index
		end

	PREFIX_INFIX_NAMES

create
	initialize,
	make

feature -- Initialization

	make (l: like left; r: like right; k_as, s_as: detachable KEYWORD_AS)
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			initialize (l, r, k_as)
			if s_as /= Void then
				then_keyword_index := s_as.index
			end
		ensure
			left_set: left = l
			right_set: right = r
			and_keyword_set: k_as /= Void implies and_keyword_index = k_as.index
			then_keyword_set: s_as /= Void implies then_keyword_index = s_as.index
		end

feature -- Access

	op_name: ID_AS
			-- Name without the infix keyword.
		once
			create Result.initialize_from_id ({PREDEFINED_NAMES}.and_then_operator_name_id)
		end

	operator_id: like alias_id
			-- <Precursor>
		do
			Result := alias_id ({PREDEFINED_NAMES}.and_then_operator_name_id, is_valid_binary_kind_mask ⦶ is_binary_kind_mask)
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_bin_and_then_as (Current)
		end

feature -- Roundtrip

	then_keyword_index: INTEGER
			-- Index of `then' operation AST node.

	then_keyword (a_list: LEAF_AS_LIST): detachable LEAF_AS
			-- Binary operation AST node.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := then_keyword_index
			if a_list.valid_index (i) then
				Result := a_list.i_th (i)
			end
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
