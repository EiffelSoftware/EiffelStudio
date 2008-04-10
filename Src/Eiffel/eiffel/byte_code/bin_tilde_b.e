indexing
	description: "Node for ~ equality operator"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class BIN_TILDE_B

inherit
	BINARY_B
		redefine
			allocates_memory,
			is_type_fixed,
			is_commutative, type, enlarged,
			is_unsafe, optimized_byte_node,
			calls_special_features, pre_inlined_code, inlined_byte_code
		end

	SHARED_TYPE_I
		export
			{NONE} all
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_bin_tilde_b (Current)
		end

feature -- Status report

	is_built_in: BOOLEAN is True
			-- Is the current binary operator a built-in one ?

	is_commutative: BOOLEAN is True
			-- Operation is commutative.

	is_type_fixed: BOOLEAN is True
			-- Is type of the expression statically fixed,
			-- so that there is no variation at run-time?

feature -- Access

	type: TYPE_A is
			-- Expression type is boolean
		do
			Result := Boolean_type
		end

	allocates_memory: BOOLEAN is
			-- Does the expression allocates memory ?
		local
			left_type: TYPE_A
			right_type: TYPE_A
		do
			left_type := context.real_type (left.type)
			right_type := context.real_type (right.type)
			Result := Precursor or else
				(left_type.is_basic and not (right_type.is_none or right_type.is_basic)) or else
				(right_type.is_basic and not (left_type.is_none or left_type.is_basic))
		end

	enlarged: EXPR_B is
			-- <Precursor>
		do
			create {BIN_TILDE_BL} Result.make (left.enlarged, right.enlarged)
		end

feature -- Array optimization

	is_unsafe: BOOLEAN is
		do
			Result := right.is_unsafe or else left.is_unsafe
		end

	optimized_byte_node: EXPR_B is
		do
			Result := Current
			left := left.optimized_byte_node
			right := right.optimized_byte_node
		end

	calls_special_features (array_desc: INTEGER): BOOLEAN is
		do
			Result := left.calls_special_features (array_desc)
				or else right.calls_special_features (array_desc)
		end

feature -- Inlining

	pre_inlined_code: like Current is
		do
			Result := Current
			left := left.pre_inlined_code
			right := right.pre_inlined_code
		end

	inlined_byte_code: like Current is
		do
			Result := Current
			left := left.inlined_byte_code
			right := right.inlined_byte_code
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

end
