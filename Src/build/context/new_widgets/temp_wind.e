
class TEMP_WIND 


inherit

	EB_BULLETIN
		rename
			make as eb_bulletin_create
		redefine
			show, hide,
			managed, 
			x, y, set_x_y,
			set_x, set_y,
			width, height, set_size,
			set_width, set_height,
			real_x, real_y,
			realize, set_managed
		end


creation

	make

	
feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			!!dialog_shell.make (a_name, a_parent);
			eb_bulletin_create (a_name, dialog_shell);
		end;

	dialog_shell: DIALOG_SHELL;

	title: STRING is
		do
			Result := dialog_shell.title;
		end;

	set_title (a_title: STRING) is
		do
			dialog_shell.set_title (a_title)
		end;

	forbid_resize is
		do
			dialog_shell.forbid_resize
		end;

	allow_resize is
		do
			dialog_shell.allow_resize
		end;

	show is
		do
			dialog_shell.show
		end;

	hide is
		do
			dialog_shell.hide
		end;

	set_managed (flag: BOOLEAN) is
		do
			dialog_shell.set_managed (flag)
		end;

	managed: BOOLEAN is
		do
			Result := dialog_shell.managed
		end;

	x: INTEGER is
		do
			Result := dialog_shell.x
		end;

	y: INTEGER is
		do
			Result := dialog_shell.y
		end;

	real_x: INTEGER is
		do
			Result := dialog_shell.real_x
		end;

	real_y: INTEGER is
		do
			Result := dialog_shell.real_y
		end;

	set_x_y (new_x, new_y: INTEGER) is
		do
			dialog_shell.set_x_y (new_x, new_y);
		end;

	set_x (new_x: INTEGER) is
		do
			dialog_shell.set_x (new_x);
		end;

	set_y (new_y: INTEGER) is
		do
			dialog_shell.set_y (new_y);
		end;

	width: INTEGER is
		do
			Result := dialog_shell.width
		end;

	height: INTEGER is
		do
			Result := dialog_shell.height
		end;

	set_size (new_w, new_h: INTEGER) is
		do
			dialog_shell.set_size (new_w, new_h);
		end;

	set_width (new_w: INTEGER) is
		do
			dialog_shell.set_width (new_w);
		end;

	set_height (new_h: INTEGER) is
		do
			dialog_shell.set_height (new_h);
		end;

	realize is
		do
			dialog_shell.realize
		end;

	popup is
		do
			dialog_shell.popup;
		end;

	popdown is
		do
			dialog_shell.popdown;
		end;

	is_poped_up: BOOLEAN is
		do
			Result := dialog_shell.is_poped_up
		end;

	set_no_grab is
		do
			dialog_shell.set_no_grab
		end;

	set_exclusive_grab is
		do
			dialog_shell.set_exclusive_grab
		end;

	set_cascade_grab is
		do
			dialog_shell.set_cascade_grab
		end;

    is_no_grab: BOOLEAN is
		do
			Result := dialog_shell.is_no_grab
		end;

	is_exclusive_grab: BOOLEAN is
		do
			Result := dialog_shell.is_exclusive_grab
		end;

	is_cascade_grab: BOOLEAN is
		do
			Result := dialog_shell.is_cascade_grab
		end;

end

