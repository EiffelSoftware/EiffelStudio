indexing
	description: "Tab used in the action window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ANY_TAB

inherit
	EV_TABLE
		redefine
			make
		end

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the tab and initialise objects
		do
			Precursor {EV_TABLE} (par)
			set_row_spacing (10)
			set_column_spacing (5)		
		end

feature -- Access

	name: STRING is
			-- Title of the current tab. 
		deferred
		end

	current_widget: EV_ANY
			-- Current widget we are working on.

feature -- Element change

	set_current_widget (wid: like current_widget) is
			-- Make `wid' the new widget.
		do
			current_widget ?= wid
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


end -- class ANY_TAB

