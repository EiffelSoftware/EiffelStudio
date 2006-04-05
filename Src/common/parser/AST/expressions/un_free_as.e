indexing
	description: "Free unary expression description. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class UN_FREE_AS

inherit
	UNARY_AS
		rename
			initialize as initialize_unary_as
		redefine
			is_equivalent, prefix_feature_name
		end

	PREFIX_INFIX_NAMES

create
	initialize

feature {NONE} -- Initialization

	initialize (op: like op_name; e: like expr) is
			-- Create a new UN_FREE AST node.
		require
			op_not_void: op /= Void
			e_not_void: e /= Void
		do
			op_name := op
			expr := e
		ensure
			op_name_set: op_name = op
			expr_set: expr = e
		end

feature -- Attributes

	op_name: ID_AS
			-- Operator name

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_un_free_as (Current)
		end

feature -- Properties

	prefix_feature_name: STRING is
			-- Internal name
		do
			Result := prefix_feature_name_with_symbol (op_name)
		end

	operator_name: STRING is
		do
			Result := op_name
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (op_name, other.op_name) and then
				equivalent (expr, other.expr)
		end

feature {UNARY_AS}	-- Replication

	set_prefix_feature_name (p: like prefix_feature_name) is
		do
			create op_name.initialize (extract_symbol_from_prefix (p))
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

end -- class UN_FREE_AS
