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

	SHARED_BENCH_LICENSES

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

	button: PUSH_B
	logo: NO_BORDER_PICT_COLOR_B

	label:LABEL

feature -- Constant strings

	t_button:STRING is "   OK   "

	t_info:STRING is
		once
			if license.username /= Void and then not license.username.is_empty then
				Result := "Version registered to: " + license.username + "%R%N%R%N"
			else
				Result := ""
			end
			Result.append ("Copyright (C) 1999%R%N%
				%Interactive Software Engineering Inc.%R%N%R%N%
				%ISE Building, 2nd floor%R%N%
				%270 Storke Road, Goleta, CA 93117 USA%R%N%
				%Telephone 805-685-1006, Fax 805-685-6869%R%N%
				%Electronic mail <info@eiffel.com>%R%N%
				%Web Customer Support: http://support.eiffel.com %R%N%
				%Award-winning Web pages: http://eiffel.com%R%N")
		end

feature -- Attachements

	set_attachments is
		do
			form.attach_top (logo, 0)
			form.attach_left (logo, 0)
			form.attach_right (logo, 0)

			form.attach_top_widget (logo, form_t, 0)
			form.attach_right (form_t, 0)
			form.attach_left (form_t, 0)

--			form_t.set_fraction_base (12)
			form_t.attach_top (label,3)
			form_t.attach_left (label,10)
			form_t.attach_right (label,10)

--			form_t.attach_left_position (button, 5)
			form_t.attach_top_widget (label, button, 5)
			form_t.attach_bottom (button,5)
		end

	set_values is
		local
			intro_color: COLOR
		do
			!!intro_color.make
			intro_color.set_name ("white")
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
			total_width := logo_width

			button.set_size(75, 25)
			button.set_x ((total_width - 75) // 2)
			button.forbid_recompute_size

			set_size (total_width, logo_height * 2 + 30)
			forbid_resize
		end

feature {NONE} --execution

	execute (arg:ANY) is
		do
			hide
		end

end
