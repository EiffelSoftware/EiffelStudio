indexing
	description:
		"Eiffel Vision timeout. Mswindows implementation."
	status: "See notice at end of class"
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
			if interval /= an_interval then
				interval := an_interval
				Internal_timeout.change_interval (id, interval)
			end
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

end -- class EV_TIMEOUT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

