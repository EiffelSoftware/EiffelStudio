note
	description:
		"Eiffel Vision notebook. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_NOTEBOOK_IMP

inherit
	EV_NOTEBOOK_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface,
			replace
		end

	EV_WIDGET_LIST_IMP
		redefine
			interface,
			replace,
			initialize,
			remove_i_th,
			insert_i_th,
			minimum_width,
			minimum_height,
			on_event,
			layout,
			setup_layout,
			child_has_resized,
			child_offset_bottom,
			child_offset_left,
			child_offset_right,
			child_offset_top
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

	EV_NOTEBOOK_ACTION_SEQUENCES_IMP
		export
			{NONE} all
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CONTROLS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CARBONEVENTS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end


create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a fixed widget.
		local
			err : INTEGER
			rect : RECT_STRUCT
			struct_ptr : POINTER
		do
			base_make (an_interface)
			create rect.make_new_unshared
			rect.set_left(0)
			rect.set_right(0)
			rect.set_bottom(0)
			rect.set_top (0)
			err := create_tabs_control_external ( null, rect.item, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlTabSizeLarge, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlTabDirectionNorth, 0, null, $struct_ptr )
			set_c_object ( struct_ptr )

			event_id := app_implementation.get_id (current)  --getting an id from the application

			tab_position := interface.tab_top
		end

	initialize
			-- Initialize the notebook.
		do
			Precursor {EV_WIDGET_LIST_IMP}
			initialize_pixmaps

			install_event_handlers

			last_selected := 0
		end

	install_event_handlers
			-- Install carbon event handlers
		local
			target, h_ret: POINTER
			event_array : EVENT_TYPE_SPEC_ARRAY
		do
			target := get_control_event_target_external( c_object )
			create event_array.make_new_unshared ( 2 )
			event_array.item ( 0 ).set_eventclass ( {CARBONEVENTS_ANON_ENUMS}.kEventClassControl )
			event_array.item ( 0 ).set_eventkind ( {CARBONEVENTS_ANON_ENUMS}.kEventcontrolhit )
			event_array.item ( 1 ).set_eventclass ( {CARBONEVENTS_ANON_ENUMS}.kEventClassCommand )
			event_array.item ( 1 ).set_eventkind ( {CARBONEVENTS_ANON_ENUMS}.keventcommandprocess )

			h_ret := app_implementation.install_event_handlers ( event_id, target, event_array )
		end


