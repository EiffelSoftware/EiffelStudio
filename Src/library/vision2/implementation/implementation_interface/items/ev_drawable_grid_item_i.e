indexing
	description: "[
		Grid items that do not redraw themselves.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DRAWABLE_GRID_ITEM_I

inherit
	EV_GRID_ITEM_I
		redefine
			interface,
			perform_redraw
		end

create
	make

feature {NONE} -- Implementation

	perform_redraw (an_x, a_y, a_width, a_height: INTEGER; drawable: EV_DRAWABLE) is
			-- Redraw `Current'.
		do
			if expose_actions_internal /= Void then
				expose_actions_internal.call ([an_x, a_y, a_width, a_height, parent_i.drawable])
			end
		end
		
feature {EV_DRAWABLE_GRID_ITEM} -- Implementation

	expose_actions: EV_DRAWABLE_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when an area needs to be redrawn.
		do
			if expose_actions_internal = Void then
				expose_actions_internal :=
					 create_expose_actions
			end
			Result := expose_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_expose_actions: EV_DRAWABLE_ITEM_ACTION_SEQUENCE is
			-- Create a expose action sequence.
		do
			create Result
		end

	expose_actions_internal: EV_DRAWABLE_ITEM_ACTION_SEQUENCE
			-- Implementation of once per object `expose_actions'.

feature {EV_ANY_I} -- Implementation

	interface: EV_DRAWABLE_GRID_ITEM
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'
			
end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
