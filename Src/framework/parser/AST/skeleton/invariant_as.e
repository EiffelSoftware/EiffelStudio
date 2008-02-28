indexing

	description: "Description of class invariant. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INVARIANT_AS

inherit
	AST_EIFFEL

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		end

	ASSERTION_FILTER

create
	initialize

feature {NONE} -- Initialization

	initialize (a: like assertion_list; oms_count: like once_manifest_string_count; i_as: like invariant_keyword; ot_locals: like object_test_locals) is
			-- Create a new INVARIANT AST node.
		require
			valid_oms_count: oms_count >= 0
		do
			full_assertion_list := a
			assertion_list := filter_tagged_list (full_assertion_list)
			once_manifest_string_count := oms_count
			if i_as /= Void then
				invariant_keyword_index := i_as.index
			end
			object_test_locals := ot_locals
		ensure
			full_assertion_list_set: full_assertion_list = a
			once_manifest_string_count_set: once_manifest_string_count = oms_count
			invariant_keyword_set: i_as /= Void implies invariant_keyword_index = i_as.index
			object_test_locals_set: object_test_locals = ot_locals
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_invariant_as (Current)
		end

feature -- Roundtrip

	full_assertion_list: like assertion_list
			-- Assertion list that contains both complete and incomplete assertions.
			-- e.g. "tag:expr", "tag:", "expr"

	invariant_keyword_index: INTEGER
			-- Index of keyword "invariant" associated with this structure

	invariant_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
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

feature -- Attribute

	assertion_list: EIFFEL_LIST [TAGGED_AS]
			-- Assertion list

	once_manifest_string_count: INTEGER
			-- Number of once manifest strings

	object_test_locals: ARRAYED_LIST [TUPLE [ID_AS, TYPE_AS]]
			-- Object test locals declared in the invariant

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list /= Void and invariant_keyword_index /= 0 then
				Result := invariant_keyword (a_list)
			elseif full_assertion_list /= Void then
				Result := full_assertion_list.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if full_assertion_list /= Void then
				Result := full_assertion_list.last_token (a_list)
			elseif a_list /= Void and invariant_keyword_index /= 0 then
				Result := invariant_keyword (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
				-- FIXME: optimize (order doesn't matter)
			Result := equivalent (assertion_list, other.assertion_list)
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

end -- class INVARIANT_AS
