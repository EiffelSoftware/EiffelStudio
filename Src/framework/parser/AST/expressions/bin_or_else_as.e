note
	description: "AST representation of binary `or else' operation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	BIN_OR_ELSE_AS

inherit
	BINARY_AS
		rename
			operator as or_keyword,
			operator_index as or_keyword_index
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
				else_keyword_index := s_as.index
			end
		ensure
			left_set: left = l
			right_set: right = r
			or_keyword_set: k_as /= Void implies or_keyword_index = k_as.index
			else_keyword_set: s_as /= Void implies else_keyword_index = s_as.index
		end

feature -- Properties

	op_name: ID_AS
			-- Name without the infix keyword.
		once
			create Result.initialize ("or else")
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Properties

	infix_function_name: STRING
			-- Qualified name with the infix keyword.
		once
			Result := infix_feature_name_with_symbol (op_name.name)
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_bin_or_else_as (Current)
		end

feature -- Roundtrip

	else_keyword_index: INTEGER
			-- Index of `then' operation AST node.

	else_keyword (a_list: LEAF_AS_LIST): LEAF_AS
			-- Binary operation AST node.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := else_keyword_index
			if a_list.valid_index (i) then
				Result := a_list.i_th (i)
			end
		end

note
	copyright:	"Copyright (c) 1984-2010, Eiffel Software"
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

end -- class BIN_OR_ELSE_AS
