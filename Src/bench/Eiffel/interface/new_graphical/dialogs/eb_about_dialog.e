indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_ABOUT_DIALOG

inherit
	EV_DIALOG
		redefine
			make
		end

	EV_COMMAND

	SYSTEM_CONSTANTS

	EB_SHARED_PIXMAPS

--	WINDOW_ATTRIBUTES

creation
	make

feature -- Initialization

	make (par: EV_WINDOW) is
		do
			precursor (par)

			set_title ("About ISE EiffelBench...")

			add_close_command (Current, Void)

--			create logo.make_with_pixmap (display_area, bm_ISE_Power)

			create label.make_with_text (display_area, t_info)

			create button.make_with_text (action_area, t_button)
			button.set_horizontal_resize (False)
			button.add_click_command (Current, Void)
			show
		end

feature -- Access

	image: EV_PIXMAP

	logo: EV_DRAWING_AREA

	label: EV_LABEL

	button: EV_BUTTON

feature -- Constant strings

	t_button:STRING is "   OK   "

	t_info:STRING is
		once
			create Result.make(0)
			Result.append ("Copyright (C) 1999%N%
				%Interactive Software Engineering Inc.%N%N%
				%ISE Building, 2nd floor%N%
				%270 Storke Road, Goleta, CA 93117 USA%N%
				%Telephone 805-685-1006, Fax 805-685-6869%N%
				%Electronic mail <info@eiffel.com>%N%
				%Web Customer Support: http://support.eiffel.com %N%
				%Award-winning Web pages: http://eiffel.com%N")
		end

feature -- Attachements

	set_positions is
			-- Set positions and sizes of `text_area' and
			-- `text_field' in the form.
		local
--			total_width:INTEGER
--			logo_width, logo_height:INTEGER
		do
--			logo_width  := bm_ISE_power.width
--			logo_height  := bm_ISE_power.height
--			total_width := logo_width
--
--			button.set_size(75, 25)
--			button.set_x ((total_width - 75) // 2)
--			button.forbid_recompute_size
--
--			set_size (total_width, logo_height * 2)
--			forbid_resize
		end

feature {NONE} --execution

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			destroy
		end


end -- class EB_ABOUT_DIALOG
