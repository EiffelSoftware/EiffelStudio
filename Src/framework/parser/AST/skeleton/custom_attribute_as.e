note
	description: "Description of a custom attribute."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CUSTOM_ATTRIBUTE_AS

inherit
	ATOMIC_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (c: like creation_expr; t: like tuple; k_as: like end_keyword)
			-- Create a new UNIQUE AST node.
		require
			c_not_void: c /= Void
		do
			creation_expr := c
			tuple := t
			if k_as /= Void then
				end_keyword_index := k_as.index
			end
		ensure
			creation_expr_set: creation_expr = c
			tuple_set: tuple = t
			end_keyword_set: k_as /= Void implies end_keyword_index = k_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_custom_attribute_as (Current)
		end

feature -- Roundtrip

	end_keyword_index: INTEGER
			-- Keyword "end" associated with this structure.

	end_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "end" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, end_keyword_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := creation_expr.index
		end

feature -- Access

	creation_expr: CREATION_EXPR_AS
			-- Creation of Custom attribute.

	tuple: detachable TUPLE_AS
			-- Tuple for addition custom attribute settings.

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := creation_expr.first_token (a_list)
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and end_keyword_index /= 0 then
				Result := end_keyword (a_list)
			elseif attached tuple as l_tuple then
				Result := l_tuple.last_token (a_list)
			else
				Result := creation_expr.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result := creation_expr.is_equivalent (other.creation_expr) and then equivalent (tuple, other.tuple)
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Output

	string_value: STRING = ""

invariant
	creation_expr_not_void: creation_expr /= Void

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
