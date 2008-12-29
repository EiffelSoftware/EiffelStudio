note
	description: "Eiffel Vision scrollable area. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCROLLABLE_AREA_IMP

inherit
	EV_SCROLLABLE_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color,
			set_item_width,
			set_item_height
		redefine
			interface
		end

	EV_VIEWPORT_IMP
		redefine
			interface,
			make,
			child_has_resized,
			on_event,
			initialize,
			replace,
			child_offset_right,
			child_offset_bottom,
			setup_layout
		end

	HIVIEW_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create scrollable area.
		local
			ptr: POINTER
			ret: INTEGER
			l_fixed: EV_FIXED
			a_widget: EV_WIDGET_IMP
			point: CGPOINT_STRUCT
			size: CGSIZE_STRUCT
			rect: CGRECT_STRUCT
			a_rect: RECT_STRUCT
		do
			base_make (an_interface)

			create point.make_new_unshared
			create rect.make_new_unshared
			create size.make_new_unshared

			size.set_height (20)
			size.set_width (80)

			rect.set_origin (point.item)
			rect.set_size (size.item)

			ret := hiscroll_view_create_external ({HIVIEW_ANON_ENUMS}.kHIScrollViewOptionsVertScroll.bit_or ({HIVIEW_ANON_ENUMS}.kHIScrollViewOptionsHorizScroll), $ptr)
			ret := hiview_set_visible_external (ptr, 1)
			ret := hiscroll_view_set_scroll_bar_auto_hide_external (ptr, 1)
			set_c_object (ptr)
			ret := hiview_set_frame_external (c_object, rect.item)

			--ret := hiscroll_view_set_scroll_bar_auto_hide_external (c_object, 1)


			create a_rect.make_new_unshared
			a_rect.set_left (0)
			a_rect.set_right (0)
			a_rect.set_bottom (0)
			a_rect.set_top (0)

			ret := create_user_pane_control_external ( null, a_rect.item, {CONTROLS_ANON_ENUMS}.kControlSupportsEmbedding, $viewport )
			ret := hiview_set_visible_external (viewport, 1)
			ret := hiview_set_frame_external (viewport, rect.item)
			ret := hiview_add_subview_external (c_object, viewport)
			setup_binding (viewport)


			a_rect.set_left (0)
			a_rect.set_right (1)
			a_rect.set_bottom (1)
			a_rect.set_top (0)
			ret := create_user_pane_control_external ( null, a_rect.item, {CONTROLS_ANON_ENUMS}.kControlSupportsEmbedding, $container )
			ret := hiview_set_visible_external (container, 1)
			size.set_height (1)
			size.set_width (1)

			rect.set_origin (point.item)
			rect.set_size (size.item)
			ret := hiview_set_frame_external (container, rect.item)
			ret := hiview_add_subview_external (viewport, container)

			event_id := app_implementation.get_id (current)

			set_horizontal_step (20)
			set_vertical_step (20)
		end


feature -- Access

	child_offset_right: INTEGER
			do
				Result := 0
			end

	child_offset_bottom: INTEGER
			do
				Result := 0
			end


	initialize
			local
				h_ret, target: POINTER
				 event_array : EVENT_TYPE_SPEC_ARRAY
			do
				Precursor {EV_VIEWPORT_IMP}

				target := get_control_event_target_external( viewport )

				create event_array.make_new_unshared ( 2)
				event_array.item ( 0 ).set_eventclass (kEventClassScrollable)
				event_array.item ( 0 ).set_eventkind (kEventScrollableGetInfo)
				event_array.item ( 1 ).set_eventclass (kEventClassScrollable)
				event_array.item ( 1 ).set_eventkind (kEventScrollableScrollTo)

				h_ret := app_implementation.install_event_handlers ( event_id, target, event_array )

			end

	replace (v: like item)
			local
				a_event: POINTER
				ret: INTEGER
			do
				precursor {EV_VIEWPORT_IMP} (v)
				ret := create_event_external (null, kEventClassScrollable, kEventScrollableInfoChanged, 0, kEventAttributeUserEvent, $a_event)
				ret := send_event_to_event_target_external (a_event, get_control_event_target_external (c_object))
				release_event_external (a_event)
			end

	setup_layout
			local
				a_event: POINTER
				ret: INTEGER
			do
				precursor {EV_VIEWPORT_IMP}
				ret := create_event_external (null, kEventClassScrollable, kEventScrollableInfoChanged, 0, kEventAttributeUserEvent, $a_event)
				ret := send_event_to_event_target_external (a_event, get_control_event_target_external (c_object))
				release_event_external (a_event)
			end



	horizontal_step: INTEGER

	vertical_step: INTEGER

	is_horizontal_scroll_bar_visible: BOOLEAN
			-- Should horizontal scroll bar be displayed?
		do
		end

	is_vertical_scroll_bar_visible: BOOLEAN
			-- Should vertical scroll bar be displayed?
		do
		end

feature -- Element change

	set_horizontal_step (a_step: INTEGER)
			-- Set `horizontal_step' to `a_step'.
		do
			horizontal_step := a_step
		end

	set_vertical_step (a_step: INTEGER)
			-- Set `vertical_step' to `a_step'.
		do
			vertical_step := a_step
		end

	show_horizontal_scroll_bar
			-- Display horizontal scroll bar.
		do
		end

	hide_horizontal_scroll_bar
			-- Do not display horizontal scroll bar.
		do
		--	print (hiview_count_subviews_external (c_object).out + "%N")
		end

	show_vertical_scroll_bar
			-- Display vertical scroll bar.
		do
		end

	hide_vertical_scroll_bar
			-- Do not display vertical scroll bar.
		do
		end

