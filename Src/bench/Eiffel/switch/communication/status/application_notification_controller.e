indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_NOTIFICATION_CONTROLLER

create make

feature -- Initialization

	make is
		do
			create {LINKED_LIST [PROCEDURE [ANY, TUPLE]]} on_launched_actions.make
			create {LINKED_LIST [PROCEDURE [ANY, TUPLE]]} on_before_stopped_actions.make
			create {LINKED_LIST [PROCEDURE [ANY, TUPLE]]} on_after_stopped_actions.make
			create {LINKED_LIST [PROCEDURE [ANY, TUPLE]]} on_terminated_actions.make
		end

feature -- Action

	on_launched_actions: LIST [PROCEDURE [ANY, TUPLE]]

	on_before_stopped_actions: LIST [PROCEDURE [ANY, TUPLE]]

	on_after_stopped_actions: LIST [PROCEDURE [ANY, TUPLE]]

	on_terminated_actions: LIST [PROCEDURE [ANY, TUPLE]]

feature -- Access

	notify_on_launched is
		do
			trigger_notification_on (on_launched_actions)
		end

	notify_on_before_stopped is
		do
			trigger_notification_on (on_before_stopped_actions)
		end

	notify_on_after_stopped is
		do
			trigger_notification_on (on_after_stopped_actions)
		end

	notify_on_terminated is
		do
			trigger_notification_on (on_terminated_actions)
		end

feature {NONE} -- trigger notification

	trigger_notification_on (a_list: LIST [PROCEDURE [ANY, TUPLE]]) is
		require
			list_of_notifier_non_void: a_list /= Void
		do
			if not a_list.is_empty then
				from
					a_list.start
				until
					a_list.after
				loop
					a_list.item.call (Void)
					a_list.forth
				end
			end
		end

end -- class APPLICATION_NOTIFICATION_CONTROLLER
