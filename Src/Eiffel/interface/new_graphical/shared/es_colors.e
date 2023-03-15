note
	description: "[
		All EiffelStudio predefine user interface colors.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_COLORS

feature -- Access

	frozen stock_colors: EV_STOCK_COLORS
			-- Access to a shared instance of {EV_STOCK_COLORS}
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature -- General colors

	high_priority_foreground_color: EV_COLOR
			-- High priority item foreground text color
		once
			Result := stock_colors.red
		ensure
			result_attached: Result /= Void
		end

	normal_priority_foreground_color: EV_COLOR
			-- Normal priority item foreground text color
		once
			Result := stock_colors.black
		ensure
			result_attached: Result /= Void
		end

	low_priority_foreground_color: EV_COLOR
			-- Low priority item foreground text color
		once
			Result := stock_colors.gray
		ensure
			result_attached: Result /= Void
		end

	disabled_foreground_color: EV_COLOR
			-- Color for disabled text
		once
			Result := stock_colors.gray
		ensure
			result_attached: Result /= Void
		end

feature -- Grids

	grid_line_color: EV_COLOR
			-- Grid widget selection color when focused
		once
			Result := stock_colors.color_3d_face
		ensure
			result_attached: Result /= Void
		end

	grid_focus_selection_color: EV_COLOR
			-- Grid widget selection color when focused
		once
			Result := (create {EV_GRID}).focused_selection_color
		ensure
			result_attached: Result /= Void
		end

	grid_unfocus_selection_color: EV_COLOR
			-- Grid widget text selection color when focus is else where
		once
			Result := (create {EV_GRID}).non_focused_selection_color
		ensure
			result_attached: Result /= Void
		end

	grid_focus_selection_text_color: EV_COLOR
			-- Grid widget selection color when focused
		once
			Result := (create {EV_GRID}).focused_selection_text_color
		ensure
			result_attached: Result /= Void
		end

	grid_unfocus_selection_text_color: EV_COLOR
			-- Grid widget text selection color when focus is else where
		once
			Result := (create {EV_GRID}).non_focused_selection_text_color
		ensure
			result_attached: Result /= Void
		end

	grid_item_text_color: EV_COLOR
			-- Grid item foreground text color
		once
			Result := stock_colors.black
		ensure
			result_attached: Result /= Void
		end

	grid_disabled_item_text_color: EV_COLOR
			-- Grid item default disable text color
		once
			Result := stock_colors.color_read_only
		ensure
			result_attached: Result /= Void
		end

	grid_editor_token_choice_selected_background_color: EV_COLOR
			-- Editor token choice selected background color
		once
			create Result.make_with_8_bit_rgb (194, 216, 255)
		ensure
			result_attached: Result /= Void
		end

feature -- Prompts

	prompt_sub_title_foreground_color: EV_COLOR
			-- Foreground color for title text on prompt dialogs
		once
			if {PLATFORM}.is_windows then
				create Result.make_with_8_bit_rgb (117, 143, 198)
			else
				create Result.make_with_8_bit_rgb (97, 123, 178)
			end
		ensure
			result_attached: Result /= Void
		end

	prompt_text_foreground_color: EV_COLOR
			-- Foreground color for all other text on prompt dialog
		once
			if {PLATFORM}.is_windows then
				create Result.make_with_8_bit_rgb (107, 123, 138)
			else
				create Result.make_with_8_bit_rgb (77, 93, 108)
			end
		ensure
			result_attached: Result /= Void
		end

	prompt_banner_color: EV_COLOR
			-- Background banner color for prompt dialogs
		once
			create Result.make_with_8_bit_rgb (255, 255, 255)
		ensure
			result_attached: Result /= Void
		end

feature -- Tool tip

	tooltip_color: EV_COLOR
			-- Background color for tool tip windows
		once
			Result := (create {EVS_TOOLTIP_STYLE}.make).tooltip_background_color
		ensure
			result_attached: Result /= Void
		end

;note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
