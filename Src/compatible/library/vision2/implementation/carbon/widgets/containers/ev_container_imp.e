note
	description:
		"Eiffel Vision container, Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "container"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CONTAINER_IMP

inherit
	EV_CONTAINER_I
		redefine
			interface,
			propagate_foreground_color,
			propagate_background_color
		end

	EV_WIDGET_IMP
		redefine
			interface,
			initialize,
			destroy,
			set_parent_imp,
			minimum_width,
			minimum_height,
			on_event
		end

	EV_CONTAINER_ACTION_SEQUENCES_IMP

	CONTROLS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	PLATFORM

feature {NONE} -- Initialization

	initialize
			-- Initialize `Current'
		local
			target, h_ret: POINTER
		do
			Precursor {EV_WIDGET_IMP}
			event_id := app_implementation.get_id (current)
			target := get_control_event_target_external( c_object )
			--h_ret := app_implementation.install_event_handler ( event_id, target, {CARBONEVENTS_ANON_ENUMS}.keventclasscontrol, {CARBONEVENTS_ANON_ENUMS}.keventcontrolboundschanged )
		end

feature -- Access

	client_width: INTEGER
			-- Width of the client area of container.
			-- Redefined in children.
		do
			Result := width - child_offset_left - child_offset_right
		end

	client_height: INTEGER
			-- Height of the client area of container
			-- Redefined in children.
		do
			Result := height - child_offset_top - child_offset_bottom
		end

	background_pixmap: EV_PIXMAP
			-- the background pixmap

feature -- Element change

	replace (v: like item)
			-- Replace `item' with `v'.
		deferred

		end

		child_offset_top: INTEGER
				-- The offset a child needs to have from this type of container
			do
				Result := 2
			end


		setup_layout
			local
				w: EV_WIDGET_IMP
				c: EV_CONTAINER_IMP
			do

				if item /= void  then
						layout
						w ?= item.implementation
						check
							has_imp: w /= void
						end

						c ?= w
						if c /= void then
							c.setup_layout
						end

				end
			end


		layout
				-- Sets the child control's size to the container site minus some spacing
		local
			a_rect : CGRECT_STRUCT
			a_size : CGSIZE_STRUCT
			a_point : CGPOINT_STRUCT
			ret: INTEGER
			a_widget : EV_WIDGET_IMP
		do
				a_widget := temp_item
				if a_widget = void and then item /= void then
					a_widget ?= item.implementation
				end
					check
						no_imp: a_widget /= void
					end

				-- Get initial positions right
				create a_rect.make_new_unshared
				create a_size.make_shared ( a_rect.size )
				create a_point.make_shared ( a_rect.origin )

				a_point.set_x (child_offset_right)
				a_point.set_y (child_offset_top)
				a_size.set_width (width - (child_offset_right + child_offset_left))
				a_size.set_height (height - child_offset_bottom - child_offset_top)
				ret := hiview_set_frame_external (a_widget.c_object, a_rect.item)

				setup_automatic_layout (a_widget.c_object, c_object, child_offset_top, child_offset_bottom, child_offset_right, child_offset_left)

			temp_item := void
		end

		setup_automatic_layout (a_control, a_container: POINTER; offset_top, offset_bottom, offset_right, offset_left: INTEGER)
				-- Make the child follow it's parent when it's reszed
			external
				"C inline use <Carbon/Carbon.h>"
			alias
				"[
					{
						HILayoutInfo LayoutInfo;
						LayoutInfo.version = kHILayoutInfoVersionZero;
						HIViewGetLayoutInfo ( $a_control, &LayoutInfo );
						
						LayoutInfo.binding.left.toView = $a_container;
						LayoutInfo.binding.left.kind = kHILayoutBindLeft;
						LayoutInfo.binding.left.offset = $offset_left;
						
						LayoutInfo.binding.right.toView = $a_container;
						LayoutInfo.binding.right.kind = kHILayoutBindRight;
						LayoutInfo.binding.right.offset = $offset_right;
						
						LayoutInfo.binding.top.toView = $a_container;
						LayoutInfo.binding.top.kind = kHILayoutBindTop;
						LayoutInfo.binding.top.offset = $offset_top;
						
						LayoutInfo.binding.bottom.toView = $a_container;
						LayoutInfo.binding.bottom.kind = kHILayoutBindBottom;
						LayoutInfo.binding.bottom.offset = $offset_bottom;
						
					//	LayoutInfo.scale.x.toView = $a_container;
					//	LayoutInfo.scale.x.kind = kHILayoutScaleAbsolute;
					//	LayoutInfo.scale.x.ratio = 1.0;
						
					//	LayoutInfo.scale.y.toView = $a_container;
					//	LayoutInfo.scale.y.kind = kHILayoutScaleAbsolute;
					//	LayoutInfo.scale.y.ratio = 1.0;
						
						
						HIViewSetLayoutInfo( $a_control, &LayoutInfo );
						HIViewApplyLayout( $a_control );
					}
				]"
			end
feature -- Measurement

	minimum_width: INTEGER
			-- If not set otherwise, the minimum width of a container is equal to the minimum width of 'item'
		do
			Result := buffered_minimum_width
		end

	minimum_height: INTEGER
			-- If not set otherwise, the minimum height of a container is equal to the minimum height of 'item'
		do
			Result := buffered_minimum_height
		end

	child_offset_bottom: INTEGER
	do
		Result := 2
	end

	child_offset_right: INTEGER
	do
		Result := 2
	end

	child_offset_left: INTEGER
	do
		Result := 2
	end

	buffered_minimum_width: INTEGER
	buffered_minimum_height: INTEGER
	temp_item: EV_WIDGET_IMP -- ueli: this is ugly. i know.

