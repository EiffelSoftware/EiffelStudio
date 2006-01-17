indexing

	 description:
			"Abstract description of an item in the class indexing list. %
			%Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	 date: "$Date$"
	 revision: "$Revision$"

class INDEX_AS

inherit
	AST_EIFFEL

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like tag; i: like index_list; c_as: SYMBOL_AS) is
			-- Create a new INDEX AST node.
		require
			i_not_void: i /= Void
		do
			tag := t
			index_list := i
			colon_symbol := c_as
		ensure
			tag_set: tag = t
			index_list_set: index_list = i
			colon_symbol_set: colon_symbol = c_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_index_as (Current)
		end

feature -- Roundtrip

	colon_symbol: SYMBOL_AS
			-- Colon symbol associated with this structure.

feature -- Attributes

	tag: ID_AS
			-- Tag of the index list

	index_list: EIFFEL_LIST [ATOMIC_AS]
			-- Indexes

feature -- Roundtrip/Location

	complete_start_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if tag /= Void then
				Result := tag.complete_start_location (a_list)
			else
				Result := index_list.complete_start_location (a_list)
			end
		end

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			Result := index_list.complete_end_location (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (tag, other.tag) and
				equivalent (index_list, other.index_list)
		end

	is_equiv (other: like Current): BOOLEAN is
		do
			Result := equivalent (tag, other.tag) and then
						equivalent (index_list, other.index_list)
		end

feature {DOCUMENTATION_ROUTINES} -- Access

	content_as_string: STRING is
			-- Merge content into a single string.
		local
			il: like index_list
		do
			create Result.make (20)
			il := index_list
			from
				il.start
			until
				il.after
			loop
				Result.append (il.item.string_value)
				il.forth
				if not il.after then
					Result.append (", ")
				end
			end
		end

invariant
	index_list_not_void: index_list /= Void

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

end -- class INDEX_AS
