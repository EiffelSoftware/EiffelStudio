note
	description: "AST representation of a once routines."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ONCE_AS

inherit
	INTERNAL_AS
		redefine
			process, is_once
		end

create
	make

feature{NONE} -- Initialization

	make (o: like once_keyword; k: detachable KEY_LIST_AS; c: like compound)
			-- Create new DO AST node.
		do
			initialize (c)
			if o /= Void then
				once_keyword_index := o.index
			end
			internal_keys := k
		ensure
			once_keyword_set: o /= Void implies once_keyword_index = o.index
			keys_set: internal_keys = k
			compound_set: compound = c
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_once_as (Current)
		end

feature -- Roundtrip

	once_keyword_index: INTEGER
			-- Index of keyword "once" associated with this structure

	once_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "once" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := once_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	internal_keys: detachable KEY_LIST_AS
			-- Internal once keys, in which "(" and ")" are stored
		note
			option: stable
		attribute
		end

feature -- Properties

	is_once: BOOLEAN = True
			-- Is the current routine body a once one ?

	keys: detachable EIFFEL_LIST [STRING_AS]
			-- Once keys
		do
			if attached internal_keys as k then
				Result := k.meaningful_content
			end
		ensure
			good_result: (internal_keys = Void implies Result = Void) and
						 (internal_keys /= Void implies Result = internal_keys.meaningful_content)
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			if a_list /= Void then
				Result := once_keyword (a_list)
			elseif attached internal_keys as k then
				Result := k.first_token (Void)
			elseif attached compound as c then
				Result := c.first_token (Void)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			if attached compound as c then
				Result := compound.last_token (a_list)
			elseif attached internal_keys as k then
				Result := k.last_token (a_list)
			elseif a_list /= Void then
				Result := once_keyword (a_list)
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

end -- class ONCE_AS
