indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FONTABLE_TAB

inherit
	ANY_TAB
		redefine
			make,
			current_widget
		end


creation
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects
		local
			cmd1,cmd2: EV_ROUTINE_COMMAND
		once
			{ANY_TAB} Precursor (Void)
		
				-- Creates the objects and their commands
			--	create cmd2.make (~get_font_name)
			--	create f1.make (Current, "Font Name", Void, cmd2)
				--create cmd1.make (~set_font_name)
				--create cmd2.make (~get_font_name)
				--create f2.make (Current, "Font Name", cmd1, cmd2)
				--create font1.make_with_text (f1.combo, "times new roman")
				--create font2.make_with_text (f1.combo, "")


				set_parent(par)
		end

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Fontable"
		end


feature -- Execution feature  

	set_font_name (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Set the name of the font.
		do
			--current_widget.set_font(f1.get_text)
		end

	get_font_name (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Get the name of the font.
		do
			f1.set_text(current_widget.font.name)
		end

	--set_font_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
	--		-- Sets the font for the demo.
	--	do
	--		current_widget.set_font(f1.get_text)
	--	end

	--get_font_val (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
	--		-- Gets the font of the demo.
	--	do
	--		f1.get_text(current_widget.font)
	--	end
	
feature -- Access

	current_widget: EV_FONTABLE
	f1: TEXT_FEATURE_MODIFIER
	f2: COMBO_FEATURE_MODIFIER	
	b1,b2,b3: EV_BUTTON
	font1,font2: EV_LIST_ITEM
end -- class FONTABLE_TAB


--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

