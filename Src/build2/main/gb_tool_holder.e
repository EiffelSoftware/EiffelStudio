indexing
	description: "Objects that surround a tool with a title%
		%and minimize and maximize buttons."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	
class
	GB_TOOL_HOLDER

inherit
	EV_FRAME
	
create
	make_with_tool
	
feature {NONE} -- Initialization

	make_with_tool (a_tool: EV_WIDGET; display_name: STRING) is
			-- Create `Current', and initalize with
			-- tool `a_tool'. Use `display_name' for title of `a_tool'.
		local
			vertical_box: EV_VERTICAL_BOX
			horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
			frame: EV_FRAME
			tool_bar: EV_TOOL_BAR
		do
			default_create
			tool := a_tool
			tool.set_minimum_size (0, 0)
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
			minimize_button.select_actions.extend (agent minimize)
			tool_bar.extend (minimize_button)
			create maximize_button
			maximize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_maximize @ 1)
			maximize_button.select_actions.extend (agent maximize)
			tool_bar.extend (maximize_button)
			horizontal_box.extend (tool_bar)
			horizontal_box.disable_item_expand (tool_bar)
			vertical_box.disable_item_expand (frame)
			vertical_box.extend (a_tool)
		end
		
feature -- Access

	tool: EV_WIDGET
		-- Tool in `Current'.
		
	minimized: BOOLEAN
		-- Is `Current' minimized?
		
	maximized: BOOLEAN
		-- Is `Current' maximized?
		
	disable_minimized is
			-- Assign `False' to `minimized'.
		do
			minimized := False
		end
		
	disable_maximized is
			-- Assign `False' to `maximized'.
		do
			maximized := False
		end
		
	reset_minimize_button is
			-- Restore original pixmap to `minimize_button'.
		do
			minimize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_minimize @ 1)			
		end
		
	reset_maximize_button is
			-- Restore original pixmap to `maximize_button'.
		do
			maximize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_maximize @ 1)
		end
		

feature {NONE} -- Implementation

	minimize is
			-- Minimize `Current' if not minimized, restore otherwise.
		do
			tool_holder_parent.minimize_tool (Current)
			minimized := not minimized
			if minimized then
				minimize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_restore @ 1)	
			else
				minimize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_minimize @ 1)	
			end
		end
		

	maximize is
			-- Maximize `Current' if not maxamized, restore otherwise.
		do
			tool_holder_parent.maximize_tool (Current)
			maximized := not maximized
			if maximized then
				maximize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_restore @ 1)	
			else
				maximize_button.set_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_maximize @ 1)	
			end
		end
		
	tool_holder_parent: GB_TOOL_HOLDER_PARENT is
			-- Parent of `Current'.
		require
			parent_not_void: parent /= Void
		do
			Result ?= parent
			if Result = Void then
				Result ?= parent.parent	
			end
		ensure
			Result_not_void: Result /= Void
		end

feature {GB_TOOL_HOLDER} -- Implementation

	maximize_button, minimize_button: EV_TOOL_BAR_BUTTON
		-- Buttons representing minimize and maximize commands.

end -- class GB_TOOL_HOLDER
