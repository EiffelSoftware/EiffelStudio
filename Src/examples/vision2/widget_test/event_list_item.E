indexing
	description: "Objects that may be extended into an EVENT_LIST."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVENT_LIST_ITEM
	
inherit
	EV_LIST_ITEM
	
create
	make_with_text
	
feature -- access

	check_event: PROCEDURE [ANY, TUPLE []]
		-- Agent to be executed when `Current' is becomes checked.
	
	uncheck_event: PROCEDURE [ANY, TUPLE []]
		-- Agent to be executed when `Current' becomes unchecked.

feature -- Status setting

	set_accept (an_agent: PROCEDURE [ANY, TUPLE []]) is
			-- Assign `an_agent' to `check_event'.
		do
			check_event := an_agent
		ensure
			event_set: check_event = an_agent
		end
		
	set_deny (an_agent: PROCEDURE [ANY, TUPLE []]) is
			-- Assign `an_agent' to `uncheck_event'.
		do
			uncheck_event := an_agent
		ensure
			event_set: uncheck_event = an_agent
		end

end -- class EVENT_LIST_ITEM
