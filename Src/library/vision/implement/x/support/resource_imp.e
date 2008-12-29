note

	description: 
		"A manager for X resource."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
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

	display: MEL_DISPLAY
			-- Display where resource is allocated
		deferred
		end;

	is_allocated: BOOLEAN
			-- Has the resource been allocated yet?

	has_valid_display: BOOLEAN
			-- Does the Current resource have a display?
		do
			Result := display /= Void and then display.is_valid
		end;

feature -- Element change

	increment_users
			-- Increment the `number_of_users' by one.
		do
			number_of_users := number_of_users + 1
		ensure
			incremented: number_of_users = old number_of_users + 1
		end;

	decrement_users
			-- Decrement the `number_of_users' by one.
		do
			number_of_users := number_of_users - 1
		ensure
			decremented: number_of_users = old number_of_users - 1
		end;

feature {NONE} -- Update

	update_widgets
			-- Update widgets.
		local
			area: SPECIAL [WIDGET];
			w: WIDGET_IMP;
			saved_nbr_of_users, i, ct: INTEGER;
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

	update_widget_resource (widget_m: WIDGET_IMP)
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




end -- class RESOURCE_X


