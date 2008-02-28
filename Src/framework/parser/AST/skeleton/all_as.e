indexing
	description: "AST representation of an `all' structure."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ALL_AS

inherit
	FEATURE_SET_AS

create
	initialize

feature {NONE} -- Initialization

	 initialize (a_as: KEYWORD_AS) is
			-- Create a new ALL AST node.
		do
			if a_as /= Void then
				all_keyword_index := a_as.index
			end
		ensure
			all_keyword_set: a_as /= Void implies all_keyword_index = a_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_all_as (Current)
		end

feature -- Roundtrip

	all_keyword_index: INTEGER
			-- Index of keyword "all" assoicated with this structure

	all_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
			-- Keyword "all" assoicated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := all_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := True
		end

feature -- Roundtrip/Location

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= void and all_keyword_index /= 0 then
				Result := all_keyword (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= void and all_keyword_index /= 0 then
				Result := all_keyword (a_list)
			end
		end

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

end -- class ALL_AS
