indexing

	description: "Focus label which updates the text field%
			%on a focusable object";
	date: "$Date$";
	revision: "$Revision $"

class CASE_FOCUS_LABEL

inherit

	EV_LABEL
		rename
			make as label_make,
			set_font as label_set_font
		end;
	EV_LABEL
		rename
			make as label_make
		redefine
			set_font
		select
			set_font
		end;
	CONSTANTS

creation

	make

feature {NONE} -- Initialization

	make (a_parent: EV_CONTAINER) is
			-- Initialize Current with `a_parent'.
		local
			label_font: EV_FONT
		do
			label_make (a_parent);
			set_center_alignment;
		--	forbid_recompute_size;
			set_text (" ");
		--	label_font := Resources.focus_label_font;
		--	if label_font /= Void then
		--		label_set_font (label_font)
		--	end
		end;

	set_font (a_font: EV_FONT) is
			-- Do nothing.
		do
		end;

end -- class CASE_FOCUS_LABEL
