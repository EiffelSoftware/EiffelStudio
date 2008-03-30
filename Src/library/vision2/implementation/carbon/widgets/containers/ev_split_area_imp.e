indexing
	description:
		"EiffelVision Split Area. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SPLIT_AREA_IMP

inherit
	EV_SPLIT_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			initialize,
			on_event,
			child_has_resized,
			setup_layout,
			bounds_changed
		end

	HIOBJECT_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	CGGEOMETRY_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end
	HIGEOMETRY_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end



feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		local
			control_ptr : POINTER
			rect : RECT_STRUCT
			err : INTEGER
		do
			base_make( an_interface )
			create rect.make_new_unshared
			rect.set_top ( 0)
			rect.set_left ( 0 )
			rect.set_right ( 100 )
			rect.set_bottom ( 100 )
			err := create_user_pane_control_external ( null, rect.item, {CONTROLS_ANON_ENUMS}.kControlSupportsEmbedding, $control_ptr )

			event_id := app_implementation.get_id (current)  --getting an id from the application
			set_c_object (control_ptr)
		end

	initialize is
		local
			event_array : EVENT_TYPE_SPEC_ARRAY
			target, h_ret : POINTER
		do
			Precursor {EV_CONTAINER_IMP}
			create event_array.make_new_unshared ( 4 )
			event_array.item ( 0 ).set_eventclass ( {CARBONEVENTS_ANON_ENUMS}.kEventClassControl )
			event_array.item ( 0 ).set_eventkind ( {CARBONEVENTS_ANON_ENUMS}.kEventControlDraw )

			event_array.item ( 1 ).set_eventclass ( {CARBONEVENTS_ANON_ENUMS}.kEventClassControl )
			event_array.item ( 1 ).set_eventkind ( {CARBONEVENTS_ANON_ENUMS}.kEventControlHitTest )

			event_array.item ( 2 ).set_eventclass ( {CARBONEVENTS_ANON_ENUMS}.kEventClassControl )
			event_array.item ( 2 ).set_eventkind ( {CARBONEVENTS_ANON_ENUMS}.kEventControlBoundsChanged )

			event_array.item ( 3 ).set_eventclass ( {CARBONEVENTS_ANON_ENUMS}.kEventClassControl )
			event_array.item ( 3 ).set_eventkind ( {CARBONEVENTS_ANON_ENUMS}.kEventControlTrack )

			target := hiobject_get_event_target_external ( c_object )
			h_ret := app_implementation.install_event_handlers ( event_id, target, event_array )

			-- Create rect wrappers
			create rect_a.make_new_unshared
			create rect_b.make_new_unshared
			create splitter_rect.make_new_unshared

			create rect_a_size.make_shared ( rect_a.size )
			create rect_b_size.make_shared ( rect_b.size )
			create splitter_rect_size.make_shared ( splitter_rect.size )

			create rect_a_origin.make_shared ( rect_a.origin )
			create rect_b_origin.make_shared ( rect_b.origin )
			create splitter_rect_origin.make_shared ( splitter_rect.origin )

			split_ratio := 0.5
		end

feature -- Access

	split_position: INTEGER is
			-- Position from the left/top of the splitter from `Current'.
		do

		end

	set_first (an_item: like item) is
			-- Make `an_item' `first'.
		local
			item_imp: EV_WIDGET_IMP
			err : INTEGER
			old_min_height, old_min_width: INTEGER
		do
			old_min_width := minimum_width
			old_min_height := minimum_height

			item_imp ?= an_item.implementation
			check
				item_imp_not_void : item_imp /= Void
			end
			err := hiview_add_subview_external ( c_object, item_imp.c_object )
			subview_a := item_imp.c_object
			first := an_item
			calculate_rects
			adjust_subviews
			if old_min_width /= minimum_width or old_min_height /= minimum_height then
				child_has_resized (item_imp, minimum_height-old_min_height, minimum_width-old_min_width)
			end
			set_item_resize(first, False)
		end

	set_second (an_item: like item) is
			-- Make `an_item' `second'.
		local
			item_imp: EV_WIDGET_IMP
			err : INTEGER
			old_min_height, old_min_width: INTEGER
		do
			old_min_width := minimum_width
			old_min_height := minimum_height
			item_imp ?= an_item.implementation
			check
				item_imp_not_void : item_imp /= Void
			end
			err := hiview_add_subview_external ( c_object, item_imp.c_object )
			subview_b := item_imp.c_object
			second := an_item
			calculate_rects
			adjust_subviews
			if old_min_width /= minimum_width or old_min_height /= minimum_height then
				child_has_resized (item_imp, minimum_height-old_min_height, minimum_width-old_min_width)
			end
			set_item_resize (second, True)
		end

	prune (an_item: like item) is
			-- Remove `an_item' if present from `Current'.
		local
			item_imp: EV_WIDGET_IMP
			ret : INTEGER
		do
			if has (an_item) and then an_item /= Void then
				item_imp ?= an_item.implementation
				item_imp.set_parent_imp (Void)
				check item_imp_not_void: item_imp /= Void end
				if an_item = first then
					first_expandable := False
					first := Void
					set_split_position (0)
					if second /= Void then
						set_item_resize (second, True)
					end
				else
					second := Void
					second_expandable := True
					if first /= Void then
						set_item_resize (first, True)
					end
				end
				ret := hiview_remove_from_superview_external (item_imp.c_object)
			end
		end

	enable_item_expand (an_item: like item) is
			-- Let `an_item' expand when `Current' is resized.
		do
			set_item_resize (an_item, True)
		end

	disable_item_expand (an_item: like item) is
			-- Make `an_item' non-expandable on `Current' resize.
		do
			set_item_resize (an_item, False)
		end

	set_split_position (a_split_position: INTEGER) is
			-- Set the position of the splitter.
		do

		end

