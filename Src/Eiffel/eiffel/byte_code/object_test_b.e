indexing
	description: "Byte node for object test."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJECT_TEST_B

inherit
	EXPR_B
		redefine
			allocates_memory,
			assigns_to,
			calls_special_features,
			enlarged,
			has_call,
			has_gcable_variable,
			inlined_byte_code,
			is_unsafe,
			optimized_byte_node,
			pre_inlined_code,
			size
		end

	SHARED_TYPES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Creation

	make (l: like target; e: like expression; i: like info)
		require
			t_attached: l /= Void
			e_attached: e /= Void
		do
			target := l
			expression := e
			info := i
		ensure
			target_set: target = l
			expression_set: expression = e
			info_set: info = i
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_object_test_b (Current)
		end

feature -- Access

	target: OBJECT_TEST_LOCAL_B
			-- Object test local

	expression: EXPR_B
			-- Associated expression

	type: TYPE_A
			-- Expression type
		do
			Result := boolean_type
		end

	info: CREATE_INFO
			-- Additional information about target type

feature -- Status report

	has_gcable_variable: BOOLEAN is
			-- Is the expression using a GCable variable?
		do
			Result := expression.has_gcable_variable
		end

	has_call: BOOLEAN is
			-- Is the expression using a call?
		do
			Result := expression.has_call
		end

	allocates_memory: BOOLEAN is
			-- Does the expression allocate memory?
		do
			Result := expression.allocates_memory or else expression.allocates_memory_for_type (target.type)
		end

feature -- C code generation

	enlarged: OBJECT_TEST_B
			-- Enlarged current node
		do
			create {OBJECT_TEST_BL} Result.make (Current)
		end

	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local or forthcomming dot calls ?
		do
			Result := target.used (r) or else expression.used (r)
		end

feature -- Array optimization

	assigns_to (i: INTEGER_32): BOOLEAN
		do
			Result := target.assigns_to (i)
		end

	calls_special_features (array_desc: INTEGER_32): BOOLEAN
		do
			Result := expression.calls_special_features (array_desc)
		end

	is_unsafe: BOOLEAN
		do
			Result := expression.is_unsafe
		end

	optimized_byte_node: like Current
		do
			Result := Current
			expression := expression.optimized_byte_node
		end

feature -- Inlining

	size: INTEGER_32
		do
				-- Cannot inline at the moment, because the register mapping is not done properly
			Result := 101
		end

	pre_inlined_code: like Current
		do
			Result := Current
			expression := expression.pre_inlined_code
			target ?= target.pre_inlined_code
		end

	inlined_byte_code: like Current
		do
			Result := Current
			expression := expression.inlined_byte_code
		end

invariant
	expression_not_void: expression /= Void
	target_not_void: target /= Void

indexing
	copyright:	"Copyright (c) 2007-2008, Eiffel Software"
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
