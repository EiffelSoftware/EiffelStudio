-- Edit button hole for editable stones.
deferred class EDIT_BUTTON 

inherit

	EB_BUTTON_COM;
	HOLE;
	WINDOWS

feature {NONE}

	focus_label: FOCUS_LABEL;

	make (a_parent: COMPOSITE; label: like focus_label) is
		require
			valid_a_parent: a_parent /= Void;
			valid_label: label /= Void
		do
			make_visible (a_parent);
			focus_label := label;
			register
		end;

	target: WIDGET is
		do
			Result := Current;
		end;

	execute (arg: ANY) is
		do
			if main_panel.project_initialized then
				create_empty_editor
			end
		end;	

	create_empty_editor is
		deferred
		end;

end
