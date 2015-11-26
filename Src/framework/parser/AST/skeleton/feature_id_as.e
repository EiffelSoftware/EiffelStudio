note
	description: "AST node for a feature name used by a client."

class
	FEATURE_ID_AS

inherit
	AST_EIFFEL
	ID_SET_ACCESSOR

create
	make

feature {NONE} -- Creation

	make (n: like name)
			-- Create an AST node for feature of name `n'.
		do
			name := n
			make_id_set
		ensure
			name_set: name = n
			no_routine_id: routine_ids.is_empty
		end

feature -- Access

	name: ID_AS
			-- Name of the feature.

feature {AST_VISITOR} -- Visitor

	process (v: AST_VISITOR)
			-- <Prfecursor>
		do
			v.process_feature_id_as (Current)
		end

feature -- Roundtrip/Token

	index: INTEGER
			-- <Precursor>
		do
			Result := name.index
		end

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- <Precursor>
		do
			Result := name.first_token (a_list)
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
			-- <Precursor>
		do
			Result := name.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := name.is_equivalent (other.name)
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
