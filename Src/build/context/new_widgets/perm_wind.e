
class PERM_WIND 

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
			realize, set_managed,
			unrealize, realized,
			manage, unmanage
		end


creation

	make

	
feature 

	make (a_name: STRING; a_screen: SCREEN) is
		do
			!!top_shell.make (a_name, a_screen);
			eb_bulletin_create (a_name, top_shell);
		end;

	top_shell: TOP_SHELL;

	title: STRING is
		do
			Result := top_shell.title;
		end;

	set_title (a_title: STRING) is
		do
			top_shell.set_title (a_title)
		end;

	forbid_resize is
		do
			top_shell.forbid_resize
		end;

	allow_resize is
		do
			top_shell.allow_resize
		end;

	icon_name: STRING is
		do
			Result := top_shell.icon_name
		end;

	set_icon_name (a_name: STRING) is
		do
			top_shell.set_icon_name (a_name)
		end;

	is_iconic_state: BOOLEAN is
		do
			Result := top_shell.is_iconic_state
		end;

	set_iconic_state (flag: BOOLEAN) is
		do
			if flag then
				top_shell.set_iconic_state
			else
				top_shell.set_normal_state
			end;
		end;

	show is
		do
			top_shell.show
		end;

	hide is
		do
			top_shell.hide
		end;

	set_managed (flag: BOOLEAN) is
		do
			top_shell.set_managed (flag)
		end;

	managed: BOOLEAN is
		do
			Result := top_shell.managed
		end;


	unmanage is
		do
			top_shell.unmanage;
		end;

	manage is
		do
			top_shell.manage;
		end;


	x: INTEGER is
		do
			Result := top_shell.x
		end;

	y: INTEGER is
		do
			Result := top_shell.y
		end;

	real_x: INTEGER is
		do
			Result := top_shell.real_x
		end;

	real_y: INTEGER is
		do
			Result := top_shell.real_y
		end;

	set_x_y (new_x, new_y: INTEGER) is
		do
			top_shell.set_x_y (new_x, new_y);
		end;

	set_x (new_x: INTEGER) is
		do
			top_shell.set_x (new_x);
		end;

	set_y (new_y: INTEGER) is
		do
			top_shell.set_y (new_y);
		end;

	width: INTEGER is
		do
			Result := top_shell.width
		end;

	height: INTEGER is
		do
			Result := top_shell.height
		end;

	set_size (new_w, new_h: INTEGER) is
		do
			top_shell.set_size (new_w, new_h);
		end;

	set_width (new_w: INTEGER) is
		do
			top_shell.set_width (new_w);
		end;

	set_height (new_h: INTEGER) is
		do
			top_shell.set_height (new_h);
		end;

	realize is
		do
			top_shell.realize
		end;


	unrealize is
		do
			top_shell.unrealize
		end;

	realized: BOOLEAN is
		do
			Result := top_shell.realized
		end;
end

