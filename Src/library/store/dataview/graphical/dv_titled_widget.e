indexing
	description: "Text component with a title. Can be displayed vertically or horizontally"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- class DV_TITLED_WIDGET

