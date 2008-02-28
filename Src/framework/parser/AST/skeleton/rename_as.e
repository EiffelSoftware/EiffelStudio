indexing

	description: "Abstract description of a renaming pair. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class RENAME_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (o: like old_name; n: like new_name; k_as: KEYWORD_AS) is
			-- Create a new RENAME_PAIR AST node.
		require
			o_not_void: o /= Void
			n_not_void: n /= Void
		do
			old_name := o
			new_name := n
			if k_as /= Void then
				as_keyword_index := k_as.index
			end
		ensure
			old_name_set: old_name = o
			new_name_set: new_name = n
			as_keyword_set: k_as /= Void implies as_keyword_index = k_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_rename_as (Current)
		end

feature -- Roundtrip

	as_keyword_index: INTEGER
			-- Index of keyword "as" associated with this structure.

	as_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
			-- Keyword "as" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := as_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Attributes

	old_name: FEATURE_NAME
			-- Name of the renamed feature

	new_name: FEATURE_NAME
			-- New name

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := old_name.first_token (a_list)
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := new_name.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (old_name, other.old_name) and
				equivalent (new_name, other.new_name)
		end

invariant
	old_name_not_void: old_name /= Void
	new_name_not_void: new_name /= Void

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

end -- class RENAME_AS