feature {NONE} -- Implementation

	splitter_image: EV_CARBON_CGIMAGE

	ridges_image: EV_CARBON_CGIMAGE

	splitter_width: INTEGER is 8

	split_ratio : REAL_32

	set_item_resize (an_item: like item; a_resizable: BOOLEAN) is
			-- Set whether `an_item' is `a_resizable' when `Current' resizes.
		do
			if an_item = first then
				first_expandable := a_resizable
			else
				second_expandable := a_resizable
			end
		end

	adjust_subviews is
			-- Set the subview sizes according to the rects
		local
			err : INTEGER
			c: EV_CONTAINER_IMP
		do
			err := hiview_set_frame_external ( subview_a.item, rect_a.item )
			err := hiview_set_frame_external ( subview_b.item, rect_b.item )

			if first /= void then
				c ?= first.implementation
				if c /= void then
					c.setup_layout
				end
			end
			if second /= void then
				c ?= second.implementation
				if c /= void then
					c.setup_layout
				end
			end

			err := hiview_set_needs_display_external ( c_object, ( true ).to_integer )

		end

	qdglobal_to_hiview_local ( a_global_point : POINT_STRUCT; dest_view : POINTER ) : CGPOINT_STRUCT is
			-- Convert a global Quickdraw point to a local HIView Point
		local
			view_point : CGPOINT_STRUCT
		do
			create view_point.make_new_unshared
			view_point.set_x ( a_global_point.h )
			view_point.set_y ( a_global_point.v  )
			hipoint_convert_external (view_point.item, {HIGEOMETRY_ANON_ENUMS}.khicoordspace72dpiglobal, default_pointer, {HIGEOMETRY_ANON_ENUMS}.khicoordspaceview, dest_view )
			Result := view_point
		end



feature {NONE} -- Implementation constants

	kSubViewA : INTEGER_16 is unique

	kSubViewB : INTEGER_16 is unique

	kSubViewSplitter : INTEGER_16 is unique

	kControlNoPart : INTEGER_16 is
		once
			Result := ( {CONTROLS_ANON_ENUMS}.kcontrolnopart ).to_integer_16
		end


feature {NONE} -- Implementation

	subview_a : POINTER

	subview_b : POINTER

	rect_a : CGRECT_STRUCT
	rect_a_size : CGSIZE_STRUCT
	rect_a_origin : CGPOINT_STRUCT

	rect_b : CGRECT_STRUCT
	rect_b_size : CGSIZE_STRUCT
	rect_b_origin : CGPOINT_STRUCT

	splitter_rect : CGRECT_STRUCT
	splitter_rect_size : CGSIZE_STRUCT
	splitter_rect_origin : CGPOINT_STRUCT

