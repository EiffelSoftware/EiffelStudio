indexing
	description:
		"Action sequences for EV_DRAWING_AREA_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_DRAWING_AREA_ACTION_SEQUENCES_IMP

inherit
	EV_DRAWING_AREA_ACTION_SEQUENCES_I
		export 
			{INTERMEDIARY_ROUTINES} expose_actions_internal
		end

	EV_ANY_IMP 
		undefine 
			dispose, destroy 
		end

feature -- Event handling

	create_expose_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Create a expose action sequence.
			-- Attach to GTK "expose-event" signal.
		local
			action_sequence: ACTION_SEQUENCE [TUPLE]
		do
--			create action_sequence.make
--			action_sequence.extend (agent Gtk_marshal.create_expose_actions_intermediary (c_object, ?, ?, ?, ?))
--			create Result
--			real_connect_signal_to_actions (c_object, "expose-event", 
--				action_sequence, 
--				default_translate)
				
			create Result
			real_signal_connect (c_object, "expose-event", agent gtk_marshal.create_expose_actions_intermediary (c_object, ?, ?, ?, ?), default_translate)
		end

--	Gtk_signal_expose_event: INTEGER is
--		once
--			Result := C.gtk_signal_name ("expose-event")
--		end

end


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

