note
	description: "Abstract description for formal generic type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class FORMAL_AS

inherit
	TYPE_AS
		redefine
			first_token,
			last_token
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (n: ID_AS; is_ref, is_exp, is_froz: BOOLEAN; r_as: like formal_keyword)
			-- Create a new FORMAL AST node.
		require
			n_not_void: n /= Void
		do
			name := n
			is_reference := is_ref
			is_expanded := is_exp
			if is_froz then
				set_variance_mark (r_as, True, False)
			end
			if r_as /= Void then
				formal_keyword_index := r_as.index
			end
		ensure
			name_set: name = n
			is_reference_set: is_reference = is_ref
			is_expanded_set: is_expanded = is_exp
			is_frozen_set: has_frozen_mark = is_froz
			formal_keyword_set: r_as /= Void implies formal_keyword_index = r_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_formal_as (Current)
		end

feature -- Roundtrip

	formal_keyword_index: INTEGER
			-- Index of keyword "reference", "expanded" or "frozen" associated with this structure.

	formal_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "reference", "expanded" or "frozen" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, formal_keyword_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := name.index
		end

feature -- Properties

	name: ID_AS
			-- Formal generic parameter name

	position: INTEGER
			-- Position of the formal parameter in the declaration
			-- array

	is_reference: BOOLEAN
			-- Is Current formal to be always instantiated as a reference type?

	is_expanded: BOOLEAN
			-- Is Current formal to be always instantiated as an expanded type?

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := Precursor (a_list)
			if Result = Void then
				if a_list /= Void and then formal_keyword_index /= 0 then
					Result := formal_keyword (a_list)
				else
					Result := name.first_token (a_list)
				end
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := Precursor (a_list)
			if Result = Void then
				Result := name.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := position = other.position
				and then is_reference = other.is_reference
				and then is_expanded = other.is_expanded
				and then has_same_marks (other)
		end

feature -- Output

	dump: STRING
		do
			create Result.make (3)
			dump_marks (Result)
			if is_expanded then
				Result.append ("expanded ")
			end
			if is_reference then
				Result.append ("reference ")
			end
			Result.append ("G#")
			Result.append_integer (position)
		end

feature {COMPILER_EXPORTER} -- Settings

	set_position (i: INTEGER)
			-- Assign `i' to `position'.
		do
			position := i
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
