indexing
	description: "Editor for use by FCW."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_LINE_EDIT

inherit
	EV_TEXT_FIELD

	FEATURE_WIZARD_COMPONENT
		undefine
			default_create, copy
		end

feature -- Access

	line_count: INTEGER is
		do
			if text /= Void and then not text.is_empty then
				Result := 1
			end
		end

	line (i: INTEGER): STRING is
			-- `i'-th line of text.
		require
			i_positive: i > 0
			i_within_bounds: i <= line_count
		do
			Result := text
		end

feature -- Status setting

	disable is
			-- Disable user input and grey out.
		do
			disable_sensitive
		--	set_foreground_color (Color_read_only)
		end

	enable is
			-- Allow user input and reset color.
		do
			enable_sensitive
		--	set_foreground_color (Color_read_write)
		end

end -- class EB_FEATURE_LINE_EDIT
