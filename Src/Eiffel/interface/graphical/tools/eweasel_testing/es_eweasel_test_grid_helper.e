indexing
	description: "[
					Grid common helper functions used by {ES_TEST_CASE_GRID_MANAGER} and {ES_TEST_RUN_RESULT_GRID_MANAGER}
																													]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EWEASEL_TEST_GRID_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_grid: !EV_GRID)
			-- Creation method
		do
			grid := a_grid
		ensure
			set: grid = a_grid
		end

feature -- Command

	new_editor_token_item (a_class_name: !STRING): !EB_GRID_EDITOR_TOKEN_ITEM is
			-- Create a grid editor token item base on `a_class_name'
		local
			l_class_token: EDITOR_TOKEN_CLASS
			l_util: ES_EWEASEL_TEST_CASE_FINDER
			l_tmp_list: ARRAYED_LIST [EDITOR_TOKEN]
			l_shared_writer: EB_SHARED_WRITER
			l_class_i: CLASS_I
		do
			create Result

			create l_class_token.make (a_class_name)
			create l_tmp_list.make_from_array (<<l_class_token>>)
			Result.set_left_border (4)
			Result.set_text_with_tokens (l_tmp_list)
			create l_shared_writer
			Result.set_overriden_fonts (l_shared_writer.label_font_table, l_shared_writer.label_font_height)

			create l_util
			l_class_i := l_util.class_i_of (a_class_name)

			if l_class_i /= Void then
				l_class_token.set_pebble (create {CLASSI_STONE}.make (l_class_i))
			end
		end

	on_pointer_press (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32) is
			-- Handle `grid' pointer press actions to active {EV_GRID_EDITABLE_ITEM} if possible
		local
			l_x, l_y: INTEGER
			l_header_height: INTEGER
		do
			if a_button = {EV_POINTER_CONSTANTS}.left then
				l_header_height := grid.header.height
				if a_y >= l_header_height then
					l_x := a_x
					l_y := a_y - l_header_height
					if (0 <= l_x and l_x <= grid.virtual_width) and
						(0 <= l_y and l_y <= grid.virtual_height) then

						if {l_edit_grid_item: EV_GRID_EDITABLE_ITEM} grid.item_at_virtual_position (l_x, l_y)  then
							l_edit_grid_item.activate
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	grid: !EV_GRID;
			-- Grid current helping
indexing
	copyright: "Copyright (c) 1984-2008, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
