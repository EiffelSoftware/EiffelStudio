
class NAMER_CMD 

inherit

	WINDOWS
		export
			{NONE} all
		end;

	UNDOABLE;

feature {NONE}

	history: HISTORY_WND is
		once
			Result := history_window;
		end;

	n_ame: STRING is "Set visual name";

	failed: BOOLEAN;

	namable: NAMABLE;

	old_visual_name: STRING;

	work (argument: NAMABLE) is
		do
			namable := argument;
			if 
				namable.visual_name /= Void 
			then	
				old_visual_name := namable.visual_name.duplicate;
			end;
		end;
	
feature 

	undo is
		local
			new_name: STRING;
		do
			new_name := namable.visual_name;
			namable.set_visual_name (old_visual_name);
			old_visual_name := new_name;
			main_panel.namer_hole.reset (namable)
		end;

	redo is
		do
			undo
		end;
	
end
