indexing
	description:
		"Action sequences for EV_PICK_AND_DROPABLE_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

inherit
	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_I


feature -- Event handling

	create_pick_actions: EV_PND_START_ACTION_SEQUENCE is
			-- Create a pick action sequence.
		do
			create Result
		end

	create_pick_ended_actions: EV_PND_FINISHED_ACTION_SEQUENCE is
			-- Create a pick action sequence.
		do
			create Result
		end

	create_conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a conforming_pick action sequence.
		do
			create Result
		end

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a drop action sequence.
		deferred
		end

end

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

