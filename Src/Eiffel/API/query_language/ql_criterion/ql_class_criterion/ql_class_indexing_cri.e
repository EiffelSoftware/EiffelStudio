note
	description: "Criterion to test certain condition in an indexing clause"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QL_CLASS_INDEXING_CRI

inherit
	QL_CLASS_CRITERION
		redefine
			is_satisfied_by
		end

	QL_NAME_CRITERION
		redefine
			is_satisfied_by
		end

	SHARED_SERVER

	SHARED_WORKBENCH

	SHARED_EIFFEL_PARSER

feature -- Evaluate

	is_satisfied_by (a_item: QL_CLASS): BOOLEAN
			-- Evaluate `a_item'.
		deferred
		end

feature -- Status report

	require_compiled: BOOLEAN
			-- Does current criterion require a compiled item?
		do
			Result := False
		end

feature{NONE} -- Implementation

	class_ast (a_item: QL_CLASS): CLASS_AS
			-- CLASS_AS of `a_item'.
		require
			a_item_attached: a_item /= Void
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				if a_item.is_compiled then
					Result := a_item.class_c.ast
				else
					roundtrip_eiffel_parser.parse_from_string (a_item.class_i.text, a_item.class_c)
					Result := roundtrip_eiffel_parser.root_node
				end
			end
		rescue
			Result := Void
			l_retried := True
			retry
		end

feature {NONE} -- Internal parsers

	roundtrip_eiffel_parser: EIFFEL_PARSER
			-- Roundtrip parser used to retrieve indexing clause
		do
			if il_parsing then
				Result := roundtrip_il_eiffel_parser
			else
				Result := roundtrip_pure_eiffel_parser
			end
		ensure
			result_attached: Result /= Void
		end

	roundtrip_pure_eiffel_parser: EIFFEL_PARSER
			-- Pure Eiffel parser
		deferred
		ensure
			eiffel_parser_not_void: Result /= Void
			pure_parser: not Result.il_parser
		end

	roundtrip_il_eiffel_parser: EIFFEL_PARSER
			-- IL Eiffel parser.
		deferred
		ensure
			il_eiffel_parser_not_void: Result /= Void
			il_parser: Result.il_parser
		end

	match_list: LEAF_AS_LIST;
			-- Match list of last class parsed by `roundtrip_eiffel_parser'

note
        copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end
