indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DOCKABLE_SOURCE_ACTION_SEQUENCE
inherit
	EV_ACTION_SEQUENCE [TUPLE [EV_DOCKABLE_SOURCE]]
	-- EV_ACTION_SEQUENCE [TUPLE [source: EV_DOCKABLE_SOURCE]]
	-- (ETL3 TUPLE with named parameters)
	
creation
	default_create

feature -- Access

	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (agent wrapper (?, action))
		end

	wrapper (source: EV_DOCKABLE_SOURCE; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([source])
		end

end -- class EV_DOCKABLE_SOURCE_ACTION_SEQUENCE

