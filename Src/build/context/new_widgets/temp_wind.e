
class TEMP_WIND 


inherit

	EB_BULLETIN
		rename
			make as eb_bulletin_create
		redefine
			width, height,
			--set_x_y, set_x, set_y,
			x, y --, set_size
		end;

	EB_BULLETIN
		redefine
			make, width, height,
			--set_x_y, set_x, set_y,
			x, y --, set_size
		select
			make
		end;


creation

	make

	
feature 

	make (a_name: STRING; a_parent: COMPOSITE) is
		do
			!!dialog_shell.make (a_name, a_parent);
			eb_bulletin_create (a_name, dialog_shell);
			popdown;
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

	--set_size (new_width, new_height: INTEGER) is
		--do
			--dialog_shell.set_size (new_width, new_height);
		--end;

	--set_x_y (new_x, new_y: INTEGER) is
		--do
			--dialog_shell.set_x_y (new_x, new_y);
		--end;


	--set_x (new_x: INTEGER) is
		--do
			--dialog_shell.set_x (new_x);
		--end;


	--set_y (new_y: INTEGER) is
		--do
			--dialog_shell.set_y (new_y);
		--end;

	x: INTEGER is
		do
			Result := dialog_shell.x;
		end;


	y: INTEGER is
		do
			Result := dialog_shell.y;
		end;


	width: INTEGER is
		do
			Result := dialog_shell.width;
		end;


	height: INTEGER is
		do
			Result := dialog_shell.height;
		end;

	forbid_resize is
		do
			dialog_shell.forbid_resize
		end;

	allow_resize is
		do
			dialog_shell.allow_resize
		end;

	popup is
		do
			set_managed (True);
		end;

	popdown is
		do
			set_managed (False);
		end;

	is_poped_up: BOOLEAN is
		do
			Result := dialog_shell.is_poped_up;
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

