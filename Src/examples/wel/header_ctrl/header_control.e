indexing
	description: "HEADERCONTROL class of the WEL example : Header_Control."
	status: "See notice at end of class."
	date: ""
	revision: ""

class
	HEADER_CONTROL

inherit
	WEL_HEADER_CONTROL
		redefine
			make,
			on_hdn_begin_track,
			on_hdn_track,
			on_hdn_end_track,
			on_hdn_divider_dbl_click,
			on_hdn_item_changed,
			on_hdn_item_changing,
			on_hdn_item_click,
			on_hdn_item_dbl_click
		end

	WEL_LVCF_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVIF_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height,
				an_id: INTEGER) is
			-- Create the control and some items in it.
		do
 			{WEL_HEADER_CONTROL} Precursor (a_parent, a_x, a_y, a_width, a_height, an_id)
 			insert_text_header_item ("First Name", 100, 0, 0)
 			insert_text_header_item ("Last Name", 100, 0, 1)
 			insert_text_header_item ("Phone", 80, 0, 2)
 			insert_text_header_item ("Email", 80, 0, 3)

		end

feature -- Access

	item_output: WEL_STATIC

	mess_output: WEL_SINGLE_SELECTION_LIST_BOX

feature -- Element change

	set_item_output (static: WEL_STATIC) is
			-- Make `static' the new output.
		do
			item_output := static
		end

	set_mess_output (list: WEL_SINGLE_SELECTION_LIST_BOX) is
			-- Make `static' the new output.
		do
			mess_output := list
		end

	add_mess_output (str: STRING) is
			-- Add a message to the output.
		do
			if mess_output /= Void then
				mess_output.add_string (str)
				mess_output.set_top_index (mess_output.count - 1)
			end
		end

feature -- Notifications


	on_hdn_begin_track (info: WEL_HD_NOTIFY) is
			-- The user has begun dragging a divider in the control 
			-- (that is, the user has pressed the left mouse button while 
			-- the mouse cursor is on a divider in the header control). 
		do
			add_mess_output ("Begin Track")
		end

	on_hdn_track (info: WEL_HD_NOTIFY) is
			-- The user is dragging a divider in the header control. 
		do
			add_mess_output ("Track")
		end

	on_hdn_end_track (info: WEL_HD_NOTIFY) is
			-- The user has finished dragging a divider. 
		do
			add_mess_output ("End Track")
		end

	on_hdn_divider_dbl_click (info: WEL_HD_NOTIFY) is
			-- The user double-clicked the divider area of the control.
		do
			add_mess_output ("Divider Double Click")
		end

	on_hdn_item_changed (info: WEL_HD_NOTIFY) is
			-- The attributes of a header item have changed.
		do
			add_mess_output ("Item Changed")
		end

	on_hdn_item_changing (info: WEL_HD_NOTIFY) is
			-- The attributes of a header item are about to change.
		do
			add_mess_output ("Item Changing")
		end

	on_hdn_item_click (info: WEL_HD_NOTIFY) is
			-- The user clicked the control. 
		do
			add_mess_output ("Item Click")
		end

	on_hdn_item_dbl_click (info: WEL_HD_NOTIFY) is
			-- The user double-clicked the control. 
		do
			add_mess_output ("Item Double Click")
		end

end -- class LISTVIEW

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

