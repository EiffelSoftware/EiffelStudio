indexing
	description:
		"The demo that goes with the tool bar demo";
	date: "$Date$";
	revision: "$Revision$"

class
	TOOLBAR_WINDOW

inherit
	EV_VERTICAL_BOX
		redefine
			make
		end

	EV_COMMAND

	PIXMAP_PATH

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			sep: EV_HORIZONTAL_SEPARATOR
		do
			{EV_VERTICAL_BOX} Precursor (Void)
			create sep.make (Current)
			create_first_bar (Current)
			create sep.make (Current)
			create_second_bar (Current)
			create sep.make (Current)
			create_splits (Current)
			set_parent (par)
		end

feature {NONE} -- Basic operations

	pixmap (name:STRING): EV_PIXMAP is
				-- A pixmap.
		do
			create Result.make_from_file (pixmap_path (name))
		end

	add_button (tool: EV_TOOL_BAR; text, name: STRING) is
			-- Add a button with `text' and `name' to `tool'.
		local
			tool_button: EV_TOOL_BAR_BUTTON
			arg: EV_ARGUMENT1 [STRING]
			str: STRING
			type: EV_PND_TYPE
		do
			create tool_button.make (tool)
			tool_button.set_pixmap (pixmap (name))
			tool_button.activate_pick_and_drop (Void, Void)
			create type.make
			tool_button.set_data_type (type)
			tool_button.set_transported_data ("Bonjour")
		end

	add_toggle (tool: EV_TOOL_BAR; text, name: STRING) is
			-- Add a button with `text' and `name' to `tool'.
		local
			tool_button: EV_TOOL_BAR_TOGGLE_BUTTON
		do
			create tool_button.make (tool)
			tool_button.set_pixmap (pixmap (name))
			tool_button.set_selected (True)
		end

	add_radio (tool: EV_TOOL_BAR; text, name: STRING) is
			-- Add a button with `text' and `name' to `tool'.
		local
			tool_button: EV_TOOL_BAR_RADIO_BUTTON
		do
			create tool_button.make (tool)
			tool_button.set_pixmap (pixmap (name))
			tool_button.set_selected (True)
		end

feature {NONE} -- Implementation

	create_first_bar (par: EV_VERTICAL_BOX) is
			-- Create the first tool-bar of ebench.
		local
			hbox: EV_HORIZONTAL_BOX
			label: EV_LABEL
			tool: EV_TOOL_BAR
			sep: EV_TOOL_BAR_SEPARATOR
		do
			!! hbox.make (par)
			hbox.set_expand (False)

			-- We create a first tool_bar
			!! tool.make (hbox)
			tool.set_expand (False)
			add_button (tool, "", "explain.bmp")
			add_button (tool, "", "system.bmp")
			add_button (tool, "", "class.bmp")
			add_button (tool, "", "routine.bmp")
			add_button (tool, "", "dynlib.bmp")
			add_button (tool, "", "shell.bmp")
			add_button (tool, "", "object.bmp")
			add_button (tool, "", "clr_bp.bmp")
			add_button (tool, "", "setstop.bmp")
			create sep.make (tool)
			add_button (tool, "", "obj_up.bmp")
			add_button (tool, "", "rout_up.bmp")

			create label.make (hbox)

			-- We create a second tool_bar
			!! tool.make (hbox)
			tool.set_expand (False)
			add_button (tool, "", "search.bmp")
			create sep.make (tool)
			!! tool.make_with_size (hbox, 50, 16)
			tool.set_expand (False)
			add_button (tool, "", "update.bmp")
			add_button (tool, "", "qupdate.bmp")
		end

	create_second_bar (par: EV_VERTICAL_BOX) is
			-- Create the first tool-bar of ebench.
		local
			hbox: EV_HORIZONTAL_BOX
			label: EV_LABEL
			tool: EV_TOOL_BAR
			sep: EV_TOOL_BAR_SEPARATOR
		do
			!! hbox.make (par)
			hbox.set_expand (False)

			create label.make (hbox)

			-- We create a tool_bar
			!! tool.make (hbox)
			tool.set_expand (False)
			add_button (tool, "", "up_stack.bmp")
			add_button (tool, "", "dn_stack.bmp")
			add_button (tool, "", "current.bmp")
			create sep.make (tool)
			add_button (tool, "", "dbgquit.bmp")
			create sep.make (tool)
			add_button (tool, "", "execstep.bmp")
			add_button (tool, "", "execlast.bmp")
			add_button (tool, "", "execnost.bmp")
			create sep.make (tool)

			!! tool.make_with_size (hbox, 50, 16)
			tool.set_expand (False)
			add_button (tool, "", "dbgrun.bmp")

		end

	create_third_tool_bar (par: EV_VERTICAL_BOX) is
			-- Create the first tool-bar of ebench.
		local
			hbox: EV_HORIZONTAL_BOX
			tool: EV_TOOL_BAR
			field: EV_TEXT_FIELD
			label: EV_LABEL
			sep: EV_TOOL_BAR_SEPARATOR
			tool_button1: EV_TOOL_BAR_RADIO_BUTTON
			tool_button2: EV_TOOL_BAR_RADIO_BUTTON
			tool_button3: EV_TOOL_BAR_RADIO_BUTTON
			tool_imp: EV_TOOL_BAR_IMP
		do
			!! hbox.make (par)
			hbox.set_expand (False)
			hbox.set_spacing (5)

			-- We create a tool_bar
			!! tool.make (hbox)
			tool.set_expand (False)
			add_button (tool, "", "routdot.bmp")
			add_button (tool, "", "classdot.bmp")
			create sep.make (tool)
			add_button (tool, "", "search.bmp")
			create sep.make (tool)

			create tool_button1.make (tool)
			tool_button1.set_pixmap (pixmap ("stext.bmp"))
			tool_button1.set_selected (True)
			create tool_button2.make (tool)
			tool_button2.set_pixmap (pixmap ("sflat.bmp"))
			tool_button2.set_peer (tool_button1)
			tool_button2.set_selected (True)
			create tool_button3.make (tool)
			tool_button3.set_pixmap (pixmap ("breakpt.bmp"))
			tool_button3.set_peer (tool_button2)
			tool_button3.set_selected (True)

			create sep.make (tool)
			add_button (tool, "", "scallers.bmp")
			add_button (tool, "", "shistory.bmp")
			add_button (tool, "", "saversio.bmp")
			add_button (tool, "", "sdversio.bmp")
			create sep.make (tool)
			add_button (tool, "", "shomonym.bmp")
			add_button (tool, "", "histback.bmp")
			add_button (tool, "", "histfort.bmp")

			-- Then, the text fields of the right
			create field.make_with_text (hbox, "widget_make")
