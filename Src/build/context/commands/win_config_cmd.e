class WIN_CONFIG_CMD

inherit 

	EB_UNDOABLE;
	CONSTANTS

creation

	make

feature

	context: WINDOW_C;

	failed: BOOLEAN is do end;

	make (a_context: WINDOW_C) is
		do
			context := a_context;
 			old_x := context.old_x;
	 		old_y := context.old_y;
	 		old_width := context.old_width;
	 		old_height := context.old_height;
		end;
 
 	work (argument: Like Current) is
  		local
  	 		ed: CONTEXT_EDITOR;
   			form: GEOMETRY_FORM;
  		do
			ed := context_catalog.editor (context, Context_const.geometry_form_nbr);
			if ed /= Void then
 				form ?= ed.current_form;
 				ed.current_form.reset;
			end;
  		end;

 	old_x, old_y, old_width, old_height: INTEGER;
		-- Old values

 	undo is
  		local
  	 		ed: CONTEXT_EDITOR;
   			temp_int: INTEGER;
   			temp_int1: INTEGER;
  		do
   			if context.x /= old_x or 
				context.y /= old_y 
			then
				temp_int := context.x;
				temp_int1 := context.y;
				context.set_x_y (old_x, old_y);
				old_x := temp_int;
				old_y := temp_int1;
   			end;
   			if context.height /= old_height or
			  context.width /= old_width
  			then
				temp_int := context.width;
				temp_int1 := context.height;
				context.set_size (old_width, old_height);
				old_height := temp_int1;
				old_width := temp_int;
   			end
			ed := context_catalog.editor (context, Context_const.geometry_form_nbr);
			if ed /= Void then
	 			ed.current_form.reset;
			end;
  		end;

 	redo is 
		do 
			undo 
		end;

 	name: STRING is
  		do
   			!!Result.make (0);
   			Result.append (Command_names.cont_geometry_cmd_name);
   			Result.append (" (");
   			if context.label /= Void then
				Result.append (context.label);
   			else
				Result.append (" ");
   			end;
   			Result.append (")");
 	 	end;

end
