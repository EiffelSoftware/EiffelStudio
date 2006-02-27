indexing
	description: "[
		Grid items that do not redraw themselves.
		The `expose_actions' are fired as `Current' must be redrawn, and provide the
		drawable into which you must draw. The upper left corner of the item starts at
		coordinates 0x0 in the passed drawable. All drawing Performed in the drawable is
		clipped to `width', `height' of Current. Note that the dimensions of the drawable area are
		undefined, but are always be greater than `width' and `height'.

			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_DRAWABLE_ITEM

inherit
	EV_GRID_ITEM
		redefine
			implementation,
			create_implementation,
			required_width
		end

create
	default_create,
	make_with_expose_action_agent

feature {NONE} -- Initialization

	make_with_expose_action_agent (an_agent: PROCEDURE [ANY, TUPLE [EV_DRAWABLE]]) is
			-- Create `Current' and add `an_agent' to `expose_actions'.
		require
			an_agent_not_void: an_agent /= Void
		do
			default_create
			expose_actions.extend (an_agent)
		end

feature -- Access

	required_width: INTEGER is
			-- Width in pixels required to fully display contents, based
			-- on current settings.
		do
			Result := implementation.required_width
		end

feature -- Status setting

	set_required_width (a_required_width: INTEGER) is
			-- Assign `a_required_width' to `required_width'.
		require
			not_destroyed: not is_destroyed
			a_required_width_non_negative: a_required_width >= 0
		do
			implementation.set_required_width (a_required_width)
		ensure
			required_width_set: required_width = a_required_width
		end

feature -- Element change

	expose_actions: ACTION_SEQUENCE [TUPLE [EV_DRAWABLE]] is
			-- Actions to be performed when an area needs to be redrawn.
			-- See description at top of class to determine how to draw into the drawable.
		do
			Result := implementation.expose_actions
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_GRID_DRAWABLE_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_DRAWABLE_ITEM_I} implementation.make (Current)
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

