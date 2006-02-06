indexing
	description: "Objects that represent action sequences for EV_HEADER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_HEADER_ACTION_SEQUENCES

inherit
	ANY
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create, copy
		end

feature -- Access

	item_pointer_button_press_actions: ACTION_SEQUENCE [TUPLE [EV_HEADER_ITEM, INTEGER, INTEGER, INTEGER]] is
			-- Actions to be performed when a mouse pointer is pressed on a header item.
			--
			-- item: EV_HEADER_ITEM -- The header item the event occurred upon.
			-- button_number: INTEGER -- The mouse button number.
			-- x_pos: INTEGER -- The x position of the motion in grid virtual coordinates.
			-- y_pos: INTEGER -- The y position of the motion in grid virtual coordinates.
		do
			Result := implementation.item_pointer_button_press_actions
		ensure
			not_void: Result /= Void
		end

	item_pointer_double_press_actions: ACTION_SEQUENCE [TUPLE [EV_HEADER_ITEM, INTEGER, INTEGER, INTEGER]] is
			-- Actions to be performed when a mouse pointer is double-pressed on a header item.
			--
			-- item: EV_HEADER_ITEM -- The header item the event occurred upon.
			-- button_number: INTEGER -- The mouse button number.
			-- x_pos: INTEGER -- The x position of the motion in grid virtual coordinates.
			-- y_pos: INTEGER -- The y position of the motion in grid virtual coordinates.
		do
			Result := implementation.item_pointer_double_press_actions
		ensure
			not_void: Result /= Void
		end

	item_resize_start_actions: EV_HEADER_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when resizing begins on a header item.
		do
			Result := implementation.item_resize_start_actions
		ensure
			not_void: Result /= Void
		end

	item_resize_actions: EV_HEADER_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed as a header item is resized.
		do
			Result := implementation.item_resize_actions
		ensure
			not_void: Result /= Void
		end

	item_resize_end_actions: EV_HEADER_ITEM_ACTION_SEQUENCE is
			-- Actions to be performed when resizing completes on a header item.
		do
			Result := implementation.item_resize_end_actions
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implementation

	implementation: EV_HEADER_ACTION_SEQUENCES_I;

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

