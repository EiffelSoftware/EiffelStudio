indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GAUGE_TAB

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
				
			-- Creates the commands for the buttons	
			!!cmd1.make (~set_max)
			!!cmd2.make (~get_max)
			create f1.make(Current, 0, 0, "X", cmd1, cmd2)

			!!cmd1.make (~set_min)
			!!cmd2.make (~get_min)
			create f2.make (Current, 1, 0, "Y", cmd1, cmd2)

			!!cmd1.make (~set_step)
			!!cmd2.make (~get_step)
			create f3.make (Current, 2, 0, "Width", cmd1, cmd2)

			!!cmd1.make (~set_value)
			!!cmd2.make (~get_value)
			create f4.make (Current, 3, 0, "Height", cmd1, cmd2)

			set_parent(par)	
			 
		end


feature -- Access

	temp_par:EV_CONTAINER
	f1,f2,f3,f4:TEXT_FEATURE_MODIFIER

feature -- element change

	--set_current_widget (wid: EV_WIDGET) is
			-- Make `wid' the new widget.
	--	do
	--		{ANY_TAB} Precursor (wid)
	--		if current_widget.managed then
	--			f1.disable_text
	--			f2.disable_text
	--			f3.disable_text
	--			f4.disable_text
	--		else
	--			f1.enable_text
	---			f2.enable_text
	--			f3.enable_text
	--			f4.enable_text
	--		end
	--	end	

feature -- Access

	name:STRING is
			-- Returns the name of the tab
		do
			Result:="Gauge"
		end

feature -- Execution feature

	get_max (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		-- Returns the x coor of the demo
		do
			f1.set_text(current_widget.maximum.out)
		end

	get_min (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the y coor of the demo
		do
			f2.set_text(current_widget.minimum.out)
		end

	get_step (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the width of the demo
		do
			f3.set_text(current_widget.step.out)
	end

	get_value (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Returns the height of the demo
		do
			f4.set_text(current_widget.value.out)
		end



	set_max (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the x position of the demo
		do
			if f1.get_text.is_integer then
				current_widget.set_maximum(f1.get_text.to_integer)
			end
		end

	set_min (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the y position of the demo
		do
			if f2.get_text.is_integer then
				current_widget.set_minimum(f2.get_text.to_integer)
			end
		end

	set_step (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the width of the demo
		do
			if f3.get_text.is_integer then
				current_widget.set_step(f3.get_text.to_integer)
			end
		end

	set_value (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Sets the height of the demo
		do
			if f4.get_text.is_integer then
				current_widget.set_value(f4.get_text.to_integer)
			end
		end

	current_widget: EV_GAUGE

end -- class GAUGE_TAB



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

