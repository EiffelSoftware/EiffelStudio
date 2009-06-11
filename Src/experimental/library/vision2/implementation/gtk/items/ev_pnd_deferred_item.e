note
	status: "See notice at end of class."

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
			attached_interface.init_drop_actions (Result)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PICK_AND_DROPABLE note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
