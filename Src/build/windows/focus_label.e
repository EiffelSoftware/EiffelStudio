class FOCUS_LABEL

inherit

	LABEL
		rename
			make as label_make,
			set_font as label_set_font
		end;
	LABEL
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

feature {NONE}

	make (a_parent: COMPOSITE) is
		local
			label_font: FONT
		do
			label_make (Widget_names.focus_label, a_parent);
			set_center_alignment;
			forbid_recompute_size;
			set_text (" ");
			label_font := Resources.focus_label_font;
			if label_font /= Void then
				label_set_font (label_font)
			end
		end;

	set_font (a_font: FONT) is
		do
		end;

end
