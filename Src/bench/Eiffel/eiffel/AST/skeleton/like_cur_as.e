indexing

	description: "Node for `like Current' type. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class LIKE_CUR_AS

inherit
	TYPE_AS
		redefine
			has_like, is_loose, first_token, last_token
		end

	LOCATION_AS
		rename
			make as make_with_location
		end

create
	make

feature{NONE} -- Initialization

	make (c_as: KEYWORD_AS; l_as: KEYWORD_AS) is
			-- Create new LIKE_CURRENT AST node.
		require
			c_as_not_void: c_as /= Void
		do
			like_keyword := l_as
			current_keyword := c_as
			make_from_other (c_as)
		ensure
			like_keyword_set: like_keyword = l_as
			current_keyword_set: current_keyword = c_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_like_cur_as (Current)
		end

feature -- Roundtrip

	like_keyword: KEYWORD_AS
		-- Keyword "like" associated with this structure		

	current_keyword: KEYWORD_AS
		-- Keyword "current" associated with this structure		

	lcurly_symbol, rcurly_symbol: SYMBOL_AS
			-- Left and/or right curly symbol(s) associated with this structure
			-- Maybe none of them, or maybe only left curly appears.

	set_lcurly_symbol (s_as: SYMBOL_AS) is
			-- Set `lcurly_symbol' with `s_as'.
		do
			lcurly_symbol := s_as
		end

	set_rcurly_symbol (s_as: SYMBOL_AS) is
			-- Set `rcurly_symbol' with `s_as'.
		do
			rcurly_symbol := s_as
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Properties

	has_like: BOOLEAN is True
			-- Does the type have anchor in its definition ?

	is_loose: BOOLEAN is True
			-- Does type depend on formal generic parameters and/or anchors?

feature

	actual_type: LIKE_TYPE_A is
			-- Called when `like current' is used for a formal generic parameter
			-- or when used to evaluate a type in a class that had not yet gone
			-- through DEGREE 4.
		do
			create {UNEVALUATED_LIKE_TYPE} Result.make_current
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := Precursor (a_list)
			if Result = Void then
				if a_list = Void then
					Result := current_keyword.first_token (a_list)
				else
					Result := like_keyword.first_token (a_list)
				end
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := Precursor (a_list)
			if Result = Void then
				Result := current_keyword.last_token (a_list)
			end
		end

feature -- Output

	dump: STRING is "like Current";
			-- Dump trace

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class LIKE_CUR_AS