feature -- Status setting

	connect_radio_grouping (a_container: EV_CONTAINER)
			-- Join radio grouping of `a_container' to `Current'.
		do
		end

	unconnect_radio_grouping (a_container: EV_CONTAINER)
			-- Remove Join of `a_container' to radio grouping of `Current'.
		do
		end

	add_radio_button (a_widget_imp: EV_WIDGET_IMP)
			-- Called every time a widget is added to the container.
		require
			a_widget_imp_not_void: a_widget_imp /= Void
		do
		end

	remove_radio_button (a_widget_imp: EV_WIDGET_IMP)
			-- Called every time a widget is removed from the container.
		require
			a_widget_imp_not_void: a_widget_imp /= Void
		do
		end

	internal_set_background_pixmap (a_pixmap: EV_PIXMAP)
			-- Set the container background pixmap to `pixmap'.
		do
		end

	set_background_pixmap (a_pixmap: EV_PIXMAP)
			-- Set the container background pixmap to `pixmap'.
		do
		end

	bg_pixmap (p: POINTER): POINTER
		do
		end

	remove_background_pixmap
			-- Make background pixmap Void.
		do
		end

feature -- Basic operations

	propagate_foreground_color
			-- Propagate the current foreground color of the
			-- container to the children.
		do
			--precursor {EV_CONTAINER_PI}

		end

	propagate_background_color
			-- Propagate the current background color of the
			-- container to the children.
		do
			Precursor {EV_CONTAINER_I}
			propagate_background_color_internal (background_color, c_object)
		end

feature -- Command

	destroy
			-- Render `Current' unusable.
		do
--			if interface.prunable then
--				interface.wipe_out
--			end
			Precursor {EV_WIDGET_IMP}
		end

feature -- Event handling

	on_new_item (an_item_imp: EV_WIDGET_IMP)
			-- Called after `an_item' is added.
		do
			an_item_imp.set_parent_imp (Current)
		end

	on_removed_item (an_item_imp: EV_WIDGET_IMP)
			-- Called just before `an_item' is removed.
		do
			an_item_imp.set_parent_imp (Void)
		end


feature {EV_WIDGET_IMP} -- Implementation

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

	calculate_minimum_sizes
			deferred
			end



	set_parent_imp (a_parent_imp: EV_CONTAINER_IMP)
			--
		do
			Precursor {EV_WIDGET_IMP} (a_parent_imp)
			if background_pixmap /= Void and parent_imp = Void then
				-- We need to reref the background pixmap as gtk doesn't handle it properly
				-- on removal from parent of Current.
				internal_set_background_pixmap (background_pixmap)
			end
		end

	bounds_changed ( options : NATURAL_32; original_bounds, current_bounds : CGRECT_STRUCT )
			-- Handler for the bounds changed event
		local
			a_rect : CGRECT_STRUCT
			a_size : CGSIZE_STRUCT
			a_point : CGPOINT_STRUCT
			ret: INTEGER
			current_size: CGSIZE_STRUCT
			w: EV_WIDGET_IMP
		do
			if not interface.is_empty then
				w ?= interface.item.implementation
				check
					item_has_implementation: w /= Void
				end
				-- Get initial positions right
				create a_rect.make_new_unshared
				create a_size.make_shared ( a_rect.size )
				create a_point.make_shared ( a_rect.origin )
				create current_size.make_unshared (current_bounds.size)

				a_point.set_x (child_offset_right)
				a_point.set_y (child_offset_top)
				a_size.set_width (width - (child_offset_right + child_offset_left))
				a_size.set_height (height - child_offset_bottom - child_offset_top)
				ret := hiview_set_frame_external (w.c_object, a_rect.item)
			end
		end

	on_event (a_inhandlercallref, a_inevent, a_inuserdata: POINTER ) : INTEGER
			-- Called when a Carbon event arrives
		local
			event_class, event_kind : INTEGER_32
			actual_type, actual_size : NATURAL_32
			prev_rect, cur_rect :CGRECT_STRUCT
			attributes : NATURAL_32
			err : INTEGER
		do
			event_class := get_event_class_external (a_inevent)
			event_kind := get_event_kind_external (a_inevent)

			if event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassControl and event_kind =  {CARBONEVENTS_ANON_ENUMS}.keventcontrolboundschanged then
				create prev_rect.make_new_unshared
				create cur_rect.make_new_unshared
				err := get_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamattributes, {AEDATA_MODEL_ANON_ENUMS}.typeWildCard, $actual_type, 4, $actual_size, $attributes ) -- 4 = sizeof(INTEGER_32)
				err := get_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamoriginalbounds, {CARBONEVENTS_ANON_ENUMS}.typehirect, $actual_type, prev_rect.sizeof, $actual_size, prev_rect.item )
				err := get_event_parameter_external ( a_inevent, {CARBONEVENTS_ANON_ENUMS}.keventparamcurrentbounds, {CARBONEVENTS_ANON_ENUMS}.typehirect, $actual_type, cur_rect.sizeof, $actual_size, cur_rect.item )
				bounds_changed ( attributes, prev_rect, cur_rect )
				Result := noErr -- Event handled
			else
				Result := Precursor(a_inhandlercallref, a_inevent, a_inuserdata)
			end
		end


feature {EV_ANY_I} -- Implementation

	interface: EV_CONTAINER;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_CONTAINER_IMP

