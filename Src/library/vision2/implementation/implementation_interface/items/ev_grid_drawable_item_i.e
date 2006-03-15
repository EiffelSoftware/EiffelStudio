indexing
	description: "[
		Grid items that do not redraw themselves.
		Implementation interface.
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_DRAWABLE_ITEM_I

inherit
	EV_GRID_ITEM_I
		redefine
			interface,
			perform_redraw,
			required_width
		end

create
	make

feature -- Access

	required_width: INTEGER is
			-- Width in pixels required to fully display contents, based
			-- on current settings.
			-- Note that in some descendents such as EV_GRID_DRAWABLE_ITEM, this
			-- returns 0. For such items, `set_required_width' is available.
		do
			Result := internal_required_width
		end

feature -- Status Setting

	set_required_width (a_required_width: INTEGER) is
			-- Assign `a_required_width' to `required_width'.
		require
			a_required_width_non_negative: a_required_width >= 0
		do
			internal_required_width := a_required_width
		ensure
			required_width_set: required_width = a_required_width
		end

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
			internal_rectangle.move_and_resize (0, 0, a_width, a_height)
			drawable.draw_sub_pixmap (an_indent, 0, pixmap, internal_rectangle)
		end

	internal_required_width: INTEGER
		-- Internal representation of `required_width'.

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

	interface: EV_GRID_DRAWABLE_ITEM;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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

