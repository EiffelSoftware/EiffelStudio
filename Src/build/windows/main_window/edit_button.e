-- Edit button hole for editable stones.
deferred class EDIT_BUTTON 

inherit

	EB_PICT_B;
	HOLE;
	WINDOWS

feature {NONE}

	focus_label: FOCUS_LABEL;

	make (a_parent: COMPOSITE; label: FOCUS_LABEL) is
		require
			valid_a_parent: a_parent /= Void;
			valid_label: label /= Void
		do
			focus_label := label;
			make_visible (a_parent);
			register
		end;

	target: WIDGET is
		do
			Result := Current;
		end;

	process_stone is
		local
			editable: EDITABLE
		do
			editable ?= stone.original_stone;
			if (editable /= Void) then
				editable.create_editor
			end			
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
