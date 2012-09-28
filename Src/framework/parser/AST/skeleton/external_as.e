note
	description: "AST representation of a external C routine."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_AS

inherit
	ROUT_BODY_AS
		redefine
			is_external
		end

	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (l: like language_name; a: like alias_name_literal; e_as, a_as: detachable KEYWORD_AS)
			-- Create a new EXTERNAL AST node.
		require
			l_not_void: l /= Void
		do
			language_name := l
			if a /= Void then
				Names_heap.put (a.value)
				alias_name_id := Names_heap.found_item
			end
			if e_as /= Void then
				external_keyword_index := e_as.index
			end
			if a_as /= Void then
				alias_keyword_index := a_as.index
			end
			alias_name_literal := a
		ensure
			language_name_set: language_name = l
			alias_keyword_set: a_as /= Void implies alias_keyword_index = a_as.index
			external_keyword_set: e_as /= Void implies external_keyword_index = e_as.index
			alias_name_literal_set: alias_name_literal = a
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_external_as (Current)
		end

feature -- Roundtrip

	alias_keyword_index: INTEGER
			-- Index of keyword "alias" associated with this class

	external_keyword_index: INTEGER
			-- Index of keyword "external" associated with this class

	alias_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "alias" associated with this class
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := alias_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	external_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "external" associated with this class
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := external_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	alias_name_literal: detachable STRING_AS
			-- String literal of alias name in this structure

feature -- Attributes

	language_name: EXTERNAL_LANG_AS
			-- Language name
			-- might be replaced by external_declaration or external_definition

	alias_name_id: INTEGER
			-- Alias name ID in NAMES_HEAP.

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and external_keyword_index /= 0 then
				Result := external_keyword (a_list)
			else
				Result := language_name.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				Result := language_name.last_token (a_list)
			else
				if alias_name_literal /= Void then
					Result := alias_name_literal.last_token (a_list)
				else
					Result := language_name.last_token (a_list)
				end
			end
		end

feature -- Properties

	is_external: BOOLEAN = True
			-- Is the current routine body an external one ?

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := alias_name_id = other.alias_name_id and then
				equivalent (language_name, other.language_name)
		end

invariant
	language_name_not_void: language_name /= Void
	alias_name_literal_valid: alias_name_id > 0 implies alias_name_literal /= Void
	alias_name_id_valid: alias_name_literal /= Void implies alias_name_id > 0

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

end -- class EXTERNAL_AS
