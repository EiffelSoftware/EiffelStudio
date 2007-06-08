indexing

	description:
		"EiffelVision table, gtk implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	EV_TABLE_IMP

inherit
	EV_TABLE_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface,
			set_item_position,
			set_item_span,
			remove,
			put,
			resize
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			setup_layout
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Implementation

	make (an_interface: like interface) is
			-- Create a table widget with `par' as parent.
		local
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_left (20)
			rect.set_right (100)
			rect.set_bottom (40)
			rect.set_top (20)
			ret := create_placard_control_external ( null, rect.item, $ptr )
			set_c_object ( ptr )

			-- Initialize internal values
			rows := 1
			columns := 1
			create internal_array.make (1, 1)
			rebuild_internal_item_list
		end

feature -- Status report

	is_homogeneous: BOOLEAN
			-- Does Table have homogeneous spacing, no by default.

	row_spacing: INTEGER is
		do

		end

	column_spacing: INTEGER is
		do

		end

	border_width: INTEGER is
			-- Width of border around container in pixels.
		do



		end

	setup_layout is
			local
				w: EV_WIDGET_IMP
				c: EV_CONTAINER_IMP
				i: INTEGER
			do
--				if count > 0 then
--					layout
--					from
--						i := 1
--					until
--						(i = 0) or (i = count + 1)
--					loop
--						c ?= i_th (i).implementation
--						if c /= void then
--							c.setup_layout
--						end
--						i := i + 1
--					end
--				end
			end

	calculate_minimum_sizes is
			--calculate the minimum sizes for buffered_minimum_heigth and width
			do
			end

	replace (a_widget: EV_WIDGET) is
			do

			end


feature -- Status settings

	enable_homogeneous is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do


		end

	disable_homogeneous is
			-- Homogenous controls whether each object in
			-- the box has the same size.
		do

			is_homogeneous := False
		end

	set_border_width (a_value: INTEGER) is
			-- Set the tables border width to `a_value' pixels.
		do

		end

	set_row_spacing (a_value: INTEGER) is
			-- Spacing between two rows of the table.
		do

		end

	set_column_spacing (a_value: INTEGER) is
			-- Spacing between two columns of the table.
		do

		end

	put (v: EV_WIDGET; a_column, a_row, column_span, row_span: INTEGER) is
			-- Set the position of the `v' in the table.
		do
		end

	remove (v: EV_WIDGET) is
			-- Remove `v' from the table if present.
		do

		end

	set_item_position (v: EV_WIDGET; a_column, a_row: INTEGER) is
			-- Move `v' to position `a_column', `a_row'.
		do

		end

	item_column_span (widget: EV_WIDGET): INTEGER is
			-- `Result' is number of columns taken by `widget'.
		do

		end

	item_row_span (widget: EV_WIDGET): INTEGER is
			--  `Result' is number of rows taken by `widget'.
		do
		end

	item_row_position (widget: EV_WIDGET): INTEGER is
			-- Result is row coordinate of 'widget'
		do

		end

	item_column_position (widget: EV_WIDGET): INTEGER is
			-- Result is column coordinate of 'widget'
		do

		end

feature {EV_ANY_I, EV_ANY} -- Status Settings

	resize (a_column, a_row: INTEGER) is
		do


		end

	set_item_span (v: EV_WIDGET; column_span, row_span: INTEGER) is
			-- Resize 'v' to occupy column span and row span
		do

		end

feature {NONE} -- Externals

--	c_gtk_table_row_spacing (a_table_struct: POINTER): INTEGER is
--			-- Spacing between two rows.
--		external
--			"C [struct <gtk/gtk.h>] (GtkTable): EIF_INTEGER"
--		alias
--			"row_spacing"
--		end
--
--	c_gtk_table_column_spacing (a_table_struct: POINTER): INTEGER is
--			-- Spacing between two columns.
--		external
--			"C [struct <gtk/gtk.h>] (GtkTable): EIF_INTEGER"
--		alias
--			"column_spacing"
--		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TABLE;


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




end -- class EV_TABLE_IMP

