indexing
	description:
		"Action sequence for multi column list row selection events."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "ev_multi_column_list_row_select"
	date: "Generated!"
	revision: "Generated!"

class
	EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE

inherit
	EV_ACTION_SEQUENCE [TUPLE [EV_MULTI_COLUMN_LIST_ROW]]
	-- EV_ACTION_SEQUENCE [TUPLE [item: EV_MULTI_COLUMN_LIST_ROW]]
	-- (ETL3 TUPLE with named parameters)
	
create
	default_create

create {EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE}
	make_filled

feature -- Access

	force_extend (action: PROCEDURE [ANY, TUPLE]) is
			-- Extend without type checking.
		do
			extend (agent wrapper (?, action))
		end

	wrapper (an_item: EV_MULTI_COLUMN_LIST_ROW; action: PROCEDURE [ANY, TUPLE]) is
			-- Use this to circumvent tuple type checking. (at your own risk!)
			-- Calls `action' passing all other arguments.
		do
			action.call ([an_item])
		end

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current is
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

