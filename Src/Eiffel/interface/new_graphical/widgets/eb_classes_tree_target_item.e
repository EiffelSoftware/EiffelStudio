indexing
	description: "Target item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASSES_TREE_TARGET_ITEM

inherit
	EB_CLASSES_TREE_ITEM

	TARGET_STONE
		undefine
			default_create, copy, is_equal
		redefine
			make
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like target) is
			-- Create.
		do
			default_create
			target := a_target
			set_text (target.name)
			set_tooltip (target.name)
			set_pixmap (pixmaps.icon_pixmaps.folder_target_icon)
			set_pebble_function (agent stone)
			set_accept_cursor (cursors.cur_target)
			set_deny_cursor (cursors.cur_x_target)
		end

feature -- Access

	stone: TARGET_STONE is
			-- Stone representing `Current'.
		do
			Result := Current
		end

feature {NONE} -- Actions

	double_press_action (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER
						 a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE
						 a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Send a stone corresponding to `Current' to `associated_window'.
		do
			if a_button = 1 and then associated_window /= Void then
				associated_window.set_stone (stone)
			end
		end

feature -- Interactivity

	associate_with_window (a_window: EB_DEVELOPMENT_WINDOW) is
			-- Associate recursively with `a_window' so that we can call `set_stone' on `a_window'.
		local
			l_conv_target: EB_CLASSES_TREE_TARGET_ITEM
		do
			if associated_window = Void then
				pointer_button_press_actions.extend (agent double_press_action)
			end

			associated_window := a_window

			from
				start
			until
				after
			loop
				l_conv_target ?= item
				if l_conv_target /= Void then
					l_conv_target.associate_with_window (a_window)
				end
				forth
			end
		end


feature {NONE} -- Implementation

	associated_window: EB_DEVELOPMENT_WINDOW;
			-- Where should clicked classes set a stone?

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
