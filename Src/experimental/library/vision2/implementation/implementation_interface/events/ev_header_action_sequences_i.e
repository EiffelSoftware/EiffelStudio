note
	description:
		"Action sequences for EV_HEADER_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$date"
	revision: "$revision"

deferred class
	 EV_HEADER_ACTION_SEQUENCES_I

feature -- Access

	item_resize_start_actions: EV_HEADER_ITEM_ACTION_SEQUENCE
			-- Actions to be performed when resizing begins on a header item.
		do
			if attached item_resize_start_actions_internal as l_result then
				Result := l_result
			else
				create Result
				item_resize_start_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

	item_resize_actions: EV_HEADER_ITEM_ACTION_SEQUENCE
			-- Actions to be performed as a header item is resized.
		do
			if attached item_resize_actions_internal as l_result then
				Result := l_result
			else
				create Result
				item_resize_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

	item_resize_end_actions: EV_HEADER_ITEM_ACTION_SEQUENCE
			-- Actions to be performed when resizing completes on a header item.
		do
			if attached item_resize_end_actions_internal as l_result then
				Result := l_result
			else
				create Result
				item_resize_end_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

	item_pointer_double_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [detachable EV_HEADER_ITEM, INTEGER, INTEGER, INTEGER]]
			-- Actions to be performed when a mouse pointer is double-pressed on a header item.
			--
			-- item: EV_HEADER_ITEM -- The header item the event occurred upon.
			-- x_pos: INTEGER -- The x position of the motion in grid virtual coordinates.
			-- y_pos: INTEGER -- The y position of the motion in grid virtual coordinates.
			-- button_number: INTEGER -- The mouse button number.
		do
			if attached item_pointer_double_press_actions_internal as l_result then
				Result := l_result
			else
				create Result
				item_pointer_double_press_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

	item_pointer_button_press_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [detachable EV_HEADER_ITEM, INTEGER, INTEGER, INTEGER]]
			-- Actions to be performed when a mouse pointer is pressed on a header item.
			--
			-- item: EV_HEADER_ITEM -- The header item the event occurred upon.
			-- x_pos: INTEGER -- The x position of the motion in grid virtual coordinates.
			-- y_pos: INTEGER -- The y position of the motion in grid virtual coordinates.
			-- button_number: INTEGER -- The mouse button number.
		do
			if attached item_pointer_button_press_actions_internal as l_result then
				Result := l_result
			else
				create Result
				item_pointer_button_press_actions_internal := Result
			end
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	item_resize_actions_internal: detachable EV_HEADER_ITEM_ACTION_SEQUENCE
		-- Implementation of once per object `item_resize_actions_internal'.
		note
			option: stable
		attribute
		end

	item_resize_start_actions_internal: detachable EV_HEADER_ITEM_ACTION_SEQUENCE
		-- Implementation of once per object `item_resize_start_actions_internal'.
		note
			option: stable
		attribute
		end

	item_resize_end_actions_internal: detachable EV_HEADER_ITEM_ACTION_SEQUENCE
		-- Implementation of once per object `item_resize_end_actions_internal'.
		note
			option: stable
		attribute
		end

	item_pointer_button_press_actions_internal: detachable EV_LITE_ACTION_SEQUENCE [TUPLE [detachable EV_HEADER_ITEM, INTEGER, INTEGER, INTEGER]]
		-- Implementation of once per object `item_pointer_button_press_actions'.
		note
			option: stable
		attribute
		end

	item_pointer_double_press_actions_internal: detachable EV_LITE_ACTION_SEQUENCE [TUPLE [detachable EV_HEADER_ITEM, INTEGER, INTEGER, INTEGER]]
		-- Implementation of once per object `item_double_button_press_actions'.
		note
			option: stable
		attribute
		end

note
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











