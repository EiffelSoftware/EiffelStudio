indexing
	description: "Eiffel Vision checkable list. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	EV_CHECKABLE_LIST_IMP

inherit
	EV_CHECKABLE_LIST_I
		undefine
			wipe_out,
			selected_items,
			call_pebble_function,
			disable_default_key_processing
		redefine
			interface
		end

	EV_LIST_IMP
		redefine
			interface,
			initialize
		end

	EV_CHECKABLE_LIST_ACTION_SEQUENCES_IMP

create
	make

feature -- Initialization

	initialize
			-- Setup `Current'
		do
			Precursor {EV_LIST_IMP}
		end

	boolean_tree_model_column: INTEGER = 2

	on_tree_path_toggle (a_tree_path_str: POINTER)
			--
		do

		end

	initialize_model
			-- Create our data model for `Current'
		do

		end

feature -- Access

	is_item_checked (list_item: EV_LIST_ITEM): BOOLEAN
			--
		do

		end

feature -- Status setting

	check_item (list_item: EV_LIST_ITEM)
		do

		end

	uncheck_item (list_item: EV_LIST_ITEM)
			-- Ensure check associated with `list_item' is
			-- checked.
		do

		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CHECKABLE_LIST;

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




end -- class EV_CHECKABLE_LIST_IMP

