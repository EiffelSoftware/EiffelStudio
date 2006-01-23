indexing
	description: "Buffer manager for EV_BUFFER_PROJECTOR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MODEL_BUFFER_MANAGER
	
feature -- Access

	drawable_position: EV_COORDINATE
			-- Position of `drawable' relative to `world'.
			
	drawable: EV_DRAWABLE is
			-- Object on which the diagram should be drawn.
		do
			Result := drawable_cell.item
		end
		
	drawable_cell: CELL [EV_DRAWABLE]
			-- Cell that contains `drawable'.

feature -- Element change

	set_drawable_position (a_drawable_position: EV_COORDINATE) is
			-- Set `drawable_position' to `a_drawable_position'.
		require
			a_drawable_position_not_void: a_drawable_position /= Void
		do
			drawable_position := a_drawable_position
		ensure
			drawable_position_assigned: drawable_position = a_drawable_position
		end

	set_drawable_cell_and_position (a_drawable_cell: like drawable_cell; a_position: EV_COORDINATE) is
			-- Set `a_drawable' to `drawable'.
		require
			a_drawable_not_void: a_drawable_cell /= Void
			a_position_not_void: a_position /= Void
		do
			set_drawable_position (a_position)
			set_drawable_cell (a_drawable_cell)
		ensure
			assigned: drawable_cell = a_drawable_cell
		end

	set_drawable_cell (a_drawable_cell: like drawable_cell) is
			-- Set `drawable' to `a_drawable'.
		require
			a_drawable_cell_not_void: a_drawable_cell /= Void
		do
			drawable_cell := a_drawable_cell
		ensure
			assigned: drawable_cell = a_drawable_cell
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




end -- class EV_MODEL_BUFFER_MANAGER

