﻿note
	legal: "See notice at end of class."
	status: "See notice at end of class."

class UN_OLD_B

inherit

	UNARY_B
		redefine
			type, enlarged,
			is_unsafe, optimized_byte_node,
			pre_inlined_code, inlined_byte_code
		end

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_un_old_b (Current)
		end

feature

	position: INTEGER
			-- Position of old in local declaration.
			--| The old expression will be held in the local
			--| registers of the interpreter, that is, the old
			--| old expression value will be stored in local
			--| according to `position'. So when the old expression
			--! will be interpretered, the interpreter will retrieve
			--| the value from the local register.

	set_position (i: INTEGER)
			-- Assign `i' to position
		do
			position := i
		end

	exception_position: INTEGER
			-- Position of saved exception object in local declaration.

	set_exception_position (i: INTEGER)
			-- Assign `i' to `exception_position'
		do
			exception_position := i
		end

	type: TYPE_A
			-- Type of the expression
		do
			Result := expr.type
		end

	exception_type: TYPE_A
			-- Type of the saved exception
		once
			if system.il_generation then
				Result := system.system_exception_type_class.compiled_class.types.first.type
			else
				Result := system.any_type
			end
		end

	enlarged: UN_OLD_BL
		require else
			valid_old_exprs: Context.byte_code.old_expressions /= Void
		do
			create Result
			Result.set_expr (expr.enlarged)
			Context.byte_code.old_expressions.extend (Result)
		end

feature -- Optimization for old expressions

	is_exception_block_needed: BOOLEAN
			-- Is exception block needed?
			-- An old expression can raise an exception, then an exception block is used to catch and to record it for future use.
			-- However if exceptions cannot be raised by the particular expression, there is no need to do that.
		do
			Result := expr.is_exception_possible or else expr.allocates_memory_for_type (context.real_type (type))
		end

feature -- Array optimization

	is_unsafe: BOOLEAN
		do
			Result := expr.is_unsafe
		end

	optimized_byte_node: like Current
		do
			Result := Current
			expr := expr.optimized_byte_node
		end

feature -- Inlining

	pre_inlined_code: like Current
		do
			Result := Current
			expr := expr.pre_inlined_code
		end

	inlined_byte_code: like Current
		do
			Result := Current
			expr := expr.inlined_byte_code
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
