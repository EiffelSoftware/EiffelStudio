note
	description: "Eiffel Vision viewport. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VIEWPORT_IMP

inherit
	EV_VIEWPORT_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface,
			set_item_width,
			set_item_height
		end

	EV_CELL_IMP
		redefine
			interface,
			make,
			on_removed_item,
			replace,
			setup_layout,
			child_has_resized,
			minimum_width,
			minimum_height
		end

	HIVIEW_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Initialize.
		local
			ret: INTEGER
			rect: RECT_STRUCT
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_left (0)
			rect.set_right (0)
			rect.set_bottom (0)
			rect.set_top (0)

			ret := create_user_pane_control_external ( null, rect.item, {CONTROLS_ANON_ENUMS}.kControlSupportsEmbedding, $viewport )
			set_c_object ( viewport )

			rect.set_left (0)
			rect.set_right (0)
			rect.set_bottom (0)
			rect.set_top (0)
			ret := create_user_pane_control_external ( null, rect.item, {CONTROLS_ANON_ENUMS}.kControlSupportsEmbedding, $container )

			ret := hiview_set_visible_external (viewport, (true).to_integer)
			ret := hiview_set_visible_external (container, (true).to_integer)
			ret := hiview_add_subview_external (viewport, container)

		end

feature -- Access

	x_offset: INTEGER
			-- Horizontal position of viewport relative to `item'.
		do
		end

	y_offset: INTEGER
			-- Vertical position of viewport relative to `item'.
		do
		end

