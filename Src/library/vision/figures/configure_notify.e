indexing

	description: 
		"Modification notification. %
		%Instances either notify `notified` or keep modification in %
		%`modified`, depending on the `notify` boolean value";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	CONFIGURE_NOTIFY

creation
	
	make

feature -- Initialization

	make is
		do
			!! notify_class;
			set_conf_notify;
			set_conf_receive
		ensure
			notify_class_not_void: notify_class /= Void
		end

feature -- Access

	get_conf_notified: FIGURE is
		do
			Result ?= notify_class.get_notified
		end;

feature -- Element change

	set_conf_notify is
			-- 'Current' notifies `conf_notified' when changes configuration
		do
			notify_class.set_notify
		ensure
			conf_notify: conf_notify
		end;

	set_conf_not_notify is
			-- 'Current' does not notify `conf_notified' when changes configuration
			-- but set the 'conf_modified' attribute instead
		do
			notify_class.set_not_notify
		ensure
			not_conf_notify: not conf_notify
		end;

	set_conf_receive is
			-- 'Current' receives modification notification
			-- so that it does not have to test the 'conf_modified' attribute
			-- of its dependents
		do
			notify_class.set_receive
		ensure
			conf_receive: conf_receive
		end;

	set_conf_not_receive is
			-- 'Current' does not receive modification notification
			-- so that it has to test the 'conf_modified' attribute
			-- of its dependents
		do
			notify_class.set_not_receive
		ensure
			not_conf_receive: not conf_receive
		end;

	set_conf_notified (arg: FIGURE) is
			-- Set the figure object to notify when 'notify' is true
		do
			notify_class.set_notified (arg)
		end;

	set_conf_modified is
			-- To be called when a configuration change has been performed
		do
			if not notify_class.notify then
				notify_class.set_modified
			else
				conf_recompute;
				get_conf_notified.set_conf_modified
			end
		end;

	set_conf_modified_with (arg: CLOSURE) is
			-- To be called when a configuration change has been performed
			-- with an 'arg' information 
		do
			if not notify_class.notify then
				notify_class.set_modified
			else
				conf_recompute;
				get_conf_notified.set_conf_modified_with (arg)
			end
		end;

	unset_conf_modified is
			-- Disable the 'conf_modified' state
		do
			notify_class.unset_modified
		end;

	set_conf_value_modified (bool: BOOLEAN) is
		do
			notify_class.set_value_modified (bool)
		end;

feature -- Updating
	
	conf_recompute is
			-- To be called before unsetting configuration
		do
			notify_class.recompute
		end;
		

feature {NONE} -- Access

	notify_class: NOTIFY;
	
feature -- Status report

	conf_notify: BOOLEAN is
			-- Does 'Current' notify its changes ?
		do
			Result := notify_class.notify
		end;

	conf_modified: BOOLEAN is
			-- has `Current` been modified ?
		do
			Result := notify_class.modified
		end;

	conf_receive: BOOLEAN is
			-- Does 'Current' receive information from its dependent ?
		do
			Result := notify_class.receive
		end;

end -- class CONFIGURE_NOTIFY



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

