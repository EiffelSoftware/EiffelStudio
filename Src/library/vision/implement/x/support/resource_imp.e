indexing

	description: 
		"A manager for X resource.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class RESOURCE_X 

inherit

	SHARED_MEL_DISPLAY;

	W_MAN_GEN
		export
			{NONE} all
		end

feature -- Access

	display: MEL_DISPLAY is
			-- Display where resource is allocated
		deferred
		end;

	is_allocated: BOOLEAN
			-- Has the resource been allocated yet?

	has_valid_display: BOOLEAN is
			-- Does the Current resource have a display?
		do
			Result := display /= Void and then display.is_valid
		end;

feature -- Element change

	increment_users is
			-- Increment the `number_of_users' by one.
		do
			number_of_users := number_of_users + 1
		ensure
			incremented: number_of_users = old number_of_users + 1
		end;

	decrement_users is
			-- Decrement the `number_of_users' by one.
		do
			number_of_users := number_of_users - 1
		ensure
			decremented: number_of_users = old number_of_users - 1
		end;

feature {NONE} -- Update

	update_widgets is
			-- Update widgets.
		local
			area: SPECIAL [WIDGET];
			w: WIDGET_IMP;
			real_users, saved_nbr_of_users, i, ct: INTEGER;
		do
			if number_of_users /= 0 then
debug ("VISION")
	io.error.putstring ("Calling `update_widgets'%N");
end
				from
					saved_nbr_of_users := number_of_users;
						-- Reset `number_of_users' since
						-- this will be updated in `update_widget_resource'.
						-- `number_of_users' may not be accurate if the
						-- widgets using the resource were destroyed.
					number_of_users := 0;
					area := widget_manager.area;
					ct := widget_manager.count;
					i := 0
				until
					i >= ct or else number_of_users = saved_nbr_of_users
				loop
					w ?= area.item (i);
					update_widget_resource (w);
					i := i + 1
				end
				check
					valid_number_of_users: saved_nbr_of_users >= number_of_users
				end;
			end
		end;

	update_widget_resource (widget_m: WIDGET_IMP) is
			-- Update resource for `widget_m'.
		require
			widget_m_not_null: widget_m /= Void;
			has_users: number_of_users > 0
		deferred
		end;

feature {NONE} -- Implementation

	number_of_users: INTEGER;
			-- Number of widgets who use this resource

invariant

	has_valid_display: display /= Void

end -- class RESOURCE_X


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

