
note
	description:
		"Eiffel Vision fixed. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIXED_IMP

inherit
	EV_FIXED_I
		redefine
			interface
		end

	EV_WIDGET_LIST_IMP
		undefine
			propagate_background_color,
			propagate_foreground_color
		redefine
			interface,
			insert_i_th,
			initialize,
			child_has_resized
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
	HIVIEW_FUNCTIONS_EXTERNAL

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create the fixed container.
		local
			control_ptr : POINTER
			rect : RECT_STRUCT
			res : INTEGER
		do
			base_make( an_interface )
			create rect.make_new_unshared
			rect.set_top ( 0 )
			rect.set_left ( 0 )
			rect.set_right ( 0 )
			rect.set_bottom ( 0 )
			res := create_user_pane_control_external ( default_pointer, rect.item, {CONTROLS_ANON_ENUMS}.kControlSupportsEmbedding, $control_ptr )

			set_c_object ( control_ptr )
		end

	initialize
			-- Initialize `Current'.
		do
			Precursor
			event_id := app_implementation.get_id (current)
		end

feature -- Status setting

	set_item_position (a_widget: EV_WIDGET; an_x, a_y: INTEGER)
			-- Set `a_widget.x_position' to `an_x'.
			-- Set `a_widget.y_position' to `a_y'.
		local
			w_imp : EV_WIDGET_IMP
			err : INTEGER
			old_minimum_height, old_minimum_width : INTEGER
		do
			old_minimum_height := minimum_height
			old_minimum_width := minimum_width
			w_imp ?= a_widget.implementation
			check
				w_imp_not_void : w_imp /= Void
			end
			err := hiview_place_in_superview_at_external ( w_imp.c_object, an_x, a_y )
			calculate_minimum_sizes
			if old_minimum_height /= minimum_height or old_minimum_width /= minimum_width then
				child_has_resized (current, (minimum_height - old_minimum_height), (minimum_width -old_minimum_width))
			end
		end

	set_item_size (a_widget: EV_WIDGET; a_width, a_height: INTEGER)
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			w_imp : EV_WIDGET_IMP
		do
			w_imp ?= a_widget.implementation
			check
				w_imp_not_void : w_imp /= Void
			end
			size_control_external( w_imp.c_object, a_width, a_height )
		end

feature -- Measurement

	minimum_width: INTEGER
			-- Item edge with highest x value
		do
			Result := buffered_minimum_width
		end

	minimum_height: INTEGER
			-- Item edge with highest x value
		do
			Result := buffered_minimum_height
		end

	calculate_minimum_sizes
			-- Item edge with highest y value
		do
			from
				start
				buffered_minimum_height := 0
				buffered_minimum_width := 0
			until
				off
			loop
				buffered_minimum_height := buffered_minimum_height.max ( item.y_position + item.height )
				buffered_minimum_width := buffered_minimum_width.max (item.x_position + item.width)
				forth
			end
		end

	child_has_resized (a_widget_imp: EV_WIDGET_IMP; a_height, a_width: INTEGER)
			-- propagate it to the top (or if we could resize, resize)
			-- calculate minimum sizes for containers with just one element
		local
			a_widget: EV_WIDGET_IMP
			old_min_height, old_min_width: INTEGER
		do
			old_min_height := minimum_height
			old_min_width := minimum_width
			calculate_minimum_sizes
			if parent_imp /= void then
				parent_imp.child_has_resized (current, (minimum_height - old_min_height), (minimum_width - old_min_width))
			else
				setup_layout
			end

		end

feature {EV_ANY_I} -- Implementation

	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		do
			Precursor ( v, i )
			set_item_position ( v, 0, 0 )
			set_item_size ( v, v.minimum_width, v.minimum_height )
		end



	x_position_of_child (a_widget_imp: EV_WIDGET_IMP): INTEGER
			-- X position of `a_widget_imp' within `Current'.
		local
			rect : CGRECT_STRUCT
			origin : CGPOINT_STRUCT
			err : INTEGER
		do
			create rect.make_new_unshared
			create origin.make_shared ( rect.origin )
			err := hiview_get_frame_external ( a_widget_imp.c_object, rect.item )
			Result := origin.x.rounded
		end

	y_position_of_child (a_widget_imp: EV_WIDGET_IMP): INTEGER
			-- Y position of `a_widget_imp' within `Current'.
		local
			rect : CGRECT_STRUCT
			origin : CGPOINT_STRUCT
			err : INTEGER
		do
			create rect.make_new_unshared
			create origin.make_shared ( rect.origin )
			err := hiview_get_frame_external ( a_widget_imp.c_object, rect.item )
			Result := origin.y.rounded
		end

	interface: EV_FIXED;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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




end -- class EV_FIXED

