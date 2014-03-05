note

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

	initialize (t: like tag; i: like index_list; c_as: like colon_symbol)
			-- Create a new INDEX AST node.
		require
			i_not_void: i /= Void
		do
			tag := t
			index_list := i
			if c_as /= Void then
				colon_symbol_index := c_as.index
			end
		ensure
			tag_set: tag = t
			index_list_set: index_list = i
			colon_symbol_set: c_as /= Void implies colon_symbol_index = c_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_index_as (Current)
		end

feature -- Roundtrip

	colon_symbol_index: INTEGER
			-- Index of colon symbol associated with this structure.

	colon_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Colon symbol associated with this structure.
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, colon_symbol_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := colon_symbol_index
		end

feature -- Attributes

	tag: detachable ID_AS
			-- Tag of the index list

	index_list: EIFFEL_LIST [ATOMIC_AS]
			-- Indexes

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached tag as l_tag then
				Result := l_tag.first_token (a_list)
			else
				Result := index_list.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := index_list.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (tag, other.tag) and
				equivalent (index_list, other.index_list)
		end

	is_equiv (other: like Current): BOOLEAN
		do
			Result := equivalent (tag, other.tag) and then
						equivalent (index_list, other.index_list)
		end

feature {DOCUMENTATION_EXPORT} -- Access

	content_as_string_32: detachable STRING_32
			-- Merge content into a single string.
		do
			if attached content_as_string as l_str then
				Result := encoding_converter.utf8_to_utf32 (l_str)
			end
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Access

	content_as_string: STRING
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
				Result.append_string (il.item.string_value)
				il.forth
				if not il.after then
					Result.append (", ")
				end
			end
		end

invariant
	index_list_not_void: index_list /= Void

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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

end -- class INDEX_AS
