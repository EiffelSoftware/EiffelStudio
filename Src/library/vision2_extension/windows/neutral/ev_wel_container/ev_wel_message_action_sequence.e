indexing
	description: "Action sequence for a WEL message."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_MESSAGE_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [POINTER, INTEGER, INTEGER, INTEGER]]
	
create
	default_create
	
feature
	
	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (agent wrapper (?, ?, ?, ?, action))
		end

	wrapper (hwnd: POINTER; msg, wparam, lparam: INTEGER; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([hwnd, msg, wparam, lparam])
		end
end -- class EV_WEL_MESSAGE_ACTION_SEQUENCE
