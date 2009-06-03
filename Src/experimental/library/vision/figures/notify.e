note

	description:
		"Modification notification. %
		%Instances either notify `notified` or keep modification in %
		%`modified`, depending on the `notify` boolean value"
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class

	NOTIFY

feature -- Access
	
	get_notified: ANY -- !!! get_notified: NOTIFY
			-- object being notified
		do
			Result := notified
		end;

	set_notified (arg: ANY) -- !!! set_notified (arg: NOTIFY) is 
			-- set object being notified
		do
			notified := arg
		end;

	set_receive
		do
			receive := true
		end;

	set_not_receive
		do
			receive := false
		end;

	set_notify
		do
			notify := true
		end;

	set_not_notify
		do
			notify := false
		end;

	set_modified
			-- simple notification of `Current`
		do
			if not notify then
				modified := true
			else
				recompute;
				-- !!! notified.set_modified
			end
		end;

	set_modified_with (arg: ANY)
			-- 'arg' has been modified
		do
			if not notify then
				modified := true
			else
				recompute;
				-- !!!  notified.set_modified_with (arg)
			end
		end;

	unset_modified
		do
			modified := false
		ensure
			unset_modified: not modified
		end;


		set_value_modified (bool: BOOLEAN)
		do
			modified := bool
		end;

feature -- Updating

	recompute
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




end -- class NOTIFY

