indexing

	description: "Abstract notion of an EiffelCase command that can %
				 %be executed only if a licence is available. %
		 		 %May be associated to a button, a hole, and/or a menu entry, ...";
	date: "$Date$";
	revision: "$Revision$"

deferred class 
	EC_LICENCED_COMMAND 

--| should be focusable, ie know about message_keys
--| and its own key -> provide it to its parent 
--| (button) to allow this to set the focus...

--| this will become the iconed_command, an we'll
--| use the non_icon_command (ec_command ) when
--| we don't need any symbol.

inherit

	EC_COMMAND
		rename
			execute as execute_licensed
		end

	LICENSED_COMMAND
		redefine
			execute_licensed
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute Current command, with `argument'
		deferred
		end

	execute_licensed (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute Current command, if the licence is available.
		do
			if license_checked then
				execute (args, data)
			else
				lost_license_warning
			end
		end

feature -- Properties

	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated (if any), in unselected state.
			--| Put here to avoid the need for specific heirs
			--| of BUTTON which would (re)define that `symbol'
		deferred
			--| Not a do end, because most descendants will 
			--| have an associated symbol
		end

feature {SELECTABLE} -- Selection Properties

	selected_symbol: EV_PIXMAP is
			-- Symbol representing button to which Current command is 
			-- associated (if any), in selected (highlighted) state.
			--| Put here to avoid the need for specific heirs
			--| of BUTTON which would (re)define that `symbol'
		do
			--| To be redefined in appropriate heirs	 
		end

feature {SELECTABLE} -- Selection setting

	select_actions is
			-- Actions performed when the button associated to Current 
			-- command is selected.
			--| Put here to avoid the need for specific heirs
			--| of SELECTABLE_BUTTON which would (re)define these `select_actions'
		do 
			--| Do nothing, by default.
			--| To be redefined in appropriate heirs	 	 
		end

	unselect_actions is
			-- Actions performed when the button associated to Current 
			-- command is unselected.
			--| Put here to avoid the need for specific heirs
			--| of SELECTABLE_BUTTON which would (re)define these `unselect_actions'
		do 
			--| Do nothing, by default.
			--| To be redefined in appropriate heirs	 	 
		end

feature {NONE} -- Implementation

	--parent_window: COMPOSITE is
	--		-- Parent window for license manager
	--	once
--			Result := Windows.main_graph_window
	--	end 

end -- class EC_LICENCED_COMMAND











