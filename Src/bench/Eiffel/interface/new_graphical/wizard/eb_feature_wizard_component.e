indexing
	description: "Common routines for FCW."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FEATURE_WIZARD_COMPONENT

inherit
	EV_FONT_CONSTANTS

	EV_STOCK_COLORS
		rename
			implementation as stock_colors_imp
		end

	FEATURE_CLAUSE_NAMES

	EB_CONSTANTS

	SHARED_WORKBENCH

feature -- Factory

	new_label (a_text: STRING): EV_LABEL is
			-- Create new label with `a_text'.
		do
			create Result.make_with_text (a_text)
			Result.set_font (fcw_font)
		end

	new_create_button: EV_BUTTON is
			-- Create button with a star.
		do
			create Result
			Result.set_pixmap (pixmaps.small_pixmaps.icon_new)
			Result.set_minimum_size (16, 16)
		end

	new_tab (ind: INTEGER): EV_CELL is
			-- Return container with minimum width.
		do
			create Result
			Result.set_minimum_width ((ind * Indent_size).max (1))
		end

feature -- Defaults

	fcw_font: EV_FONT is
			-- Font for labels.
		once
			create Result
			Result.set_family (family_typewriter)
			Result.set_height (20)
			Result.set_weight (weight_bold)
		end

feature {NONE} -- Implementation

	Indent_size: INTEGER is 30;
			-- Number of pixels used to indent widgets.

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

end -- class FEATURE_WIZARD_COMPONENT
