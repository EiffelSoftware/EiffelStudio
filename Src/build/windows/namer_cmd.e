
class NAMER_CMD 

inherit

	EB_UNDOABLE;

feature {NONE}

	name: STRING is 
		do
			Result := Command_names.set_visual_name_cmd_name
		end; 

	failed: BOOLEAN;

	namable: NAMABLE;

	old_visual_name: STRING;

	namer_window: NAMER_WINDOW;

	old_height, old_width: INTEGER;
			-- Record height and width if it is
			-- a context

	work (argument: ANY) is
		local
			a_context: CONTEXT
		do
			namer_window ?= argument;
			namable := namer_window.namable;
			if namable.visual_name /= Void then	
				old_visual_name := clone (namable.visual_name);
			end;
				-- To keep same size if it is a context
			a_context ?= namable;
			if a_context /= Void then
				old_width := a_context.width
				old_height := a_context.height
			end
		end;
	
feature 

	undo is
		local
			new_name: STRING;
			a_context: CONTEXT;
			tmp_width, tmp_height: INTEGER
		do
			a_context ?= namable;
			if a_context /= Void then
				tmp_width := a_context.width
				tmp_height := a_context.height
			end
			new_name := namable.visual_name;
			namable.set_visual_name (old_visual_name);
			old_visual_name := new_name;
			if namer_window.namable = namable and then
				namer_window.realized 
			then
				namer_window.update_name
			end;	
			if a_context /= Void and then 
				(tmp_width /= a_context.width or else
				tmp_height /= a_context.height)
			then
				a_context.set_size (old_width, old_height);
				old_width := tmp_width;
				old_height := tmp_height;
			end
		end;

	redo is
		do
			undo
		end;
	
end
