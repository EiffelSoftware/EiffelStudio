indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUTO_SAVE

inherit
	EC_LICENCED_COMMAND

creation
	make

feature -- Creation

	make (c: like caller) is
		do
			caller := c
		end

feature -- Properties

	caller: EV_WINDOW

	symbol: EV_PIXMAP is do end

feature {NONE} -- Implementation

	b: BOOLEAN

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	local
		save_option : SAVE_PROJECT
	do
		if not b then
			--Windows.main_graph_window.timer.set_no_call_back
		else
			!! save_option.make (caller)
			--Windows.main_graph_window.timer.set_regular_call_back
			--	( (Resources.auto_save_delay)*60000 , save_option , Void)
		end	
		b:= not b
	end

end -- class AUTO_SAVE
