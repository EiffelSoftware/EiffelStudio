class ABOUT_W

inherit

	TOP_SHELL
		rename
			make as top_shell_make
		end;
	WINDOWS
	COMMAND
	SYSTEM_CONSTANTS

creation

	make

feature

	form: FORM
	form_t: FORM

	text_intro: SCROLLED_T;

	button: PUSH_B;
	logo: NO_BORDER_PICT_COLOR_B

	pix_logo: PIXMAP

	label:LABEL

	t_button:STRING is "   OK   "

	t_intro:STRING is
		once
			!! Result.make(0)
			Result.append ("ISE EiffelBench   %N")
			Result.append ("Version : %N")
			Result.append (version_number)
--  			Result.append ("Date    : 00/00/00")
		end

	t_info:STRING is
		once
			!! Result.make(0)
			Result.append ("Copyright (C) 1986-1998%N%
				%Interactive Software Engineering Inc.%N%N%
				%ISE Building, 2nd floor%N%
				%270 Storke Road, Goleta, CA 93117 USA%N%
				%Telephone 805-685-1006, Fax 805-685-6869%N%
				%Electronic mail <info@eiffel.com>%N%
				%Web Customer Support: http://support.eiffel.com %N%
				%For latest info see award-winning pages: http://www.eiffel.com%N")
		end

	make (a_name: STRING; a_screen: SCREEN) is
		local
			nothing: NOTHING_COMMAND
		do
			top_shell_make (a_name, a_screen);
			!! nothing
			set_delete_command (Current)

			!! form.make ("Bulletin", Current);
			!! form_t.make ("Bulletin2", form);

			!! pix_logo.make;
 			   pix_logo.read_from_file ("d:\test\about\power.bmp");

			!! logo.make ("logo", form);
			   logo.set_pixmap (pix_logo);

			!! text_intro.make ("Text_Intro", form);
  			!! label.make (t_info, form_t);

 			!! button.make (t_button, form_t);
			   button.add_activate_action (Current, Void)


			set_values;
			set_attachments
			set_positions;	
		end;

	set_attachments is
		do
			form.attach_top (logo, 0);
			form.attach_bottom (logo, 0);
			form.attach_left (logo, 0);

			form.attach_right (form_t, 2);
			form.attach_bottom (form_t, 2);
			form.attach_left_widget(logo,form_t,1)
			form.attach_top (text_intro, 0);
			form.attach_right (text_intro, 0);
			form.attach_left_widget(logo, text_intro,1)
			form.attach_top_widget (text_intro, form_t,2)

			form_t.attach_top (label,10)
			form_t.attach_left (label,10)
			form_t.attach_right (label,10)

--  			form_t.attach_right (button,5)
			form_t.attach_bottom (button,5)
		end;

	set_values is
		local
			intro_color: COLOR
			info_color: COLOR
		do
			!!intro_color.make;
			intro_color.set_name ("white");
			text_intro.set_background_color (intro_color);
			text_intro.set_text (t_intro)
			text_intro.hide_vertical_scrollbar
			text_intro.hide_horizontal_scrollbar
			label.set_left_alignment
			set_title ("About ISE EiffelBench...")
		end;

	set_positions is
			-- Set positions and sizes of `text_area' and
			-- `text_field' in the form.
		local
			total_width:INTEGER
			logo_width:INTEGER
			logo_height:INTEGER
		do
			logo_width  := pix_logo.width
			logo_height  := pix_logo.height
			total_width := 3* logo_width

			text_intro.set_size (total_width, logo_height // 4 );
			label.set_size (total_width, logo_height // 4 * 2);
			button.set_size(75, 25)
			button.set_x ( (total_width - 75) //2 )
			button.forbid_recompute_size;

			set_size (logo_width + total_width, logo_height);
			forbid_resize
		end;

feature {NONE} --execution

	execute (arg:ANY) is
		do
			hide
			-- nothing
		end

end
