class FOCUS_LABEL

inherit

	LABEL
		rename
			make as label_make
		end;
	CONSTANTS

creation

	make

feature {NONE}

	make (a_parent: COMPOSITE) is
		do
			label_make (Widget_names.focus_label, a_parent);
			set_center_alignment;
			forbid_recompute_size;
			set_text (" ")
		end;

end
