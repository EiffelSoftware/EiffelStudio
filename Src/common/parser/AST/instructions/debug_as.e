indexing
	description	: "Abstract description of a debug clause. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class DEBUG_AS

inherit
	INSTRUCTION_AS
		redefine
			number_of_breakpoint_slots
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (k: like internal_keys; c: like compound; d_as, e: like end_keyword) is
			-- Create a new DEBUG AST node.
		require
			e_not_void: e /= Void
		local
			l_internal_keys: like internal_keys
		do
			internal_keys := k
			l_internal_keys := internal_keys
			if l_internal_keys /= Void then
				keys := l_internal_keys.meaningful_content
			end
			compound := c
			end_keyword := e
			debug_keyword := d_as
		ensure
			internal_keys_set: internal_keys = k
			compound_set: compound = c
			end_keyword_set: end_keyword = e
			debug_keyword_set: debug_keyword = d_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_debug_as (Current)
		end

feature -- Roundtrip

	debug_keyword: KEYWORD_AS
			-- Keyword "debug" associated with this structure

feature -- Attributes

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound to debug

	keys: EIFFEL_LIST [STRING_AS]
			-- Debug keys

	end_keyword: KEYWORD_AS
			-- Line number where `end' keyword is located

feature -- Roundtrip

	internal_keys: DEBUG_KEY_LIST_AS
			-- Internal debug keys, in which "(" and ")" are stored		

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void then
				if keys /= Void then
					Result := keys.first_token (a_list)
				elseif compound /= Void then
					Result := compound.first_token (a_list)
				else
					Result := end_keyword.first_token (a_list)
				end
			else
				Result := debug_keyword.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := end_keyword.last_token (a_list)
		end

feature -- Access

	number_of_breakpoint_slots: INTEGER is
			-- Number of stop points for AST
		do
			if compound /= Void then
				Result := Result + compound.number_of_breakpoint_slots
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (compound, other.compound) and then
				equivalent (keys, other.keys)
		end

invariant
	end_keyword_not_void: end_keyword /= Void
	keys_correct: (internal_keys /= Void implies keys = internal_keys.meaningful_content) and
				  (internal_keys = Void implies keys = Void)

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

end -- class DEBUG_AS
