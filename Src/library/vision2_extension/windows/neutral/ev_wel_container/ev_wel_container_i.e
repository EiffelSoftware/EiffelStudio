indexing
	description: "Implementation interface of EV_WEL_CONTAINER."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WEL_CONTAINER_I
	
inherit
	EV_CELL_I
		rename
			replace as cell_replace,
			item as cell_item
		end

feature -- Access

	implementation_window: WEL_WINDOW is
			-- Window containing `item'.
		deferred
		end
		
	item: WEL_WINDOW is
			-- `Result' is WEL_WINDOW contained in `Current'.
		deferred
		end
		
	item_minimum_height: INTEGER is
			-- Minimum height of `item'.
		deferred
		end
		
	item_minimum_width: INTEGER is
			-- Minimum width of `item'.
		deferred
		end
		
feature -- Status setting

	set_item_minimum_height (a_height: INTEGER) is
			-- Set minimum height of `item' to `a_height.
		deferred
		end
		
	set_item_minimum_width (a_width: INTEGER) is
			-- Set minimum height of `item' to `a_height.
		deferred
		end
		
	set_item_minimum_size (a_width, a_height: INTEGER) is
			-- Set minimum size of `item' to `a_width' and `a_height.
		deferred
		end
		
	replace (a_window: WEL_WINDOW) is
			-- Replace `item' with `a_window'.
		deferred
		end

feature -- Event handling

	wel_message_actions: EV_WEL_MESSAGE_ACTION_SEQUENCE is
			-- Actions to be performed when a message is sent
			-- by Windows, to implementation of `Current'.
		do
			if wel_message_actions_internal = Void then
				create wel_message_actions_internal
			end
			Result := wel_message_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	wel_message_actions_internal: EV_WEL_MESSAGE_ACTION_SEQUENCE
			-- Implementation of once per object `pointer_motion_actions'.
		

end -- class EV_WEL_CONTAINER_I
