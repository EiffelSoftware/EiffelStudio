indexing
	description: "Context editor hole."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class CON_EDIT_HOLE 

inherit
	EB_BUTTON

creation
	make

feature -- Access

	set_empty_symbol is
		do
			if pixmap /= symbol then
				set_pixmap (symbol)
			end
		end

	set_full_symbol is
		do
			if pixmap /= full_symbol then
				set_pixmap (full_symbol)
			end
		end

feature {NONE} -- Implemantation

--	create_focus_label is
--		do
--			set_focus_string (Focus_labels.context_label)
--		end

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.context_pixmap
		end

	full_symbol: EV_PIXMAP is
		do
			Result := Pixmaps.context_dot_pixmap
		end

end -- class CON_EDIT_HOLE