feature -- Element change

	replace (v: like item)
			-- Replace `item' with `v'.
		local
			w: EV_WIDGET_IMP
			old_item: EV_WIDGET_IMP
			ret: INTEGER
			root_control_ptr: POINTER
			cfstring: EV_CARBON_CF_STRING
			point: CGPOINT_STRUCT
			c_size, v_size: CGSIZE_STRUCT
			c_rect, v_rect: CGRECT_STRUCT
		do
			create c_rect.make_new_unshared
			create v_rect.make_new_unshared
			ret := hiview_get_frame_external (container, c_rect.item)
			create c_size.make_shared (c_rect.size)
			create v_size.make_shared (v_rect.size)

			if not interface.is_empty then
				--remove old item
				check
					item_has_implementation: w /= Void
				end
				w ?= interface.item.implementation
				old_item ?= item.implementation

			--	unset_child_size (w.c_object, container)
				on_removed_item (w)

				ret := hiview_remove_from_superview_external (w.c_object)

				check
					view_removed: ret = 0
				end

				item := void
				c_size.set_height (height - child_offset_bottom - child_offset_top)
				c_size.set_width (width - child_offset_left - child_offset_right)
				ret := hiview_set_frame_external (container, c_rect.item)
				--setup_layout
			end

			if v /= Void then
				--adding v
				w ?= v.implementation

				ret := hiview_get_frame_external (w.c_object, v_rect.item)

				--rect.set_size (v_rect.size.item)
				c_size.set_height (w.minimum_height.max (height - child_offset_bottom - child_offset_top))
				c_size.set_width (w.minimum_width.max (width - child_offset_left - child_offset_right))


				ret := hiview_set_frame_external (container, c_rect.item)
				ret := hiview_add_subview_external ( container, w.c_object )

				--alligne_to_child_size (w.c_object, container )
			--	setup_automatic_layout (w.c_object, container, child_offset_top, child_offset_bottom, child_offset_right, child_offset_left)
				check
					view_added: ret = 0
				end

				--setup_layout

				on_new_item (w)
				item := v
			end
			setup_layout
		end

	child_has_resized (a_widget_imp: EV_WIDGET_IMP; a_height, a_width: INTEGER_32)
			--
		do
			setup_layout
		end

	setup_layout

				-- set the container size to at least the size of the viewport
				-- Sets the child control's size to the container size minus some spacing

				--!!!!!!!!! Implement spacing and find bug!
		local
			v_rect, c_rect, child_rect : CGRECT_STRUCT
			v_size, c_size, child_size : CGSIZE_STRUCT
			c_point : CGPOINT_STRUCT
			ret: INTEGER
			a_widget: EV_WIDGET_IMP
			c: EV_CONTAINER_IMP
		do
			create v_rect.make_new_unshared
			create c_rect.make_new_unshared
			create child_rect.make_new_unshared
			create v_size.make_shared ( v_rect.size )
			create c_size.make_shared ( c_rect.size )
			create child_size.make_shared ( child_rect.size )

			-- Get initial positions right
			ret := hiview_get_frame_external (viewport, v_rect.item)
			ret := hiview_get_frame_external (container, c_rect.item)

			if item /= void then
				a_widget ?= item.implementation
				check
					has_implementation: a_widget /= void
				end

				ret := hiview_get_frame_external (a_widget.c_object, child_rect.item)

				c_size.set_height ((v_size.height - child_offset_bottom - child_offset_top).max(a_widget.minimum_height))
				c_size.set_width ((v_size.width - child_offset_left - child_offset_right ).max(a_widget.minimum_width))

				if a_widget.expandable then
					child_size.set_width (c_size.width)
					child_size.set_height (c_size.height)
				else
					child_size.set_width (a_widget.minimum_width)
					child_size.set_height (a_widget.minimum_height)
				end

				ret := hiview_set_frame_external (a_widget.c_object, child_rect.item)
			else
				c_size.set_height (v_size.height)
				c_size.set_width (v_size.width)
			end

			ret := hiview_set_frame_external (container, c_rect.item)

			if c_size.width <= v_size.width or c_size.height <= v_size.height then
				if item /= void then
					c ?= item.implementation
					if c /= void then
						c.setup_layout
					end
				end
			end
		end

	block_resize_actions
			-- Block any resize actions that may occur.
		do
		end

	unblock_resize_actions
			-- Unblock all resize actions.
		do
		end

	set_x_offset (a_x: INTEGER)
			-- Set `x_offset' to `a_x'.
		do
			internal_set_offset (a_x, -1)
		end

	set_y_offset (a_y: INTEGER)
			-- Set `y_offset' to `a_y'.
		do
		 internal_set_offset (-1, a_y)
		end

	set_item_size (a_width, a_height: INTEGER)
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		do
			internal_set_item_size (a_width, a_height)
		end

	set_item_width (a_width: INTEGER)
			-- Set `a_widget.width' to `a_width'.
		do
			internal_set_item_size (a_width, -1)
		end

	set_item_height (a_height: INTEGER)
			-- Set `a_widget.height' to `a_height'.
		do
			internal_set_item_size (-1, a_height)
		end

feature --meassures

	minimum_height: INTEGER
		local
			a,b: INTEGER
		do
			a := internal_minimum_height
			if item /= void then
				b := child_offset_top + child_offset_bottom
			end
			Result := a.max (b)

		end

	minimum_width: INTEGER
		local
			a,b: INTEGER
		do
			a := internal_minimum_width
			if item /= void then
				b := child_offset_left + child_offset_right
			end
			Result := a.max (b)

		end



