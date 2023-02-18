note
	description: "AST representation of a `ensure then' structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ENSURE_THEN_AS

inherit
	ENSURE_AS
		rename
			make as ensure_make
		redefine
			process,
			is_then, last_token
		end

create
	make

feature {NONE} -- Initialization

	make (a: like assertions; c: BOOLEAN; k_as, l_as: like then_keyword)
			-- Create new ENSURE_THEN AST node with marking it as a class postcondition iff `c` is `True`.
		require
			consistent_assertions: c = (attached a and then across a as p some p.is_class end)
		do
			ensure_make (a, c, k_as)
			if l_as /= Void then
				then_keyword_index := l_as.index
			end
		ensure
			is_class_set: is_class = c
			then_keyword_set: l_as /= Void implies then_keyword_index = l_as.index
		end

feature -- Roundtrip

	then_keyword_index: INTEGER
			-- Index of keyword "then" associated with this structure

	then_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "then" associated with this structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, then_keyword_index)
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_ensure_then_as (Current)
		end

feature -- Properties

	is_then: BOOLEAN = True
			-- Is the assertion list an "ensure then" part ?

feature -- Roundtrip/Token

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				if attached assertions as l_assertions then
					Result := l_assertions.last_token (a_list)
				else
					Result := Void
				end
			else
				if attached full_assertion_list as l_full_assertion_list then
					Result := l_full_assertion_list.last_token (a_list)
				elseif then_keyword_index /= 0 then
					Result := then_keyword (a_list)
				elseif ensure_keyword_index /= 0 then
					Result := ensure_keyword (a_list)
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
