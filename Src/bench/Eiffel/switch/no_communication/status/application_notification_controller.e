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
		end

feature -- Action

	on_launched_actions: LIST [PROCEDURE [ANY, TUPLE]]

	on_before_stopped_actions: LIST [PROCEDURE [ANY, TUPLE]]

	on_after_stopped_actions: LIST [PROCEDURE [ANY, TUPLE]]

	on_terminated_actions: LIST [PROCEDURE [ANY, TUPLE]]

feature -- Access

	notify_on_launched is
		do
		end

	notify_on_before_stopped is
		do
		end

	notify_on_after_stopped is
		do
		end

	notify_on_terminated is
		do
		end

end -- class APPLICATION_NOTIFICATION_CONTROLLER
