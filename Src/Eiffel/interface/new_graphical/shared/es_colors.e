indexing
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

feature -- Prompts

	prompt_sub_title_forground_color: EV_COLOR
			-- Forground color for title text on prompt dialogs
		once
			create Result.make_with_8_bit_rgb (117, 143, 198)
		ensure
			result_attached: Result /= Void
		end

	prompt_text_forground_color: EV_COLOR
			-- Foreground color for all other text on prompt dialog
		once
			create Result.make_with_8_bit_rgb (107, 123, 138)
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

	prompt_sub_title_font: EV_FONT
			-- Font for prompt text
		once
			Result := (create {EV_LABEL}).font
			Result.set_height (14)
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
		ensure
			result_attached: Result /= Void
		end

	prompt_text_font: EV_FONT
			-- Font for prompt sub text
		once
			Result := (create {EV_LABEL}).font
			Result.set_height (12)
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access

	stock_colors: EV_STOCK_COLORS is
			-- EiffelVision2 stock colors
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
