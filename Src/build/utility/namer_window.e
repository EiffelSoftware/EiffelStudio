indexing
	description: "Namer window: namer tool."
	date: "$Date$"
	id: "$Id$"
	revision: "$Revision$"

class NAMER_WINDOW

inherit

	EB_WINDOW
		redefine
			make, set_geometry
		end

	CLOSEABLE

creation

	make

feature -- Geometry

	set_geometry is
		do
			set_size (Resources.namer_wnd_width,
					Resources.namer_wnd_height)
			set_vertical_resize (False)
		end

feature
	
	namable: NAMABLE


feature {NONE}

	text: EV_TEXT_FIELD

	label: EV_LABEL

	make (par: EV_WINDOW) is
		local
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			tbar: EV_TOOL_BAR
			namer_hole: NAMER_WIN_EDIT_HOLE
			ok_b: OK_BUTTON
			namer_cmd: NAMER_CMD
			arg: EV_ARGUMENT1 [like text]
		do
			{EB_WINDOW} Precursor (par)
			create vbox.make (Current)

			create hbox.make (vbox)
				--| Toolbar
			create tbar.make (hbox)
			create namer_hole.make (tbar)
			create ok_b.make (tbar)
			create label.make (hbox)

			create text.make (vbox)
			set_values
			set_callbacks
			create namer_cmd
			create arg.make (text)
			ok_b.add_select_command (namer_cmd, arg)
		end

	set_values is
			-- Set values for GUI elements.
		do
			set_title (Widget_names.visual_name_label)
			set_icon_name (Widget_names.visual_name_label)
			set_geometry
		end

	set_callbacks is
			-- Set the GUI elements callbacks.
		local
			namer_cmd: NAMER_CMD
			arg: EV_ARGUMENT1 [like text]
			cmd: EV_ROUTINE_COMMAND
		do
			set_close_callback (Void)
			create namer_cmd
			create arg.make (text)
			text.add_return_command (namer_cmd, arg)
			create cmd.make (~close)
			text.add_return_command (cmd, Void)
		end

feature

	set_namable (nam: like namable) is
		require
			valid_nam: nam /= Void
			is_able_to_be_named: nam.is_able_to_be_named
		do
			namable := nam
			update_name
		end

	popup_with (nam: like namable) is
		require
			valid_nam: nam /= Void
			is_able_to_be_named: nam.is_able_to_be_named
		do
			set_namable (nam)
--			set_x_y (screen.x, screen.y)
			if not shown then
				show
			end
--			raise
		end

	popdown is
		do
			namable := Void
			text.set_text ("")
			label.set_text ("")
			hide
		end

	close (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is 
			-- close the popup
		do
			if shown then
				popdown
			end
		end

	update_name is
		local
			tmp: STRING
		do
			!! tmp.make (0)
			tmp.append (namable.title_label)
			if not text.text.is_equal (namable.label) then
				text.set_text (namable.label)
			end
			label.set_text (tmp)
		end

end -- class NAMER_WINDOW
 
