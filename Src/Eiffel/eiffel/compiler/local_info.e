note
	description: "Information about a local variable of a feature, including object test locals, iteration cursors, etc."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LOCAL_INFO

create
	make

feature {NONE} -- Creation

	make (t: like type; p: like position)
			-- Initialize a local.
		require
			type_attached: attached t
		do
			type := t
			position := p
		ensure
			type_set: type = t
			position_set: position = p
		end

feature -- Access

	position: INTEGER
			-- Position of the local in the sequence of local
			-- declarations

	type: TYPE_A
			-- Local type

	is_used: BOOLEAN
			-- Is local variable used?
			-- Set during type checking.
		do
			Result := flags.bit_test (is_used_position)
		end

	is_controlled: BOOLEAN
			-- Is variable controlled?
		do
			Result := flags.bit_test (is_controlled_position)
		end

	is_cursor: BOOLEAN
			-- Is this an iteration cursor variable?
		do
			Result := flags.bit_test (is_cursor_position)
		end

	expression: detachable EXPR_AS
			-- An expression that should be used instead of variable.

feature -- Setting

	set_type (t: TYPE_A)
			-- Assign `t' to `type'.
		do
			type := t
		end

	enable_is_used
			-- Flag the local as used.
		do
			flags := flags | is_used_flag
		ensure
			is_used: is_used
		end

	set_is_controlled (v: BOOLEAN)
			-- Set `is_controlled' to `v'.
			-- See also `enable_is_controlled`.
		do
			if v then
				flags := flags | is_controlled_flag
			else
				flags := flags & is_controlled_flag.bit_not
			end
		ensure
			is_controlled_set: is_controlled = v
		end

	enable_is_controlled
			-- Flag the local as controlled.
			-- See also `set_is_controlled`.
		do
			flags := flags | is_controlled_flag
		ensure
			is_controlled: is_controlled
		end

	enable_is_cursor
			-- Flag the local as a cursor.
			-- See also `disable_is_cursor`, `set_cursor`.
		require
			has_expression: attached expression
		do
			flags := flags | is_cursor_flag
		ensure
			is_cursor: is_cursor
		end

	disable_is_cursor
			-- Flag the local as not a cursor.
			-- See also `enable_is_cursor`, `set_cursor`.
		require
			has_expression: attached expression
		do
			flags := flags & is_cursor_flag.bit_not
		ensure
			not_is_cursor: not is_cursor
		end

	set_cursor (e: EXPR_AS)
			-- Associate an expression `e` with the current variable.
			-- When the variable is used, it is semantically equivalent to the use of the expression.
			-- See also `enable_is_cursor`, `disable_is_cursor`.
		require
			not_has_expression: not attached expression
		do
			expression := e
			enable_is_cursor
		ensure
			is_cursor: is_cursor
		end

feature {NONE}  -- Storage

	flags: NATURAL_8
			-- Flags associated with the local.

	is_used_position: INTEGER = 0
			-- A position of a flag to store information for `is_used`.
			-- See also: `is_used_flag`.

	is_controlled_position: INTEGER = 1
			-- A position of a flag to store information for `is_controlled`.
			-- See also: `is_controlled_flag`.

	is_cursor_position: INTEGER = 2
			-- A position of a flag to store information for `is_cursor`.
			-- See also: `is_cursor_flag`.

	is_used_flag: NATURAL_8 = 0x01
			-- A flag to store information for `is_used`.
			-- See also: `is_used_position`.

	is_controlled_flag: NATURAL_8 = 0x02
			-- A flag to store information for `is_controlled`.
			-- See also: `is_controlled_position`.

	is_cursor_flag: NATURAL_8 = 0x04
			-- A flag to store information for `is_cursor`.
			-- See also: `is_cursor_position`.

invariant
	type_attached: attached type
	has_expression_if_cursor: is_cursor implies attached expression
	consistent_is_used_flag: is_used_flag = {NATURAL_8} 1 |<< is_used_position
	consistent_is_controlled_flag: is_controlled_flag = {NATURAL_8} 1 |<< is_controlled_position
	consistent_is_cursor_flag: is_used_flag = {NATURAL_8} 1 |<< is_cursor_position

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
