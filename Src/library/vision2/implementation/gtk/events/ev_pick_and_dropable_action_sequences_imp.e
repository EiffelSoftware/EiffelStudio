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

