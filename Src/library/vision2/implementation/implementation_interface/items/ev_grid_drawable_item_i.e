indexing
	description: "[
		Grid items that do not redraw themselves.
		Implementation interface.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_DRAWABLE_ITEM_I

inherit
	EV_GRID_ITEM_I
		redefine
			interface,
			perform_redraw
		end

create
	make

feature {NONE} -- Implementation

	perform_redraw (an_x, a_y, a_width, a_height, an_indent: INTEGER; drawable: EV_DRAWABLE) is
			-- Redraw `Current'.
		local
			pixmap: EV_PIXMAP
		do
			pixmap := parent_i.drawer.drawable_item_buffer_pixmap
			if pixmap.width < a_width or pixmap.height < a_height then
					-- Resize `pixmap'so that it is at least as large as `Current'.
					-- Note that we do not reduce the size of `pixmap' for performance reasons.
				pixmap.set_size (a_width, a_height)
			end

			if expose_actions_internal /= Void then
				expose_actions_internal.call ([pixmap])
			end
			
				-- Now blit the pixmap to `drawable'.
			drawable.draw_sub_pixmap (an_indent, 0, pixmap, create {EV_RECTANGLE}.make (0, 0, a_width, a_height))
		end
		
feature {EV_GRID_DRAWABLE_ITEM} -- Implementation

	expose_actions: ACTION_SEQUENCE [TUPLE [EV_DRAWABLE]] is
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

	create_expose_actions: ACTION_SEQUENCE [TUPLE [EV_DRAWABLE]] is
			-- Create a expose action sequence.
		do
			create Result
		end

	expose_actions_internal: ACTION_SEQUENCE [TUPLE [EV_DRAWABLE]]
			-- Implementation of once per object `expose_actions'.

feature {EV_ANY_I} -- Implementation

	interface: EV_GRID_DRAWABLE_ITEM
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
