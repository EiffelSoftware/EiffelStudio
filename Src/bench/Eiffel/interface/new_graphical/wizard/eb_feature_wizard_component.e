indexing
	description: "Common routines for FCW."
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

	new_text_field (a_text: STRING): EV_TEXT_FIELD is
			-- Create new text field with `a_text'.
		do
			if a_text.is_empty then
				create Result
			else
				create Result.make_with_text (a_text)
			end
			Result.set_minimum_width (50)
		end

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
			Result.set_pixmap (Pixmaps.Icon_new_small @ 1)
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

	Indent_size: INTEGER is 30
			-- Number of pixels used to indent widgets.

end -- class FEATURE_WIZARD_COMPONENT
