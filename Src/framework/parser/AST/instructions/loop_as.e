indexing
	description	: "Abstract description of an Eiffel loop instruction. %
				  %Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class LOOP_AS

inherit
	INSTRUCTION_AS

	ASSERTION_FILTER

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like from_part; i: like invariant_part;
		v: like variant_part; s: like stop;
		c: like compound; e, f_as, i_as, u_as, l_as: like end_keyword) is
			-- Create a new LOOP AST node.
		require
			s_not_void: s /= Void
			e_not_void: e /= Void
		do
			from_part := f
			full_invariant_list := i
			invariant_part := filter_tagged_list (full_invariant_list)
			variant_part := v
			stop := s
			compound := c
			end_keyword := e
			if f_as /= Void then
				from_keyword_index := f_as.index
			end
			if i_as /= Void then
				invariant_keyword_index := i_as.index
			end
			if u_as /= Void then
				until_keyword_index := u_as.index
			end
			if l_as /= Void then
				loop_keyword_index := l_as.index
			end
		ensure
			from_part_set: from_part = f
			full_invariant_list_set: full_invariant_list = i
			variant_part_set: variant_part = v
			stop_set: stop = s
			compound_set: compound = c
			end_keyword_set: end_keyword = e
			from_keyword_set: f_as /= Void implies from_keyword_index = f_as.index
			invariant_keyword_set: i_as /= Void implies invariant_keyword_index = i_as.index
			until_keyword_set: u_as /= Void implies until_keyword_index = u_as.index
			loop_keyword_set: l_as /= Void implies loop_keyword_index = l_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_loop_as (Current)
		end

feature -- Roundtrip

	full_invariant_list: like invariant_part
			-- Invariant assertion list that contains both complete and incomplete assertions.
			-- e.g. "tag:expr", "tag:", "expr"

	from_keyword_index, invariant_keyword_index, until_keyword_index, loop_keyword_index: INTEGER
			-- Index of keyword "from", "invariant", "until" and "loop" associated with this structure

	from_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "from" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := from_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	invariant_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "invariant" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := invariant_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	until_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "until"  associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := until_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	loop_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS is
			-- Keyword "loop" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := loop_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Attributes

	from_part: EIFFEL_LIST [INSTRUCTION_AS]
			-- from compound

	invariant_part: EIFFEL_LIST [TAGGED_AS]
			-- invariant list

	variant_part: VARIANT_AS
			-- Variant list

	stop: EXPR_AS
			-- Stop test

	compound: EIFFEL_LIST [INSTRUCTION_AS]
			-- Loop compound

	end_keyword: KEYWORD_AS
			-- Line number where `end' keyword is located

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and from_keyword_index /= 0 then
				Result := from_keyword (a_list)
			elseif from_part /= Void then
				Result := from_part.first_token (a_list)
			elseif a_list /= Void and invariant_keyword_index /= 0 then
				Result := invariant_keyword (a_list)
			elseif invariant_part /= Void then
				Result := invariant_part.first_token (a_list)
			elseif variant_part /= Void then
				Result := variant_part.first_token (a_list)
			elseif a_list /= Void and until_keyword_index /= 0 then
				Result := until_keyword (a_list)
			else
				Result := stop.first_token (a_list)
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
			Result := equivalent (compound, other.compound) and then
				equivalent (from_part, other.from_part) and then
				equivalent (invariant_part, other.invariant_part) and then
				equivalent (stop, other.stop) and then
				equivalent (variant_part, other.variant_part)
		end

invariant
	stop_not_void: stop /= Void

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

end -- class LOOP_AS
