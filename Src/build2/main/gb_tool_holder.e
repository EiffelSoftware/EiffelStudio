indexing
	description: "Objects that hold a tool within the main window."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	
	-- The implementation of this class relies on the fact that it is parented in
	-- a split area.

class
	GB_TOOL_HOLDER

inherit
	EV_FRAME
	
create
	make_with_tool
	
feature {NONE} -- Initialization

	make_with_tool (tool: EV_WIDGET; display_name: STRING) is
			-- Create `Current', and initalize with
			-- tool `tool'.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
			frame: EV_FRAME
			tool_bar: EV_TOOL_BAR
			minimize_button, maximize_button: EV_TOOL_BAR_BUTTON
		do
			default_create
			set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_lowered)
			create vertical_box
			extend (vertical_box)
			create horizontal_box
			create frame
			frame.set_style (feature {EV_FRAME_CONSTANTS}.Ev_frame_raised)
			vertical_box.extend (frame)
			frame.extend (horizontal_box)
			create label.make_with_text (display_name)
			label.align_text_left
			horizontal_box.extend (label)
			create tool_bar
			create minimize_button
			minimize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_minimize @ 1)
			tool_bar.extend (minimize_button)
			create maximize_button
			maximize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_maximize @ 1)
			tool_bar.extend (maximize_button)
			horizontal_box.extend (tool_bar)
			horizontal_box.disable_item_expand (tool_bar)
			vertical_box.disable_item_expand (frame)
			vertical_box.extend (tool)
		end

end -- class GB_TOOL_HOLDER