feature {NONE} -- Implementation

	alligne_to_child_size (a_child ,a_control : POINTER)
			-- Auto allignes the child to its control
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					HILayoutInfo LayoutInfo;
					LayoutInfo.version = kHILayoutInfoVersionZero;
					HIViewGetLayoutInfo ($a_child, &LayoutInfo);
					
					LayoutInfo.scale.x.toView = $a_control;
					LayoutInfo.scale.x.kind = kHILayoutScaleAbsolute;
					LayoutInfo.scale.x.ratio = 1;
					
					LayoutInfo.scale.y.toView = $a_control;
					LayoutInfo.scale.y.kind = kHILayoutScaleAbsolute;
					LayoutInfo.scale.y.ratio = 1;


					HIViewSetLayoutInfo( $a_child, &LayoutInfo );
					HIViewApplyLayout( $a_child );
				}
			]"
		end

	unset_child_size (a_control, a_child : POINTER)
			-- What does this do?
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					HILayoutInfo LayoutInfo;
					LayoutInfo.version = kHILayoutInfoVersionZero;
					HIViewGetLayoutInfo ($a_control, &LayoutInfo);
					
					LayoutInfo.scale.x.toView = $a_child;
					LayoutInfo.scale.x.kind = kHILayoutScaleAbsolute;
					LayoutInfo.scale.x.ratio = 0;
					
					LayoutInfo.scale.y.toView = $a_child;
					LayoutInfo.scale.y.kind = kHILayoutScaleAbsolute;
					LayoutInfo.scale.y.ratio = 0;


					HIViewSetLayoutInfo( $a_control, &LayoutInfo );
					HIViewApplyLayout( $a_control );
				}
			]"
		end

	container_widget: POINTER
			-- Pointer to the event box

	visual_widget: POINTER
			--
		do
		end

	internal_set_offset (a_x, a_y: INTEGER)
		local
			item_width, item_height: INTEGER
			w_imp: EV_WIDGET_IMP
			a_rect: CGRECT_STRUCT
			a_size: CGSIZE_STRUCT
			ret: INTEGER
			rect: RECT_STRUCT
			ptr: POINTER
		do
			create a_rect.make_new_unshared

			ret := hiview_get_frame_external ( c_object, a_rect.item )
			create a_size.make_shared ( a_rect.size )


			create rect.make_new_unshared
			ptr := get_control_bounds_external (c_object, rect.item)
			if ((a_x - a_size.width.rounded) > 0) then
				rect.set_right(a_x - a_size.width.rounded)
				rect.set_left (a_x)
			end
			if ((a_y - a_size.height.rounded) > 0) then
				rect.set_top (a_y - a_size.height.rounded)
				rect.set_bottom(a_y)
			end
			set_control_bounds_external (c_object,rect.item)
		end

	internal_set_container_size (a_height, a_width: INTEGER_32)
		local
			a_rect: CGRECT_STRUCT
			a_size: CGSIZE_STRUCT
			ret: INTEGER_32
			ptr: POINTER
		do
			create a_rect.make_new_unshared
			create a_size.make_shared (a_rect.size)
			ret := hiview_get_frame_external (container, a_rect.item)
			if (a_height > 0) then
				a_size.set_height (a_height)
			end
			if (a_width > 0) then
				a_size.set_width (a_width)
			end
			ret := hiview_set_frame_external (container, a_rect.item)
		end

	internal_set_item_size (a_width, a_height: INTEGER)
			-- Set `a_widget.width' to `a_width'.
			-- Set `a_widget.height' to `a_height'.
		local
			item_width, item_height: INTEGER
			w_imp: EV_WIDGET_IMP
			a_rect: CGRECT_STRUCT
			a_size: CGSIZE_STRUCT
			ret: INTEGER
		do
			create a_rect.make_new_unshared
			ret := hiview_get_frame_external ( c_object, a_rect.item )
			create a_size.make_shared ( a_rect.size )


			if a_width > 0 then
				a_size.set_width (a_width)
			end

			if a_height > 0 then
				a_size.set_height (a_height)
			end

			w_imp ?= item.implementation
			w_imp.store_minimum_size

			a_rect.set_size (a_size.item)

			ret := hiview_set_frame_external (w_imp.c_object, a_rect.item)
		end

	on_removed_item (an_item_imp: EV_WIDGET_IMP)
			-- Reset minimum size.
		do
			an_item_imp.set_parent_imp (Void)
		end

	internal_x_offset, internal_y_offset: INTEGER

	internal_set_value_from_adjustment (l_adj: POINTER; a_value: INTEGER)
			-- Set `value' of adjustment `l_adj' to `a_value'.
		require
			l_adj_not_null: l_adj /= default_pointer
		do

  		end

	viewport: POINTER
			-- Pointer to viewport, used for reuse of adjustment functions from descendants.
	container: POINTER

feature {EV_ANY_I} -- Implementation

	interface: EV_VIEWPORT;

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




end -- class EV_VIEWPORT_IMP

