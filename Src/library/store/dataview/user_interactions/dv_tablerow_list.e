indexing
	description: "Interface for a selection-sensitive database %
			%table row list structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DV_TABLEROW_LIST

inherit
	DB_TABLES_ACCESS_USE

feature {DV_COMPONENT} -- Access

	index: INTEGER is
			-- Index of currently selected item.
			--| Index refers to last refreshed table rows list.
		deferred
		end

feature {DV_COMPONENT} -- Status report

	information_set: BOOLEAN is
			-- Is information necessary to
			-- build the object set?
		deferred
		end

	has_select_action (action: PROCEDURE [ANY, TUPLE]): BOOLEAN is
			-- Does list of actions executed when an item is selected
			-- contain `action'?
		deferred
		end

	has_deselect_action (action: PROCEDURE [ANY, TUPLE]): BOOLEAN is
			-- Does list of actions executed when an item is deselected
			-- contain `action'?
		deferred
		end

	is_empty: BOOLEAN is
			-- Is structure empty?
		deferred
		end

feature {DV_COMPONENT} -- Basic operations

	build is
			-- Build component.
		require
			information_set: information_set
		deferred
		end

	set_tablecode (tablecode: INTEGER) is
			-- Set `tablecode' to `table_code'.
		require
			is_valid_code: is_valid_code (tablecode)
		deferred
		end

	extend_select_actions (action: PROCEDURE [ANY, TUPLE]) is
			-- extend list of actions executed when an item is selected
			-- with `action'.
		deferred
		end

	extend_deselect_actions (action: PROCEDURE [ANY, TUPLE]) is
			-- extend list of actions executed when an item is deselected
			-- with `action'.
		deferred
		end

	refresh (al: ARRAYED_LIST [DB_TABLE]) is
			-- Update display with `al'.
		require
			not_void: al /= Void
		deferred
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





end -- class DV_TABLEROW_LIST


