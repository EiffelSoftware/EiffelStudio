indexing
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ES_GRID_ROW_CONTROLLER
inherit
	EV_GRID_HELPER
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
			-- Initialize `Current'.
		do
			create expand_actions
			create collapse_actions
		end

feature -- Change

	reset_row_actions is
		do
			expand_actions.wipe_out
			collapse_actions.wipe_out
		end

feature -- Access

	data: ANY

	pebble: ANY is
		do
		end
		
	pnd_accept_cursor: EV_CURSOR is
		require
			pebble /= Void
		do
		end

	pnd_deny_cursor: EV_CURSOR is
		require
			pebble /= Void
		do
		end

feature -- Change

	set_data (v: like data) is
		do
			data := v
		ensure
			data = v
		end

feature -- Actions

	call_expand_actions (r: EV_GRID_ROW) is
		do
			expand_actions.call ([r])
		end

	expand_actions: EV_GRID_ROW_ACTION_SEQUENCE

	call_collapse_actions (r: EV_GRID_ROW) is
		do
			collapse_actions.call ([r])
		end

	collapse_actions: EV_GRID_ROW_ACTION_SEQUENCE

invariant
	collapse_actions /= Void
	expand_actions /= Void

end -- class ES_GRID_ROW_CONTROLLER
