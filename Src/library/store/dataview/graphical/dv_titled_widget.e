indexing
	description: "Text component with a title. Can be displayed vertically or horizontally"
	date: "$Date$"
	revision: "$Revision$"

class
	DV_TITLED_WIDGET

create
	make_vertical_with_title,
	make_horizontal_with_title

feature -- Initialization

	make_vertical_with_title (txt: STRING) is
			-- Initialization
		require
			not_void: txt /= Void
		do
			create {DV_VERTICAL_BOX}box.make
			build_with_title (txt)
			is_vertical := True
		end

	make_horizontal_with_title (txt: STRING) is
			-- Initialization
		require
			not_void: txt /= Void
		do
			create {DV_HORIZONTAL_BOX}box.make
			build_with_title (txt)
		end

feature -- Access

	box: DV_BOX
			-- Box containing field.

	label: DV_LABEL
			-- Title label.
	
	field: EV_WIDGET
			-- Field.

feature -- Status report

	is_vertical: BOOLEAN
			-- Is the display vertical?

	is_horizontal: BOOLEAN is
			-- Is the display horizontal?
		do
			Result := not is_vertical
		end

feature -- Basic operations

	change_field (new_field: EV_WIDGET) is
			-- Replace `field' with `new_field'.
		do
				-- Remove field.
			box.prune (field)
				-- Put new field right after the label.
			box.start
			box.search (label)
			box.put_right (new_field)
		end

feature {NONE} -- Implementation

	build_with_title (txt: STRING) is
			-- Build the titled text field vertically or horizontally,
			-- according to `box'. Set title to `txt'.
		do
			create label.make_with_text (txt)
			label.align_text_left
			box.extend (label)
			box.disable_item_expand (label)
			create {DV_TEXT_FIELD}field
			field.set_minimum_height (22)
			box.extend (field)
		end

indexing

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Contact: http://contact.eiffel.com
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_TITLED_WIDGET

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

