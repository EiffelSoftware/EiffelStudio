note
	description: "Completion window positioning following cursor"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CURSOR_COMPLETABLE_POSITIONING

feature -- Access

	cursor_screen_x: INTEGER
			-- Cursor screen x position
		deferred
		end

	cursor_screen_y: INTEGER
			-- Cursor screen y position
		deferred
		end

	use_preferred_height: BOOLEAN
			-- User preferred height?
		deferred
		end

	preferred_height: INTEGER
			-- Preferred height
		deferred
		end

	working_area_height: INTEGER
			-- Height of the working area. Normally current screen.
		deferred
		end

	line_height: INTEGER
			-- Line height
		deferred
		end

feature -- Computation

	calculate_completion_list_x_position: INTEGER
			-- Determine the x position to display the completion list
		local
			l_screen: EV_RECTANGLE
			right_space,
			list_width: INTEGER
			l_y: INTEGER
		do
			Result := cursor_screen_x
			l_y := cursor_screen_y

				-- Current monitor
			l_screen := (create {EV_SCREEN}).monitor_area_from_position (Result, l_y)

				-- Determine how much room there is free on the right of the screen from the cursor position
			right_space := l_screen.right - Result

			list_width := calculate_completion_list_width

			if right_space < list_width then
					-- Shift x pos back so it fits on the screen
				Result := l_screen.right - list_width
			end
			Result := Result.max (l_screen.left)
		end

	calculate_completion_list_y_position: INTEGER
			-- Determine the y position to display the completion list
		local
			l_screen: EV_RECTANGLE
			l_preferred_height,
			upper_space,
			lower_space: INTEGER
			show_below: BOOLEAN
			l_working_area_height: INTEGER
		do
			show_below := True
			Result := cursor_screen_y

				-- Current monitor
			l_screen := (create {EV_SCREEN}).monitor_area_from_position (cursor_screen_x, cursor_screen_y)

			l_working_area_height := working_area_height

			if Result - l_screen.top < ((l_working_area_height / 3) * 2) then
					-- Cursor in upper two thirds of screen
				show_below := True
			else
					-- Cursor in lower third of screen
				show_below := False
			end

			upper_space := Result - l_screen.top
			lower_space := l_screen.bottom - Result - line_height

			if use_preferred_height then
				l_preferred_height := preferred_height

				if show_below and then l_preferred_height > lower_space and then l_preferred_height <= upper_space then
						-- Not enough room to show below, but is enough room to show above, so we will show above
					show_below := False
				elseif not show_below and then l_preferred_height <= lower_space then
						-- Even though we are in the bottom 3rd of the screen we can actually show below because
						-- the saved size fits
					show_below := True
				end

				if show_below and then l_preferred_height > lower_space then
						-- Not enough room to show below so we must resize
					l_preferred_height := lower_space
				elseif not show_below and then l_preferred_height >= upper_space then
						-- Not enough room to show above so we must resize
					l_preferred_height := upper_space
				end
			else
				if show_below then
					l_preferred_height := lower_space
				else
					l_preferred_height := upper_space
				end
			end

			if show_below then
				Result := Result + line_height
			else
				Result := Result - l_preferred_height
			end
		end

	calculate_completion_list_height: INTEGER
			-- Determine the height the completion should list should have
		local
			upper_space,
			lower_space,
			y_pos: INTEGER
			l_screen: EV_RECTANGLE
			show_below: BOOLEAN
		do
			show_below := True
			y_pos := cursor_screen_y
			l_screen := (create {EV_SCREEN}).monitor_area_from_position (cursor_screen_x, y_pos)

			if y_pos - l_screen.top < ((l_screen.height / 3) * 2) then
					-- Cursor in upper two thirds of screen
				show_below := True
			else
					-- Cursor in lower third of screen
				show_below := False
			end

			upper_space := y_pos - l_screen.top
			lower_space := l_screen.bottom - y_pos - line_height

			if use_preferred_height then
				Result := preferred_height

				if show_below and then Result > lower_space and then Result <= upper_space then
						-- Not enough room to show below, but is enough room to show above, so we will show above
					show_below := False
				elseif not show_below and then Result <= lower_space then
						-- Even though we are in the bottom 3rd of the screen we can actually show below because
						-- the saved size fits
					show_below := True
				end

				if show_below and then Result > lower_space then
						-- Not enough room to show below so we must resize
					Result := lower_space
				elseif not show_below and then Result >= upper_space then
						-- Not enough room to show above so we must resize
					Result := upper_space
				end
			else
				if show_below then
					Result := lower_space
				else
					Result := upper_space
				end
			end
		end

	calculate_completion_list_width: INTEGER
			-- Determine the width the completion list should have			
		deferred
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
