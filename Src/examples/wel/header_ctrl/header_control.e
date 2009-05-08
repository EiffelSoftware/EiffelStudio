note
	description: "HEADERCONTROL class of the WEL example : Header_Control."
	legal: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height,
				an_id: INTEGER)
			-- Create the control and some items in it.
		do
 			Precursor {WEL_HEADER_CONTROL} (a_parent, a_x, a_y, a_width, a_height, an_id)
 			insert_text_header_item ("First Name", 100, 0, 0)
 			insert_text_header_item ("Last Name", 100, 0, 1)
 			insert_text_header_item ("Phone", 80, 0, 2)
 			insert_text_header_item ("Email", 80, 0, 3)

		end

feature -- Access

	item_output: detachable WEL_STATIC

	mess_output: detachable WEL_SINGLE_SELECTION_LIST_BOX

feature -- Element change

	set_item_output (static: WEL_STATIC)
			-- Make `static' the new output.
		do
			item_output := static
		end

	set_mess_output (list: WEL_SINGLE_SELECTION_LIST_BOX)
			-- Make `static' the new output.
		do
			mess_output := list
		end

	add_mess_output (str: STRING)
			-- Add a message to the output.
		do
			if attached mess_output as l_mess_output then
				l_mess_output.add_string (str)
				l_mess_output.set_top_index (l_mess_output.count - 1)
			end
		end

feature -- Notifications


	on_hdn_begin_track (info: WEL_HD_NOTIFY)
			-- The user has begun dragging a divider in the control 
			-- (that is, the user has pressed the left mouse button while 
			-- the mouse cursor is on a divider in the header control). 
		do
			add_mess_output ("Begin Track")
		end

	on_hdn_track (info: WEL_HD_NOTIFY)
			-- The user is dragging a divider in the header control. 
		do
			add_mess_output ("Track")
		end

	on_hdn_end_track (info: WEL_HD_NOTIFY)
			-- The user has finished dragging a divider. 
		do
			add_mess_output ("End Track")
		end

	on_hdn_divider_dbl_click (info: WEL_HD_NOTIFY)
			-- The user double-clicked the divider area of the control.
		do
			add_mess_output ("Divider Double Click")
		end

	on_hdn_item_changed (info: WEL_HD_NOTIFY)
			-- The attributes of a header item have changed.
		do
			add_mess_output ("Item Changed")
		end

	on_hdn_item_changing (info: WEL_HD_NOTIFY)
			-- The attributes of a header item are about to change.
		do
			add_mess_output ("Item Changing")
		end

	on_hdn_item_click (info: WEL_HD_NOTIFY)
			-- The user clicked the control. 
		do
			add_mess_output ("Item Click")
		end

	on_hdn_item_dbl_click (info: WEL_HD_NOTIFY)
			-- The user double-clicked the control. 
		do
			add_mess_output ("Item Double Click")
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class LISTVIEW

