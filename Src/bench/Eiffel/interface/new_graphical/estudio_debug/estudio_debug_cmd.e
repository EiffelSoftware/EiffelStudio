indexing
	description : "Objects that represents the special debug menu access point"
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ESTUDIO_DEBUG_CMD

create 
	make

feature {NONE} -- Initialization

	make (w: EV_WINDOW) is
			-- Initialize `Current'.
		do
			window := w	
			build_accelerator
		end

feature -- Status

	build_accelerator is
			-- Build accelerator related to Current command
		do
			create accelerator.make_with_key_combination (
					create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_d) ,
					True, True, False
				)
			accelerator.actions.extend (agent execute)
		end
		
feature -- Access

	window: EV_WINDOW
			-- window related to current's accelerator.

	accelerator: EV_ACCELERATOR
			-- Accelerator used to trigger current command.

feature {NONE} -- Implementation

	menu: ESTUDIO_DEBUG_MENU
			-- Menu created when current command is executed.

	execute is
		local
			mb: EV_MENU_BAR
		do
			if window.menu_bar /= Void then
				mb := window.menu_bar
				if menu /= Void and then menu.is_destroyed then
					menu := Void
				end
				if menu = Void then
					create menu.make_with_window (window)
					mb.extend (menu)
				else
					menu.close_menu
					menu := Void
				end
			end
		end
		
invariant
	
	accelerator_not_void: accelerator /= Void

end
