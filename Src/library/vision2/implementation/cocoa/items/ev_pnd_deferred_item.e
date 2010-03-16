note
	status: "Should probably be refactored."
	author: "Daniel Furrer"

deferred class
	EV_PND_DEFERRED_ITEM

inherit
	EV_ANY_I
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	create_drop_actions: EV_PND_ACTION_SEQUENCE
		do
			create Result
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PICK_AND_DROPABLE note option: stable attribute end;

end
