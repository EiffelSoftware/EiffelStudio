note
	description: "Represent struct event_base in libevent library."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVENT_BASE

inherit
	EVENT_ANY

create
	make

feature -- Initialization

	make
			-- Equevalent to event_base_new(void).
			-- Use event_base_new() to initialize a new event base, but does not set
			-- the current_base global.   If using only event_base_new(), each event
			-- added must have an event base set with event_base_set()
		do
			item := {EVENT_EXTERNALS}.event_base_new
		end

feature {NONE} -- Removal

	destroy_item
			-- Called by the `dispose' routine to
			-- destroy `item' by calling the
			-- corresponding Windows function and
			-- set `item' to `default_pointer'.
		do
		end

feature {NONE} -- Global base

	global_base: detachable EVENT_BASE
			-- Global base
		do
			Result := global_base_cell.item
		end

	global_base_cell: CELL [detachable EVENT_BASE]
			-- Global base cell
		once
			create Result.put (Void)
		end

	has_global_base: BOOLEAN
			-- Does global base exist?
		do
			Result := global_base_cell.item /= Void
		end

invariant
	invariant_clause: True -- Your invariant here

end
