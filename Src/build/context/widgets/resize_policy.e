

class RESIZE_POLICY 

inherit


creation

	make

	
feature 

	make is
		do
			x_fixed := True;
			y_fixed := True;
		end;

	context: CONTEXT;
			-- Context for which the resize policy is defined

	
feature {NONE}

	bulletin: EB_BULLETIN;

	
feature 

	follow_x_modified: BOOLEAN;
	follow_y_modified: BOOLEAN;
	resize_width_modified: BOOLEAN;
	resize_height_modified: BOOLEAN;

	x_fixed, y_fixed: BOOLEAN;
	is_width_resizeable, is_height_resizeable: BOOLEAN;

	set_context (a_context: CONTEXT) is
		do
			context := a_context;
			bulletin ?= context.parent.widget;
		end;

	forget_context is
		do
			context := Void;
			bulletin := Void;
		end;

	reset_modified_flags is
		do
			follow_x_modified := False;
			follow_y_modified := False;
			resize_width_modified := False;
			resize_height_modified := False;
		end;

	follow_x (flag: BOOLEAN) is
		local
			drawing_context: DR_AREA_C;
		do
			drawing_context ?= context;
			follow_x_modified := True;
			x_fixed := not flag;
			if drawing_context /= Void then
				bulletin.follow_x (widget.parent, flag);
			else
				bulletin.follow_x (widget, flag);
			end;
		end;

	follow_y (flag: BOOLEAN) is
		local
			drawing_context: DR_AREA_C;
		do
			drawing_context ?= context;
			follow_y_modified := True;
			y_fixed := not flag;
			if drawing_context /= Void then
				bulletin.follow_y (widget.parent, flag);
			else
				bulletin.follow_y (widget, flag);
			end;
		end;

	width_resizeable (flag: BOOLEAN) is
		local
			drawing_context: DR_AREA_C;
		do
			drawing_context ?= context;
			resize_width_modified := True;
			is_width_resizeable := flag;
			if drawing_context /= Void then
				bulletin.width_resizeable (widget.parent, flag);
			else
				bulletin.width_resizeable (widget, flag);
			end;
		end;

	height_resizeable (flag: BOOLEAN) is
		local
			drawing_context: DR_AREA_C;
		do
			drawing_context ?= context;
			resize_height_modified := True;
			is_height_resizeable := flag;
			if drawing_context /= Void then
				bulletin.height_resizeable (widget.parent, flag);
			else
				bulletin.height_resizeable (widget, flag);
			end;
		end;

	
feature {NONE}

	widget: WIDGET is
		local
			opt_pull_c: OPT_PULL_C;
		do
			opt_pull_c ?= context;
			if (opt_pull_c = Void) then
				Result := context.widget
			else
				Result := opt_pull_c.widget.option_button
			end;
		end;

	
feature 

	update is
		do
			bulletin.follow_x (widget, not x_fixed);
			bulletin.follow_y (widget, not y_fixed);
			bulletin.width_resizeable (widget, is_width_resizeable);
			bulletin.height_resizeable (widget, is_height_resizeable);
		end;

	generated_text (bulletin_name: STRING): STRING is
			-- Generate the code for the current context
		do
			!!Result.make (0);
			if follow_x_modified and not x_fixed then
				Result.append (attach_widget (bulletin_name, "follow_x"))
			end;
			if follow_y_modified and not y_fixed then
				Result.append (attach_widget (bulletin_name, "follow_y"))
			end;
			if resize_width_modified and is_width_resizeable then
				Result.append (attach_widget (bulletin_name, "width_resizeable"))
			end;
			if resize_height_modified and is_height_resizeable then
				Result.append (attach_widget (bulletin_name, "height_resizeable"))
			end;
		end;

	
feature {NONE}

	attach_widget (bulletin_name, function_name: STRING): STRING is
		local
			drawa: DR_AREA_C;
		do
			drawa ?= context;
			!!Result.make (0);
			Result.append ("%T%T%T");
			Result.append (bulletin_name);
			Result.append (function_name);
			Result.append (" (");
			Result.append (context.full_name);
			if drawa /= Void then
				Result.append (".parent");
			end;
			Result.append (", True);%N");
		end;

	
feature 

	stored_elmt: S_RESIZE_POLICY is
		do
			!!Result.make (Current)
		end;

end
