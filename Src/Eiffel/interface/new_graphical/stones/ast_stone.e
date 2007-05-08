indexing
	description: "Stone that represents an AST node"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AST_STONE

inherit
	CLASSC_STONE
		rename
			make as make_class_c
		redefine
			stone_cursor,
			x_stone_cursor
		end

create
	make

feature{NONE} -- Initialization

	make (a_class_c: like e_class; a_ast: like ast) is
			-- Initialize `e_class' with `a_class_c' and `ast' with `a_ast'.
		require
			a_class_c_attached: a_class_c /= Void
			a_ast_attached: a_ast /= Void
		do
			make_class_c (a_class_c)
			set_ast (a_ast)
			set_stone_cursor (cursors.cur_object)
			set_x_stone_cursor (cursors.cur_x_object)
		end

feature -- Access

	ast: AST_EIFFEL
			-- AST node associated with Current stone

	stone_cursor: EV_POINTER_STYLE is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := stone_cursor_internal
		ensure then
			good_result: Result = stone_cursor_internal
		end

	x_stone_cursor: EV_POINTER_STYLE is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := x_stone_cursor_internal
		ensure then
			good_result: Result = x_stone_cursor_internal
		end

feature -- Status report

	is_for_feature_invocation: BOOLEAN
			-- Is Current a feature invocation stone?

feature -- Setting

	set_ast (a_ast: like ast) is
			-- Set `ast' with `a_ast'.
		require
			a_ast_attached: a_ast /= Void
		do
			ast := a_ast
		ensure
			ast_set: ast = a_ast
		end

	set_is_for_feature_invocation (b: BOOLEAN) is
			-- Set `is_for_feature_invocation' with `b'.
		do
			is_for_feature_invocation := b
		ensure
			is_for_feature_invocation_set: is_for_feature_invocation = b
		end

	set_stone_cursor (a_cursor: like stone_cursor) is
			-- Set `stone_cursor' with `a_cursor'.
		require
			a_cursor_attached: a_cursor /= Void
		do
			stone_cursor_internal := a_cursor
		ensure
			stone_cursor_set: stone_cursor = a_cursor
		end

	set_x_stone_cursor (a_cursor: like x_stone_cursor) is
			-- Set `x_stone_cursor' with `a_cursor'.
		require
			a_cursor_attached: a_cursor /= Void
		do
			x_stone_cursor_internal := a_cursor
		ensure
			x_stone_cursor_set: x_stone_cursor = a_cursor
		end

feature{NONE} -- Implementation

	stone_cursor_internal: like stone_cursor
			-- Implementation of `stone_cursor'

	x_stone_cursor_internal: like x_stone_cursor
			-- Implementation of `x_stone_cursor'

invariant
	stone_cursor_attached: stone_cursor /= Void
	x_stone_cursor_attached: x_stone_cursor /= Void

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
