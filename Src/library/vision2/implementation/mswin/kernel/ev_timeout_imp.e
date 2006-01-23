indexing
	description:
		"Eiffel Vision timeout. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TIMEOUT_IMP

inherit
	EV_TIMEOUT_I

	IDENTIFIED
		rename
			object_id as id
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create timer.
		do
			base_make (an_interface)
		end

	initialize is
		do
			Internal_timeout.add_timeout (Current)
			set_is_initialized (True)
		end

feature -- Access

	interval: INTEGER
			-- Time between calls to `interface.actions' in milliseconds.

feature -- Status setting

	set_interval (an_interval: INTEGER) is
			-- Assign `an_interval' in milliseconds to `interval'.
		do
			interval := an_interval
			Internal_timeout.change_interval (id, interval)
		end

feature -- Implementation

	destroy is
			-- Destroy actual object.
		do
			internal_timeout.remove_timeout (id)
			set_is_destroyed (True)
		end

feature {NONE} -- Implementation

	Internal_timeout: EV_INTERNAL_TIMEOUT_IMP is
			-- Window that launch the timeout commands.
		once
			create Result.make_top ("EiffelVision timeout window")
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TIMEOUT_IMP

