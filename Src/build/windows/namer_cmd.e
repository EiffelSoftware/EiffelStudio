
class NAMER_CMD 

inherit

	EB_UNDOABLE;

feature {NONE}

	name: STRING is 
		do
			Result := Command_names.set_visual_name_cmd_name
		end; 

	failed: BOOLEAN is 
		do 
		end;

	namable: NAMABLE;

	old_visual_name: STRING;

	old_height, old_width: INTEGER;
			-- Record height and width if it is
			-- a context

	work (vname: STRING) is
		local
			a_context: CONTEXT
		do
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
			namable.set_visual_name (vname);
			namer_window.update_name
		end;
	
feature 

	undo is
		local
			new_name: STRING;
		do
			new_name := namable.visual_name;
			set_visual_name (old_visual_name);
			old_visual_name := new_name;
			if namer_window.namable = namable then
				namer_window.update_name
			end;	
		end;

	redo is
		do
			undo
		end;

	set_visual_name (vname: STRING) is
		local
			a_context: CONTEXT;
			tmp_width, tmp_height: INTEGER
		do
			a_context ?= namable;
			if a_context /= Void then 
				tmp_width := a_context.width;
				tmp_height := a_context.height;
			end;
			namable.set_visual_name (vname);
			if a_context /= Void and then 
				(old_width /= a_context.width or else
				old_height /= a_context.height)
			then
				a_context.set_size (old_width, old_height);
			end
			old_width := tmp_width;
			old_height := tmp_height;
		end
	
end