feature -- Access

	pointed_tab_index: INTEGER
			-- index of tab currently under mouse pointer, or 0 if none.
		local
			err: INTEGER
			a_point : CGPOINT_STRUCT
		do
			create a_point.make_new_unshared

			-- GetGlobalMouse

			--err := hiview_get_subview_hit_external ( c_object,

		end

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Implement this
		end

feature {EV_NOTEBOOK, EV_NOTEBOOK_TAB_IMP} -- Access

	item_tab (an_item: EV_WIDGET): EV_NOTEBOOK_TAB
			-- Tab associated with `an_item'.
		do
			create Result.make_with_widgets (interface, an_item)
		end

	item_text (an_item: like item): STRING_32
			-- Label of `an_item'.
		local
			item_index : INTEGER
			err : INTEGER
			tab_info : CONTROL_TAB_INFO_REC_V1_STRUCT
			actual_size : INTEGER
			cf_string : EV_CARBON_CF_STRING
		do
			item_index := index_of ( an_item, 1)
			create tab_info.make_new_unshared
			tab_info.set_version ( {CONTROLDEFINITIONS_ANON_ENUMS}.kcontroltabinfoversionone )
			err := get_control_data_external ( c_object, item_index, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlTabInfoTag, tab_info.sizeof, tab_info.item, $actual_size )
			check
				no_overflow : err = 0 implies actual_size = tab_info.sizeof
			end
			create cf_string.make_shared ( tab_info.name )
			Result := cf_string.string
		end

	item_pixmap (an_item: like item): EV_PIXMAP
			-- Pixmap of `an_item'.
		local
			item_imp: EV_WIDGET_IMP
			a_event_box, a_hbox, a_list, a_image, a_pixbuf: POINTER
			pix_imp: EV_PIXMAP_IMP
		do

		end

feature -- Status report

	selected_item: like item
			-- Page displayed topmost.
		do
			Result := i_th ( selected_item_index )
		end

	selected_item_index: INTEGER
			-- Page index of selected item
		do
			Result := get_control32bit_value_external ( c_object )
		end

	tab_position: INTEGER
			-- Position of tabs

feature -- Measurement

	child_offset_top: INTEGER
			do
				if tab_position = interface.Tab_top  then
					Result := internal_offset + tab_offset
				else
					Result := internal_offset
				end
			end

	child_offset_bottom: INTEGER
			do
				if tab_position = interface.Tab_bottom  then
					Result := internal_offset + tab_offset
				else
					Result := internal_offset
				end
			end

	child_offset_right: INTEGER
			do
				if tab_position = interface.Tab_right  then
					Result := internal_offset + tab_offset
				else
					Result := internal_offset
				end
			end

	child_offset_left: INTEGER
			do
				if tab_position = interface.Tab_left  then
					Result := internal_offset + tab_offset
				else
					Result := internal_offset
				end
			end


	calculate_minimum_sizes
			-- minimum_width is the largest minimum_width of all items + tab_offset if tabs are on left or right
		local
			i : INTEGER
			max_width, max_height : INTEGER
		do
				max_width := 0
				max_height := 0
				from
					i := 1
				until
					i > count
				loop
					max_width := max_width.max ( i_th(i).minimum_width )
					max_height := max_height.max ( i_th(i).minimum_height )
					i := i + 1

				end

				if tab_position = interface.tab_left or else tab_position = interface.tab_right then
					buffered_minimum_width := max_width + tab_offset + child_offset_left + child_offset_right
				else
					buffered_minimum_width := max_width + child_offset_left + child_offset_right
				end
				if tab_position = interface.tab_top or else tab_position = interface.tab_bottom then
					buffered_minimum_height := max_height + tab_offset + child_offset_bottom + child_offset_top
				else
					buffered_minimum_width := max_height  + child_offset_bottom + child_offset_top
				end
				buffered_minimum_height := buffered_minimum_height.max (internal_minimum_height)
				buffered_minimum_width := buffered_minimum_width.max (internal_minimum_width)
		end

	minimum_height : INTEGER
		do
			Result := buffered_minimum_height
		end

	minimum_width : INTEGER
		do
			Result := buffered_minimum_width
		end

	internal_offset: INTEGER = 2

feature {EV_NOTEBOOK} -- Status setting

	set_tab_position (a_tab_position: INTEGER)
			-- Display tabs at `a_position'.
			-- Recreate the tab control with changed settings
		local
			a_parent : POINTER
			a_rect : RECT_STRUCT
			dummy_ptr : POINTER
			new_view : POINTER
			a_layout_info : HILAYOUT_INFO_STRUCT
			orientation : INTEGER
			err : INTEGER
			i : INTEGER
			actual_size : INTEGER
			info_rec : CONTROL_TAB_INFO_REC_V1_STRUCT
			w_imp : EV_WIDGET_IMP
		do
 			if a_tab_position = interface.Tab_top  then
 				orientation := {CONTROLDEFINITIONS_ANON_ENUMS}.kControlTabDirectionNorth
 			elseif a_tab_position =  interface.Tab_left  then
 				orientation := {CONTROLDEFINITIONS_ANON_ENUMS}.kControlTabDirectionWest
 			elseif a_tab_position =  interface.Tab_bottom  then
 				orientation := {CONTROLDEFINITIONS_ANON_ENUMS}.kControlTabDirectionSouth
 			elseif a_tab_position =  interface.Tab_right  then
 				orientation := {CONTROLDEFINITIONS_ANON_ENUMS}.kControlTabDirectionEast
 			else
 				check
 					must_not_be_reached : false
 				end
			end
			tab_position := a_tab_position

			a_parent := hiview_get_superview_external ( c_object )
			create a_rect.make_new_unshared
			dummy_ptr := get_control_bounds_external ( c_object, a_rect.item )
			create a_layout_info.make_new_unshared
			a_layout_info.set_version ( {HIVIEW_ANON_ENUMS}.kHILayoutInfoVersionZero )
			err := hiview_get_layout_info_external ( c_object, a_layout_info.item )
			-- Create new tab control
			err := create_tabs_control_external ( null, a_rect.item, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlTabSizeLarge, orientation, 0, default_pointer, $new_view )
			err := hiview_add_subview_external ( a_parent, new_view )
			set_control_bounds_external ( new_view, a_rect.item )
			err := hiview_set_layout_info_external ( new_view, a_layout_info.item )
			err := hiview_apply_layout_external ( new_view )

			set_control32bit_maximum_external ( new_view, count )
			from
				i := 1
			until
				i > count
			loop
				create info_rec.make_new_unshared
				info_rec.set_version ( {CONTROLDEFINITIONS_ANON_ENUMS}.kcontroltabinfoversionone )
				err := get_control_data_external ( c_object, i, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlTabInfoTag, info_rec.sizeof, info_rec.item, $actual_size )
				check
					no_overflow : actual_size = info_rec.sizeof
				end
				err := set_control_data_external ( new_view, i, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontroltabinfotag, info_rec.sizeof, info_rec.item )

				-- Bind content to new view
				w_imp ?= i_th ( i ).implementation
				check
					w_imp_not_void : w_imp /= Void
				end
				err := hiview_remove_from_superview_external ( w_imp.c_object )
				err := hiview_add_subview_external ( new_view, w_imp.c_object )
				err := get_control_data_external ( new_view, {CONTROLS_ANON_ENUMS}.kControlEntireControl, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlTabContentRectTag, a_rect.sizeof, a_rect.item, $actual_size )
				check
					no_overflow : err = noErr implies actual_size = a_rect.sizeof
				end
				if err /= 0 then
					a_rect.set_top ( 0 ); a_rect.set_left ( 0 );
					a_rect.set_bottom ( 0 ); a_rect.set_right ( 0 );
				end

				if tab_position = interface.tab_top then
					a_rect.set_top ( a_rect.top + tab_offset )
				elseif tab_position = interface.tab_left then
					a_rect.set_left ( a_rect.left + tab_offset )
				elseif tab_position = interface.tab_bottom then
					a_rect.set_bottom ( a_rect.bottom - tab_offset )
				elseif tab_position = interface.tab_right then
					a_rect.set_right ( a_rect.right - tab_offset )
				end

				set_control_bounds_external ( w_imp.c_object, a_rect.item )
				bind_to_tabcontrol ( w_imp.c_object, new_view )
				i := i + 1
			end

			set_control32bit_value_external ( new_view, selected_item_index )

			dispose_control_external ( c_object )
			set_c_object ( new_view )
			install_event_handlers
		end

	select_item (an_item: like item)
			-- Display `an_item' above all others.
		local
			w_imp, item_imp: EV_WIDGET_IMP
			item_index : INTEGER
		do
			item_imp ?= an_item.implementation
			check
				item_imp_not_void : item_imp /= Void
			end
			item_index := index_of (an_item, 1)
			if last_selected > 0 and last_selected <= count then
				w_imp ?= i_th ( last_selected ).implementation
				check
					w_imp_not_void : w_imp /= Void
				end
				hide_control_external ( w_imp.c_object )
			end
			set_control32bit_value_external ( c_object, item_index )
			show_control_external ( item_imp.c_object )
			last_selected := selected_item_index
		end

feature -- Element change

	remove_i_th (i: INTEGER)
			-- Remove item at `i'-th position.
		do
			Precursor {EV_WIDGET_LIST_IMP} (i)
			set_control32bit_maximum_external ( c_object, count )
		end

	insert_i_th (v: like item; i: INTEGER)
			-- Insert `v' at position `i'.
		local
			info_rec : CONTROL_TAB_INFO_REC_V1_STRUCT
			err : INTEGER
			name : EV_CARBON_CF_STRING
			w_imp : EV_WIDGET_IMP
			actual_size : INTEGER
			container: EV_CONTAINER_IMP
		do
			Precursor {EV_WIDGET_LIST_IMP} ( v, i )
			create name.make_unshared_with_eiffel_string ( "Page " + i.out )
			create info_rec.make_new_unshared
			info_rec.set_version ( {CONTROLDEFINITIONS_ANON_ENUMS}.kcontroltabinfoversionone )
			info_rec.set_name ( name.item )
			info_rec.set_iconsuiteid ( 0 )
			set_control32bit_maximum_external ( c_object, count )
			err := set_control_data_external ( c_object, i, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontroltabinfotag, info_rec.sizeof, info_rec.item )

			w_imp ?= v.implementation
			check
				not_void : w_imp /=  Void
			end
			hide_control_external ( w_imp.c_object )
			if count = 1  then
				page_switch
			end
			if ( (w_imp.minimum_height + child_offset_top + child_offset_bottom) > minimum_height) or ( (w_imp.minimum_width + child_offset_left + child_offset_right) > minimum_width) then
				child_has_resized (void, 0, 0)
			else
				layout
				container ?= w_imp
				if container /= void then
					container.setup_layout
				end
			end


		end

	replace (v: like item)
			-- Replace current item by `v'.
		do
			remove_i_th (index)
			insert_i_th (v, index)
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

		setup_layout
			local
				w: EV_WIDGET_IMP
				c: EV_CONTAINER_IMP
				i: INTEGER
			do
				if count > 0 then
					layout
					from
						i := 1
					until
						(i = 0) or (i = count + 1)
					loop
						c ?= i_th (i).implementation
						if c /= void then
							c.setup_layout
						end
						i := i + 1
					end
				end
			end

		layout
				-- Sets the child control's size to the container site minus some spacing
		local
			a_rect : CGRECT_STRUCT
			a_size : CGSIZE_STRUCT
			a_point : CGPOINT_STRUCT
			ret, i: INTEGER
			a_widget : EV_WIDGET_IMP
		do
			from
				i := 1
			until
				(i = 0) or (i = count + 1)
			loop
				a_widget ?= i_th (i).implementation
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

				i := i + 1
			end
		end



feature {EV_NOTEBOOK, EV_NOTEBOOK_TAB_IMP} -- Element change

	ensure_tab_label (tab_widget: POINTER)
			-- Ensure the is a tab label widget for `tab_widget'.
		do

		end

	default_tab_label_spacing: INTEGER = 3
		-- Space between pixmap and text in the tab label.

	set_item_text (an_item: like item; a_text: STRING_GENERAL)
			-- Assign `a_text' to the label for `an_item'.
		local
			item_index : INTEGER
			err : INTEGER
			tab_info : CONTROL_TAB_INFO_REC_V1_STRUCT
			actual_size : INTEGER
			cf_string : EV_CARBON_CF_STRING
		do
			item_index := index_of ( an_item, 1 )
			create tab_info.make_new_unshared
			tab_info.set_version ( {CONTROLDEFINITIONS_ANON_ENUMS}.kcontroltabinfoversionone )
			err := get_control_data_external ( c_object, item_index, {CONTROLDEFINITIONS_ANON_ENUMS}.kControlTabInfoTag, tab_info.sizeof, tab_info.item, $actual_size )
			check
				no_overflow : err = 0 implies actual_size = tab_info.sizeof
			end
			create cf_string.make_unshared_with_eiffel_string ( a_text )
			tab_info.set_name ( cf_string.item )
			err := set_control_data_external ( c_object, item_index, {CONTROLDEFINITIONS_ANON_ENUMS}.kcontroltabinfotag, tab_info.sizeof, tab_info.item )

		end

	set_item_pixmap (an_item: like item; a_pixmap: EV_PIXMAP)
			-- Assign `a_pixmap' to the tab for `an_item'.
		do

		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	tab_offset : INTEGER = 30
		-- Offset between the tabs and the content

	last_selected : INTEGER

	page_switch
			-- Called when the page is switched.
		do
			select_item ( i_th ( selected_item_index ) )
		end

	on_event (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER
			-- Feature that is called if an event occurs
		local
			event_class, event_kind : INTEGER
		do
				event_class := get_event_class_external (a_inevent)
				event_kind := get_event_kind_external (a_inevent)

				if  ( event_kind = {CARBONEVENTS_ANON_ENUMS}.keventcontrolhit and event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassControl ) or
					( event_kind = {CARBONEVENTS_ANON_ENUMS}.keventcommandprocess and event_class = {CARBONEVENTS_ANON_ENUMS}.keventclasscommand )
				then
					page_switch
					Result := noErr -- event handled
				else
					Result := {CARBON_EVENTS_CORE_ANON_ENUMS}.eventnothandlederr
				end
		end

	bind_to_tabcontrol ( a_control, a_tabcontrol: POINTER )
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					HILayoutInfo LayoutInfo;
					LayoutInfo.version = kHILayoutInfoVersionZero;
					HIViewGetLayoutInfo( $a_control, &LayoutInfo );
					
					LayoutInfo.binding.top.toView = $a_tabcontrol;
					LayoutInfo.binding.top.kind = kHILayoutBindTop;
					LayoutInfo.binding.top.offset = 0;
					
					LayoutInfo.binding.bottom.toView = $a_tabcontrol;
					LayoutInfo.binding.bottom.kind = kHILayoutBindBottom;
					LayoutInfo.binding.bottom.offset = 0;
					
					LayoutInfo.binding.left.toView = $a_tabcontrol;
					LayoutInfo.binding.left.kind = kHILayoutBindLeft;
					LayoutInfo.binding.left.offset = 0;
					
					LayoutInfo.binding.right.toView = $a_tabcontrol;
					LayoutInfo.binding.right.kind = kHILayoutBindRight;
					LayoutInfo.binding.right.offset = 0;
					
					HIViewSetLayoutInfo( $a_control, &LayoutInfo );
					HIViewApplyLayout( $a_control );
				}
			]"
		end

feature {EV_ANY_I, EV_ANY} -- Implementation

	interface: EV_NOTEBOOK;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_NOTEBOOK_IMP

