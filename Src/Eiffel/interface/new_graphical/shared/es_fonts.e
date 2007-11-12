indexing
	description: "[
		All EiffelStudio predefine user interface fonts.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ES_FONTS

feature -- General fonts

	standard_label_font: EV_FONT
			-- Access to standard widget font
		once
			Result := (create {EV_LABEL}).font
		ensure
			result_attached: Result /= Void
		end

	highlighted_label_font: EV_FONT
			-- Access to standard widget font with highlighting
		once
			Result := standard_label_font.twin
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
		ensure
			result_attached: Result /= Void
		end

feature -- Prompts

	prompt_sub_title_font: EV_FONT
			-- Font for prompt text
		once
			Result := standard_label_font.twin
			Result.set_height (Result.height + 3)
			Result.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
		ensure
			result_attached: Result /= Void
		end

	prompt_text_font: EV_FONT
			-- Font for prompt sub text
		once
			Result := standard_label_font.twin
			--if {PLATFORM}.is_windows then
					-- This cause a problem on Unix machines where is sets the font too small.
				Result.set_height (Result.height + 1)
			--end
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
