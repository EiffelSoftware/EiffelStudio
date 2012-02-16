note
	description: "[
		The Cell is similar to EV_GRID_LABEL_ITEM, except it has a checkbox [x]
		See description of EV_GRID_LABEL_ITEM for more details
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_CHECKABLE_LABEL_ITEM

inherit
	EV_GRID_LABEL_ITEM
		redefine
			implementation, create_implementation, initialize,
			computed_initial_grid_label_item_layout,
			is_in_default_state, is_tab_navigatable
		end

create
	default_create,
	make_with_text

feature {EV_ANY} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor
			pointer_button_press_actions.extend (agent checkbox_handled)
		end

feature -- Access

	is_checked: BOOLEAN
			-- Is checkbox checked ?
		do
			Result := implementation.is_checked
		end

	is_toggle_on_label_allowed: BOOLEAN
			-- Is clicking on label changing the checkbox's status?

feature -- Change

	enable_toggle_on_label
			-- Allow clicking on label to change checkbox's status.
		do
			is_toggle_on_label_allowed := True
		ensure
			is_toggle_on_label_allowed_set: is_toggle_on_label_allowed
		end

	disable_toggle_on_label
			-- Disallow clicking on label to change checkbox's status.
		do
			is_toggle_on_label_allowed := False
		ensure
			is_toggle_on_label_allowed_set: not is_toggle_on_label_allowed
		end

	toggle_is_checked
			-- Toggle checkbox status
		do
			implementation.toggle_is_checked
		end

	set_is_checked (b: BOOLEAN)
			-- Set checkbox status
		do
			if is_checked /= b then
				implementation.set_is_checked (b)
			end
		end

feature -- Status

	is_tab_navigatable: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

	is_sensitive: BOOLEAN
			-- Is current sensitive ?
		do
			Result := implementation.is_sensitive
		end

feature -- Status setting

	enable_sensitive
			-- Make object sensitive to user input
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_sensitive
		ensure
			is_sensitive: (parent = Void or else (attached parent as l_parent and then l_parent.is_sensitive)) implies is_sensitive
		end

	disable_sensitive
			-- Make object non-sensitive to user input
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_sensitive
		ensure
			is_unsensitive: not is_sensitive
		end

feature -- Actions

	checked_changed_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [EV_GRID_CHECKABLE_LABEL_ITEM]]
			-- Actions called when checkbox value changed.
		do
			Result := implementation.checked_changed_actions
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_GRID_LABEL_ITEM} and not is_toggle_on_label_allowed
		end

feature {EV_ANY, EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	implementation: EV_GRID_CHECKABLE_LABEL_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_CHECKABLE_LABEL_ITEM_I} implementation.make
		end

	checkbox_handled (a_x, a_y, a_but: INTEGER; r1,r2,r3: REAL_64; a_screen_x, a_screen_y: INTEGER_32)
			-- Checkbox clicked
		local
			l_left: INTEGER
			l_layout: like grid_label_item_layout
		do
			if a_but = {EV_POINTER_CONSTANTS}.left and is_sensitive then
					-- If user hasn't set a left border, we allow clicking
					-- on the left hand side of the checkbox
				if internal_left_border >= 0 then
					l_left := internal_left_border
				else
					l_left := 0
				end
				if is_toggle_on_label_allowed then
						-- Wherever we click within the content of the item
						-- we toggle the checkbox.
					if
						a_x >= l_left and a_x <= width - right_border and
						a_y >= top_border and a_y <= height - bottom_border
					then
						toggle_is_checked
					end
				else
						-- We toggle the checkbox only if clicking on the square.
						-- First get the position of that square
					l_layout := computed_initial_grid_label_item_layout (width, height)
					if attached layout_procedure as l_layout_procedure then
						l_layout_procedure.call ([Current, l_layout])
					end
						-- Finally ensures we are within bounds.
					if
						a_x >= l_layout.checkbox_x and a_x <= l_layout.checkbox_x + check_figure_size and
						a_y >= l_layout.checkbox_y and a_y <= l_layout.checkbox_y + check_figure_size
					then
						toggle_is_checked
					end
				end
			end
		end

feature {EV_GRID_LABEL_ITEM_I} -- Implementation

	check_figure_size: INTEGER = 13
			-- The width/height of the check box.

	check_figure_line_width: INTEGER = 1
			-- The line width on the sign figure.

	computed_initial_grid_label_item_layout (a_width, a_height: INTEGER_32): EV_GRID_LABEL_ITEM_LAYOUT
			-- <Precursor>
		local
			l_left_text_border: INTEGER
		do
			Result := Precursor (a_width, a_height)
				-- We do +1 for cosmetics reason.
			Result.set_checkbox_x (left_border + 1)
				-- We align the checkbox with the text.
			Result.set_checkbox_y (Result.text_y + text_height // 2 - check_figure_size // 2)
				-- We shift the pixmap by the size of the checkbox.
			Result.set_pixmap_x (Result.checkbox_x + check_figure_size + spacing)
				-- Calculate by how much the text has to go to right left.
			if attached pixmap as l_pixmap then
				l_left_text_border := Result.pixmap_x + l_pixmap.width + spacing
			else
					-- No pixmap, so text can use the space calculated for pixmap.
				l_left_text_border := Result.pixmap_x
			end
			if is_right_aligned then
					-- Same as before but make sure we do not override the checkbox.
				Result.set_text_x (Result.text_x.max (l_left_text_border))
			elseif is_left_aligned then
					-- Move text to the right by the size of the checkbox.
				Result.set_text_x (Result.text_x + check_figure_size + spacing)
			else
					-- Move text to the right by half the size of the checkbox since it is centered
					-- but make sure we do not override the checkbox.
				Result.set_text_x ((Result.text_x + (check_figure_size + spacing) // 2).max (l_left_text_border))
			end
				-- Adapt available text width by substracting the space used by the checkbox.
			Result.set_available_text_width ((Result.available_text_width - check_figure_size - spacing).max (0))
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
