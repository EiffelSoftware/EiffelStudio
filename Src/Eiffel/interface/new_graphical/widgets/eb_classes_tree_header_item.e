note
	description: "Header item that is used to group clusters, assemblies, libraries, overrides."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASSES_TREE_HEADER_ITEM

inherit
	EB_CLASSES_TREE_ITEM
		redefine
			print_name
		end

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING_GENERAL; an_icon: EV_PIXMAP)
			-- Create a header with `a_name' and `an_icon'.
		do
			default_create
			set_text (a_name)
			set_tooltip (a_name)
			set_accept_cursor (cursors.cur_cluster)
			set_deny_cursor (cursors.cur_x_cluster)
			set_pixmap (an_icon)
			associated_pixmap := an_icon
			pointer_button_press_actions.extend (agent register_pressed_item)
		end

feature -- Access

	stone: STONE
			-- No stones for headers.
		do
		end

feature {NONE} -- Implementation

	print_name
			-- <Precursor>
		do
			if associated_textable /= Void then
				associated_textable.set_text ("")
				associated_textable.set_data (Void)
			end
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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
