class PERM_WIND1

inherit
	WINDOWS;
	STATES;
	PERM_WIND
		rename
			make as perm_wind_make,
			realize as old_realize
		undefine
			init_toolkit
		end;
	PERM_WIND
		rename
			make as perm_wind_make
		undefine
			init_toolkit
		redefine
			realize
		select
			realize
		end

creation 
	make

feature 

	scrolled_text1: SCROLLED_T;
			-- Text Area
	
	push_b1: PUSH_B;
			-- VIEW
	
	push_b2: PUSH_B;
			-- QUIT
	
	push_b3: PUSH_B;
			-- SAVE
	
	push_b4: PUSH_B;
			-- BACK
	
	push_b5: PUSH_B;
			-- OPEN
	
	make (a_name: STRING; a_screen: SCREEN) is
		do
			perm_wind_make (a_name, a_screen);
			!! scrolled_text1.make ("Scrolled_text1", Current);
			!! push_b1.make ("push_b1", Current);
			!! push_b2.make ("push_b2", Current);
			!! push_b3.make ("push_b3", Current);
			!! push_b4.make ("push_b4", Current);
			!! push_b5.make ("push_b5", Current);
			set_values
		end;
	
	set_values is
		do
			set_title ("FIORDILIGI");
			scrolled_text1.set_x_y (242, 29);
			scrolled_text1.set_size (241, 361);
			push_b1.set_text ("VIEW");
			push_b1.forbid_recompute_size;
			push_b1.set_font_name ("-adobe-helvetica-bold-r-normal--12-120-75-75-p-70-iso8859-1");
			push_b1.set_x_y (20, 33);
			push_b1.set_size (143, 45);
			push_b2.set_text ("QUIT");
			push_b2.forbid_recompute_size;
			push_b2.set_font_name ("-adobe-helvetica-bold-r-normal--12-120-75-75-p-70-iso8859-1");
			push_b2.set_x_y (20, 309);
			push_b2.set_size (143, 45);
			push_b3.set_text ("SAVE");
			push_b3.forbid_recompute_size;
			push_b3.set_font_name ("-adobe-helvetica-bold-r-normal--12-120-75-75-p-70-iso8859-1");
			push_b3.set_x_y (20, 240);
			push_b3.set_size (143, 45);
			push_b4.set_text ("BACK");
			push_b4.forbid_recompute_size;
			push_b4.set_font_name ("-adobe-helvetica-bold-r-normal--12-120-75-75-p-70-iso8859-1");
			push_b4.set_x_y (20, 102);
			push_b4.set_size (143, 45);
			push_b5.set_text ("OPEN");
			push_b5.forbid_recompute_size;
			push_b5.set_font_name ("-adobe-helvetica-bold-r-normal--12-120-75-75-p-70-iso8859-1");
			push_b5.set_x_y (20, 171);
			push_b5.set_size (143, 45);
			set_x_y (77, 18);
			set_size (499, 421);
			set_colors
		end;
	
	set_colors is
		local
			a_color: COLOR
			a_pixmap: PIXMAP
		do
			!! a_color.make;
			a_color.set_name ("yellow");
			perm_wind1.push_b1.set_background_color (a_color);
			!! a_color.make;
			a_color.set_name ("blue");
			perm_wind1.push_b1.set_foreground_color (a_color);
			!! a_color.make;
			a_color.set_name ("green");
			perm_wind1.push_b2.set_background_color (a_color);
			!! a_color.make;
			a_color.set_name ("blue");
			perm_wind1.push_b2.set_foreground_color (a_color);
			!! a_color.make;
			a_color.set_name ("yellow");
			perm_wind1.push_b3.set_background_color (a_color);
			!! a_color.make;
			a_color.set_name ("red");
			perm_wind1.push_b3.set_foreground_color (a_color);
			!! a_color.make;
			a_color.set_name ("yellow");
			perm_wind1.push_b4.set_background_color (a_color);
			!! a_color.make;
			a_color.set_name ("blue");
			perm_wind1.push_b4.set_foreground_color (a_color);
			!! a_color.make;
			a_color.set_name ("yellow");
			perm_wind1.push_b5.set_background_color (a_color);
			!! a_color.make;
			a_color.set_name ("blue");
			perm_wind1.push_b5.set_foreground_color (a_color)
		end;
	
	realize is
		do
			set_callbacks;
			old_realize
		end;
	
	set_callbacks is
		do
			set_scrolled_text1_callbacks;
			set_push_b1_callbacks;
			set_push_b2_callbacks;
			set_push_b3_callbacks;
			set_push_b4_callbacks;
			set_push_b5_callbacks
		end;
	
	set_scrolled_text1_callbacks is
		local
			com1: COMMAND3
			meta_command: META_COMMAND
		do
			!! com1.make;
			!! meta_command.make;
			meta_command.add (basic, com1);
			perm_wind1.scrolled_text1.add_key_press_action (meta_command, void)
		end;
	
	set_push_b1_callbacks is
		local
			com1: COMMAND1
			com2: COMMAND1
			meta_command: META_COMMAND
		do
			!! com1.make (perm_wind1.scrolled_text1);
			!! com2.make (perm_wind1.scrolled_text1);
			!! meta_command.make;
			meta_command.add (editing, com1);
			meta_command.add (basic, com2);
			perm_wind1.push_b1.add_activate_action (meta_command, void)
		end;
	
	set_push_b2_callbacks is
		local
			com1: COMMAND2
			meta_command: META_COMMAND
		do
			!! com1.make;
			!! meta_command.make;
			meta_command.add (basic, com1);
			perm_wind1.push_b2.add_activate_action (meta_command, void)
		end;
	
	set_push_b3_callbacks is
		local
			com1: SAVE
			meta_command: META_COMMAND
		do
			!! com1.make (perm_wind1.scrolled_text1);
			!! meta_command.make;
			meta_command.add (editing, com1);
			perm_wind1.push_b3.add_activate_action (meta_command, void)
		end;
	
	set_push_b4_callbacks is
		local
			com1: COMMAND4
			meta_command: META_COMMAND
		do
			!! com1.make (perm_wind1.scrolled_text1);
			!! meta_command.make;
			meta_command.add (viewing, com1);
			perm_wind1.push_b4.add_activate_action (meta_command, void)
		end;
	
	set_push_b5_callbacks is
		local
			com1: OPEN
			meta_command: META_COMMAND
		do
			!! com1.make (perm_wind1.scrolled_text1);
			!! meta_command.make;
			meta_command.add (basic, com1);
			perm_wind1.push_b5.add_activate_action (meta_command, void)
		end;
	
end -- class PERM_WIND1
