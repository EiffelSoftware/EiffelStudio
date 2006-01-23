indexing 
	description:
		"EiffelVision vertical progress bar. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_PROGRESS_BAR_IMP

inherit
	EV_VERTICAL_PROGRESS_BAR_I
		redefine	
			interface
		end

	EV_PROGRESS_BAR_IMP
		redefine
			set_default_minimum_size,
			interface
		end

create
	make

feature -- Status settings

	set_default_minimum_size is
			-- Initialize the size of `Current'.
		do
			ev_set_minimum_size (14, 10)
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create `Current'.
		do
			Result := Ws_visible + Ws_child + Pbs_vertical
				+ Ws_clipchildren + Ws_clipsiblings
	end

feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_PROGRESS_BAR;

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




end -- class EV_VERTICAL_PROGRESS_BAR_IMP

