class ABOUT_W

inherit
	TOP_SHELL
		rename
			make as top_shell_make
		end

	WINDOWS

	COMMAND

	SYSTEM_CONSTANTS

	EB_CONSTANTS

	SHARED_PIXMAPS

	WINDOW_ATTRIBUTES

creation
	make

feature -- Initialization

	make (a_name: STRING; a_screen: SCREEN) is
		do
			top_shell_make (interface_names.i_project_id.out, a_screen)
			set_delete_command (Current)

			!! form.make ("Bulletin", Current)
			!! form_t.make ("Bulletin2", form)

			!! logo.make ("logo", form)
			logo.set_pixmap (bm_ISE_power)

			!! text_intro.make ("Text_Intro", form)
			!! label.make (t_info, form_t)

			!! button.make (t_button, form_t)
			button.add_activate_action (Current, Void)

			set_values
			set_attachments
			set_positions
			set_composite_attributes (Current)
		end

feature -- Access

	form, form_t: FORM
				-- 

	text_intro: SCROLLED_T

	button: PUSH_B
	logo: NO_BORDER_PICT_COLOR_B

	label:LABEL

feature -- Constant strings

	t_button:STRING is "   OK   "

	t_intro:STRING is
		once
			!! Result.make(0)
			Result.append ("ISE EiffelBench   %N")
			Result.append ("Version : ")
			Result.append (version_number)
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
				%For latest info see award-winning pages: http://eiffel.com%N")
		end

feature -- Attachements

	set_attachments is
		do
			form.attach_top (logo, 0)
			form.attach_bottom (logo, 0)
			form.attach_left (logo, 0)

			form.attach_right (form_t, 2)
			form.attach_bottom (form_t, 2)
			form.attach_left_widget (logo,form_t,1)
			form.attach_top (text_intro, 0)
			form.attach_right (text_intro, 0)
			form.attach_left_widget (logo, text_intro,1)
			form.attach_top_widget (text_intro, form_t,2)

			form_t.attach_top (label,3)
			form_t.attach_left (label,10)
			form_t.attach_right (label,10)

--  			form_t.attach_right (button,5)
			form_t.attach_bottom (button,5)
		end

	set_values is
		local
			intro_color: COLOR
			info_color: COLOR
		do
			!!intro_color.make
			intro_color.set_name ("white")
			text_intro.set_background_color (intro_color)
			text_intro.set_text (t_intro)
			text_intro.hide_vertical_scrollbar
			text_intro.hide_horizontal_scrollbar
			label.set_left_alignment
			set_title ("About ISE EiffelBench...")
		end

	set_positions is
			-- Set positions and sizes of `text_area' and
			-- `text_field' in the form.
		local
			total_width:INTEGER
			logo_width, logo_height:INTEGER
		do
			logo_width  := bm_ISE_power.width
			logo_height  := bm_ISE_power.height
			total_width := 3 * logo_width

			text_intro.set_size (total_width, logo_height // 5 )
			label.set_size (total_width, logo_height // 5 * 3)
			button.set_size(75, 25)
			button.set_x ((total_width - 75) //2)
			button.forbid_recompute_size

			set_size (logo_width + total_width + 50, logo_height)
			forbid_resize
		end

feature {NONE} --execution

	execute (arg:ANY) is
		do
			hide
		end

end