feature {NONE} -- Implementation

		child_has_resized (a_widget_imp: EV_WIDGET_IMP; a_height, a_width: INTEGER_32) is
			-- propagate it to the top and recalculate minimumsizes
		local
			old_min_height, old_min_width: INTEGER
		do
			old_min_height := minimum_height
			old_min_width := minimum_width
			calculate_minimum_sizes -- to recalculate the minimum sizes
			if parent_imp /= void then
				parent_imp.child_has_resized (current, (minimum_height - old_min_height), (minimum_width - old_min_width))
			end

		end

	calculate_rects is
			-- Calculate the CGRECTS rect_a, rect_b and splitter_rect
		deferred
		end

	setup_layout is
			local
				w: EV_CONTAINER_IMP
			do
				calculate_rects
				adjust_subviews
			end


	on_event (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER is
			-- Feature that is called if an event occurs
		local
			event_class, event_kind : INTEGER_32
			actual_type, actual_size : NATURAL_32
			region, context : POINTER
			err : INTEGER
			where : CGPOINT_STRUCT
			prev_rect, cur_rect : CGRECT_STRUCT
			attributes : NATURAL_32
			part : INTEGER_16
			res : TUPLE[INTEGER,INTEGER_16]
		do
				event_class := get_event_class_external (a_inevent)
				event_kind := get_event_kind_external (a_inevent)

				if event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassControl then
					if event_kind =  {CARBONEVENTS_ANON_ENUMS}.kEventControlDraw then
						err := get_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.kEventParamRgnHandle,{CARBONEVENTS_ANON_ENUMS}.typeQDRgnHandle, $actual_type, sizeof(region.item), $actual_size, region.item )
						err := get_event_parameter_external (a_inevent, {carbonevents_anon_enums}.kEventParamCGContextRef,  {carbonevents_anon_enums}.typeCGContextRef, null, 4, null, $context)
						draw ( region, context )
						err := call_next_event_handler_external (a_inhandlercallref, a_inevent )
						Result := noErr -- event handled
					elseif event_kind =  {CARBONEVENTS_ANON_ENUMS}.kEventControlHitTest then
						create where.make_new_unshared
						err := get_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparammouselocation, {CARBONEVENTS_ANON_ENUMS}.typehipoint, $actual_type, where.sizeof, $actual_size, where.item )
						part := hit_test ( where )
						err := set_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamcontrolpart, {CARBONEVENTS_ANON_ENUMS}.typecontrolpartcode, 2, $part ) -- 2 = sizeof(INTEGER_16)
						Result := noErr --event handled
					elseif event_kind = {CARBONEVENTS_ANON_ENUMS}.keventcontroltrack then
						res := track ( a_inevent )
						Result := res.integer_32_item (1)
						part := res.integer_16_item(2)
						err := set_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamcontrolpart, {CARBONEVENTS_ANON_ENUMS}.typecontrolpartcode, 2, $part ) -- 2 = sizeof(INTEGER_16)
					elseif event_kind =  {CARBONEVENTS_ANON_ENUMS}.keventcontrolboundschanged then
						create prev_rect.make_new_unshared
						create cur_rect.make_new_unshared
						err := get_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamattributes, {AEDATA_MODEL_ANON_ENUMS}.typeWildCard, $actual_type, 4, $actual_size, $attributes ) -- 4 = sizeof(INTEGER_32)
						err := get_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamoriginalbounds, {CARBONEVENTS_ANON_ENUMS}.typehirect, $actual_type, prev_rect.sizeof, $actual_size, prev_rect.item )
						err := get_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamcurrentbounds, {CARBONEVENTS_ANON_ENUMS}.typehirect, $actual_type, cur_rect.sizeof, $actual_size, cur_rect.item )
						bounds_changed ( attributes, prev_rect, cur_rect )
						Result := noErr -- Event handled
					end
				else
					Result := {CARBON_EVENTS_CORE_ANON_ENUMS}.eventnothandlederr
				end
		end

feature {NONE} -- Implementation

	bounds_changed ( options : NATURAL_32; original_bounds, current_bounds : CGRECT_STRUCT ) is
			-- Handler for the bounds changed event
		do
			calculate_rects
			adjust_subviews
		end

	draw ( limit_rgn, context : POINTER ) is
			-- Draw the splitter
		local
			ret: INTEGER
			ridges_rect: CGRECT_STRUCT
			ridges_rect_origin: CGPOINT_STRUCT
			ridges_rect_size: CGSIZE_STRUCT
		do
			calculate_rects
			ret := hiview_draw_cgimage_external (context, splitter_rect.item, splitter_image.item)
			create ridges_rect.make_new_unshared
			create ridges_rect_origin.make_shared (ridges_rect.origin)
			create ridges_rect_size.make_shared (ridges_rect.size)
			ridges_rect_origin.set_x ((splitter_rect_origin.x + splitter_rect_size.width / 2 - ridges_image.width / 2).rounded)
			ridges_rect_origin.set_y ((splitter_rect_origin.y + splitter_rect_size.height / 2 - ridges_image.height / 2).rounded)
			ridges_rect_size.set_width (ridges_image.width)
			ridges_rect_size.set_height (ridges_image.height)
			ret := hiview_draw_cgimage_external (context, ridges_rect.item, ridges_image.item)
		end

	hit_test ( where : CGPOINT_STRUCT ) : INTEGER_16 is
			-- Check to see if a point hits the view
		do
			calculate_rects
			if cgrect_contains_point_external ( rect_a.item, where.item ).to_boolean then
				Result := ksubviewa
			elseif cgrect_contains_point_external ( rect_b.item, where.item ).to_boolean then
				Result := ksubviewb
			elseif cgrect_contains_point_external ( splitter_rect.item, where.item ).to_boolean then
				Result := ksubviewsplitter
			else
				Result := kcontrolnopart
			end
		end

	track ( event :POINTER ) : TUPLE[INTEGER, INTEGER_16] is
			-- Tracking event handler
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_SPLIT_AREA;

indexing
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_SPLIT_AREA_IMP

