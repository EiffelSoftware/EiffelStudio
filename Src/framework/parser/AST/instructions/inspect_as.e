indexing
	description	: "Abstract description of a multi_branch instruction, %
				  %Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class INSPECT_AS

inherit
	INSTRUCTION_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (s: like switch; c: like case_list; e: like else_part; el, i_as, e_as: like end_keyword) is
			-- Create a new INSPECT AST node.
		require
			s_not_void: s /= Void
			el_not_void: el /= Void
		do
			switch := s
			case_list := c
			else_part := e
			end_keyword := el
			if i_as /= Void then
				inspect_keyword_index := i_as.index
			end
			if e_as /= Void then
				else_keyword_index := e_as.index
			end
		ensure
			switch_set: switch = s
			case_list_set: case_list = c
			else_part_set: else_part = e
			end_keyword_set: end_keyword = el
			inspect_keyword_set: i_as /= Void implies inspect_keyword_index = i_as.index
			else_keyword_set: e_as /= Void implies else_keyword_index = e_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_inspect_as (Current)
		end

feature -- Roundtrip

	inspect_keyword_index, else_keyword_index: INTEGER
			-- Index of keyword "inspect" and "else" associated with this structure

	inspect_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "inspect" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := inspect_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	else_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "else" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := else_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Attributes

	switch: EXPR_AS
			-- Expression to inspect

	case_list: EIFFEL_LIST [CASE_AS]
			-- Alternatives

	else_part: EIFFEL_LIST [INSTRUCTION_AS]
			-- Else part

	end_keyword: KEYWORD_AS
			-- Line number where `end' keyword is located

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and inspect_keyword_index /= 0 then
				Result := inspect_keyword (a_list)
			else
				Result := switch.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := end_keyword.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (case_list, other.case_list) and then
				equivalent (else_part, other.else_part) and then
				equivalent (switch, other.switch)
		end

invariant
	switch_not_void: switch /= Void
	end_keyword_not_void: end_keyword /= Void

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

end -- class INSPECT_AS