feature {NONE} -- Implementation
		on_event (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER
			-- Feature that is called if an event occurs
		local
			event_class, event_kind : INTEGER
			ret : INTEGER
			point, viewport_point: CGPOINT_STRUCT
			size: CGSIZE_STRUCT
			rect: CGRECT_STRUCT
			ptr: POINTER
		do
				event_class := get_event_class_external (a_inevent)
				event_kind := get_event_kind_external (a_inevent)
				if event_kind = kEventScrollableGetInfo then
					create rect.make_new_unshared
					ret := hiview_get_frame_external (container, rect.item)

					create size.make_shared (rect.size)
					ret := set_event_parameter_external (a_inevent, kEventParamImageSize,  {CARBONEVENTS_ANON_ENUMS}.typehisize, size.sizeof, size.item)

					size.set_height (vertical_step)
					size.set_width (horizontal_step)
					ret := set_event_parameter_external (a_inevent, kEventParamLineSize,  {CARBONEVENTS_ANON_ENUMS}.typehisize, size.sizeof, size.item)

					ret := hiview_get_frame_external (viewport, rect.item)
					create size.make_shared (rect.size)
					create point.make_shared (rect.origin)
					ret := set_event_parameter_external (a_inevent, kEventParamViewSize, {CARBONEVENTS_ANON_ENUMS}.typehisize, size.sizeof, size.item)
					ret := set_event_parameter_external (a_inevent, kEventParamOrigin, {CARBONEVENTS_ANON_ENUMS}.typehipoint, point.sizeof, point.item)

					Result := {EV_ANY_IMP}.noErr -- event handled
				elseif event_kind = kEventScrollableScrollTo then
					create point.make_new_unshared
					ret := get_event_parameter_external (a_inevent, kEventParamOrigin, {CARBONEVENTS_ANON_ENUMS}.typehipoint, null, point.sizeof, NULL, point.item );

					ret := hiview_set_bounds_origin_external (container, point.x, point.y)
					ret := hiview_set_needs_display_external (container, 1)

					Result := {EV_ANY_IMP}.noErr -- event handled
				else

					Result := {CARBON_EVENTS_CORE_ANON_ENUMS}.eventnothandlederr
				end
		end

	frozen kEventScrollableInfoChanged: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kEventScrollableInfoChanged"
	end

	frozen kEventAttributeUserEvent: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kEventAttributeUserEvent"
	end

	frozen kEventClassScrollable: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kEventClassScrollable"
	end

	frozen kEventScrollableScrollTo: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kEventScrollableScrollTo"
	end

	frozen kEventScrollableGetInfo: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kEventScrollableGetInfo"
	end

	frozen kEventParamLineSize: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kEventParamLineSize"
	end

	frozen kEventParamImageSize: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kEventParamImageSize"
	end

	frozen kEventParamViewSize: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kEventParamViewSize"
	end

	frozen kEventParamOrigin: INTEGER
	external
		"C inline use <Carbon/Carbon.h>"
	alias

		"kEventParamOrigin"
	end

		setup_binding (a_control : POINTER)
			-- Binds the viewport to the scroll bars
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					HILayoutInfo LayoutInfo;
					LayoutInfo.version = kHILayoutInfoVersionZero;
					HIViewGetLayoutInfo ($a_control, &LayoutInfo);
					
					LayoutInfo.binding.top.toView = NULL;
					LayoutInfo.binding.top.kind = kHILayoutBindTop;
					LayoutInfo.binding.top.offset = 0;
					
					LayoutInfo.binding.bottom.toView = NULL;
					LayoutInfo.binding.bottom.kind = kHILayoutBindBottom;
					LayoutInfo.binding.bottom.offset = 10;
					
					LayoutInfo.binding.left.toView = NULL;
					LayoutInfo.binding.left.kind = kHILayoutBindLeft;
					LayoutInfo.binding.left.offset = 0;
					
					LayoutInfo.binding.right.toView = NULL;
					LayoutInfo.binding.right.kind = kHILayoutBindRight;
					LayoutInfo.binding.right.offset = 10;
					
					HIViewSetLayoutInfo( $a_control, &LayoutInfo );
					HIViewApplyLayout( $a_control );
				}
			]"
		end

	fixed_widget: POINTER

	fixed_height: INTEGER
			-- Fixed Vertical size measured in pixels.
		do
		end

	on_size_allocate (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Set item in center of `Current' if smaller.
		do
		end

	child_has_resized (item_imp: EV_WIDGET_IMP; a_height, a_width: INTEGER_32)
			-- If child has resized and smaller than parent then set position in center of `Current'.
		local
			a: CGSIZE_STRUCT
			a_event: POINTER
			ret: INTEGER
		do
			--internal_set_container_size (item_imp.minimum_height, item_imp.minimum_width)

			precursor {EV_VIEWPORT_IMP} (item_imp, a_height, a_width)

			ret := create_event_external (null, kEventClassScrollable, kEventScrollableInfoChanged, 0, kEventAttributeUserEvent, $a_event)
			ret := send_event_to_event_target_external (a_event, get_control_event_target_external (c_object))
			release_event_external (a_event)

		end


	horizontal_policy: INTEGER
		-- Policy type used for the horizontal scrollbar (ALWAYS, AUTOMATIC or NEVER)

	vertical_policy: INTEGER
		-- Policy type used for the vertical scrollbar (ALWAYS, AUTOMATIC or NEVER)

	set_scrolling_policy (hscrollpol, vscrollpol: INTEGER)
			-- Set the policy for both scrollbars.
		do
		end

feature {EV_ANY_I} -- Implementation		

	interface: EV_SCROLLABLE_AREA;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_SCROLLABLE_AREA_IMP