--			field.set_minimum_width (100)
			create label.make_with_text (hbox, "from :")
			label.set_expand (False)
			label.set_vertical_resize (False)
			create field.make_with_text (hbox, "EV_WIDGET")
--			field.set_minimum_width (100)
		end

	create_forth_tool_bar (par: EV_VERTICAL_BOX) is
			-- Create the first tool-bar of ebench.
		local
			hbox: EV_HORIZONTAL_BOX
			tool: EV_TOOL_BAR
			sep: EV_TOOL_BAR_SEPARATOR
		do
			!! hbox.make (par)
			hbox.set_expand (False)

			-- We create a tool_bar
			!! tool.make (hbox)
			tool.set_expand (False)
			add_toggle (tool, "", "sattribu.bmp")
			add_toggle (tool, "", "sonces.bmp")
			create sep.make (tool)
			add_button (tool, "", "slice.bmp")
			create sep.make (tool)
			add_button (tool, "", "search.bmp")
			create sep.make (tool)
			add_button (tool, "", "histback.bmp")
			add_button (tool, "", "histfort.bmp")
		end

	create_splits (par: EV_VERTICAL_BOX) is
			-- Create the first tool-bar of ebench.
		local
			hsplit: EV_VERTICAL_SPLIT_AREA
			vsplit: EV_HORIZONTAL_SPLIT_AREA
			vbox: EV_VERTICAL_BOX
			edit: EV_RICH_TEXT
			list: EV_LIST
			row: EV_LIST_ITEM
			temp: EV_SCROLLABLE_AREA
		do
			-- The first split area
			create vsplit.make (par)

			-- The selector
			create list.make (vsplit)
			create row.make_with_text (list, "EV_TOOL_BAR_IMP")
			create row.make_with_text (list, "MAIN_WINDOW")
			create row.make_with_text (list, "EV_INTERNAL_TOOL_BAR")
			vsplit.set_position (100)

			-- We create the second split area
			create hsplit.make (vsplit)
			create vsplit.make (hsplit)

			-- The feature tool.
			create vbox.make (hsplit)
			hsplit.set_position (100)
			create_third_tool_bar (vbox)
			create edit.make (vbox)

			-- The main panel
			create edit.make (vsplit)
			vsplit.set_position (200)

			-- The object tool
			create vbox.make (vsplit)
			create_forth_tool_bar (vbox)
			create edit.make (vbox)
		end

feature -- Command execution

	execute (arg: EV_ARGUMENT1 [STRING]; data: EV_EVENT_DATA) is
			-- Executed when the mouse button is released.
		do
			io.put_string (arg.first)
		end

end -- class TOOLBAR_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
