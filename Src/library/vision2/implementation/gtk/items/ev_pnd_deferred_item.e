deferred class
	EV_PND_DEFERRED_ITEM
	
inherit
	EV_ABSTRACT_PICK_AND_DROPABLE

feature

	pointer_over_widget (a_gdk_window: POINTER; a_x, a_y: INTEGER): BOOLEAN is
		deferred
		end
		
	parent_widget_is_displayed: BOOLEAN is
		deferred
		end
		
	create_drop_actions: EV_PND_ACTION_SEQUENCE is
		do
			create Result
			interface.init_drop_actions (Result)
		end
		
	interface: EV_PICK_AND_DROPABLE is
		deferred
		end

end
