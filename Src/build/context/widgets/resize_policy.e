

class RESIZE_POLICY 

feature 

	context: CONTEXT;
			-- Context for which the resize policy is defined

feature 

	follow_x_modified: BOOLEAN;
	follow_y_modified: BOOLEAN;
	resize_width_modified: BOOLEAN;
	resize_height_modified: BOOLEAN;

	to_follow_x, to_follow_y: BOOLEAN;
	is_width_resizeable, is_height_resizeable: BOOLEAN;

	set_context (a_context: CONTEXT) is
		do
			context := a_context;
		end;

	forget_context is
		do
			context := Void;
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
			bulletin: SCALABLE;
		do
			follow_x_modified := True;
			to_follow_x := flag;
			bulletin ?= context.parent.widget;
			if bulletin /= Void then
				bulletin.follow_x (widget, flag);
			end
		end;

	follow_y (flag: BOOLEAN) is
		local
			bulletin: SCALABLE;
		do
			follow_y_modified := True;
			to_follow_y := flag;
			bulletin ?= context.parent.widget;
			if bulletin /= Void then
				bulletin.follow_y (widget, flag);
			end
		end;

	width_resizeable (flag: BOOLEAN) is
		local
			bulletin: SCALABLE;
		do
			resize_width_modified := True;
			is_width_resizeable := flag;
			bulletin ?= context.parent.widget;
			if bulletin /= Void then
				bulletin.width_resizeable (widget, flag);
			end
		end;

	height_resizeable (flag: BOOLEAN) is
		local
			bulletin: SCALABLE;
		do
			resize_height_modified := True;
			is_height_resizeable := flag;
			bulletin ?= context.parent.widget;
			if bulletin /= Void then
				bulletin.height_resizeable (widget, flag);
			end
		end;

	
feature {NONE}

	widget: WIDGET is
		local
			opt_pull_c: OPT_PULL_C;
			drawa: DR_AREA_C;
		do
			opt_pull_c ?= context;
			drawa ?= context;
			if (opt_pull_c /= Void) then
				Result := opt_pull_c.widget.option_button
			elseif (drawa /= Void) then
				Result := drawa.widget.parent
			else
				Result := context.widget
			end;
		end;

	
feature 

	update is
		local
			bulletin: SCALABLE;
		do
			bulletin ?= context.parent.widget;
			if bulletin /= Void then
				bulletin.follow_x (widget, to_follow_x);
				bulletin.follow_y (widget, to_follow_y);
				bulletin.width_resizeable (widget, is_width_resizeable);
				bulletin.height_resizeable (widget, is_height_resizeable);
			end
		end;

	has_resizing_policy: BOOLEAN is
		do
			Result := to_follow_x or else 
				to_follow_y or else 
				is_width_resizeable or else
				is_height_resizeable
		end;

	generated_text (bulletin_name: STRING): STRING is
			-- Generate the code for the current context
		local
			drawa: DR_AREA_C;
		do
			!!Result.make (0);
			if has_resizing_policy then
				drawa ?= context;
				!!Result.make (0);
				Result.append ("%T%T%T");
				Result.append (bulletin_name);
				Result.append ("record_resize_policy (");
				Result.append (context.full_name);
				if drawa /= Void then
					Result.append (".parent");
				end;
				Result.append (",%N%T%T%T%T");
				Result.append_boolean (to_follow_x);
				Result.append (", ");
				Result.append_boolean (to_follow_y);
				Result.append (", ");
				Result.append_boolean (is_width_resizeable);
				Result.append (", ");
				Result.append_boolean (is_height_resizeable);
				Result.append (");%N");
			end
		end;

	
feature 

	stored_elmt: S_RESIZE_POLICY is
		do
			!!Result.make (Current)
		end;

end
