indexing

	description:
		"Modification notification. %
		%Instances either notify `notified` or keep modification in %
		%`modified`, depending on the `notify` boolean value";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	NOTIFY

feature -- Access
	
	get_notified: ANY is -- !!! get_notified: NOTIFY
			-- object being notified
		do
			Result := notified
		end;

	set_notified (arg: ANY) is -- !!! set_notified (arg: NOTIFY) is 
			-- set object being notified
		do
			notified := arg
		end;

	set_receive is
		do
			receive := true
		end;

	set_not_receive is
		do
			receive := false
		end;

	set_notify is
		do
			notify := true
		end;

	set_not_notify is
		do
			notify := false
		end;

	set_modified is
			-- simple notification of `Current`
		do
			if not notify then
				modified := true
			else
				recompute;
				-- !!! notified.set_modified
			end
		end;

	set_modified_with (arg: ANY) is
			-- 'arg' has been modified
		do
			if not notify then
				modified := true
			else
				recompute;
				-- !!!  notified.set_modified_with (arg)
			end
		end;

	unset_modified is
		do
			modified := false
		ensure
			unset_modified: not modified
		end;


		set_value_modified (bool: BOOLEAN) is
		do
			modified := bool
		end;

feature -- Updating

	recompute is
			 -- Updating modification
		do
			unset_modified	
		end;

feature -- Status report

	notify: BOOLEAN;

	modified: BOOLEAN;
			-- has `Current` been modified

	receive: BOOLEAN;

feature {NONE} -- access

	notified: ANY; -- !!! notified: NOTIFY
			-- object being notified

invariant
	
	--notified.receive implies notify;
	-- if receive=false `Current` is not always notified

end -- class NOTIFY


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

