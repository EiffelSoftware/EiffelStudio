indexing
	description: "A Demo for figures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FIGURE_ITEM

inherit
	DEMO_ITEM [FIGURE_WINDOW]
		redefine
			execute
		end

feature -- Access

	figure: EV_FIGURE is
			-- Current figure associated tothe item.
		deferred
		end
		

feature {DEMO_ITEM} -- Execution commands

	execute (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
			-- When we select the item, we launch the
			-- window and the options. The previous demo
			-- get a Void parent
		do
			Precursor {DEMO_ITEM} (arg, ev_data)
			demo_window.set_figure (figure)
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


end -- class FIGURE_ITEM

