class WIN_CONFIG_CMD

inherit 
	UNDOABLE;

	WINDOWS;

	EDITOR_FORMS;

creation

	make

feature

	context: WINDOW_C;

	make (a_context: WINDOW_C) is
		do
			context := a_context;
 			gold_x := context.old_x;
     			gold_y := context.old_y;
     			gold_width := context.old_width;
     			gold_height := context.old_height;
		end;

 
 	work (argument: Like Current) is
  		local
  	 		ed: CONTEXT_EDITOR;
   			gform: GEOMETRY_FORM;
  		do
    			ed := context_catalog.editor (context, geometry_form_number);
    			if ed /= Void then
     				gform ?= ed.current_form;
     				ed.current_form.reset_form;
    			end;
  	end;

 	failed: BOOLEAN;

 	gold_x, gold_y, gold_width, gold_height: INTEGER;

 	undo is
  		local
  	 		ed: CONTEXT_EDITOR;
   			temp_int: INTEGER;
   			temp_int1: INTEGER;
  		do
			context.remove_window_geometry_action;
   			if context.widget.x /= gold_x or 
			  context.widget.y /= gold_y 
			then
    				temp_int := context.widget.x;
    				temp_int1 := context.widget.y;
    				context.widget.set_x_y (gold_x, gold_y);
    				gold_x := temp_int;
    				gold_y := temp_int1;
   			end;
   			if context.widget.height /= gold_height or
			  context.widget.width /= gold_width
  			then
    				temp_int := context.widget.width;
    				temp_int1 := context.widget.height;
    				context.widget.set_size (gold_width, gold_height);
    				gold_height := temp_int1;
    				gold_width := temp_int;
   			end;
			context.add_window_geometry_action;
    			ed := context_catalog.editor (context, geometry_form_number);
    			if ed /= Void then
     				ed.current_form.reset_form;
    			end;
  	end;

 	redo is do undo end;

 	n_ame: STRING is
  		do
   			!!Result.make (0);
   			Result.append("geometry");
   			Result.append (" (");
   			if context.label /= Void then
    				Result.append (context.label);
   			else
    				Result.append (" ");
   			end;
   			Result.append (")");
 	 	end;

 history: HISTORY_WND is
        once
            Result := history_window;
        end;


end
