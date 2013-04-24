note
	description:
		"EiffelVision vertical box. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "container, box, vertical"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_BOX_IMP

inherit
	EV_VERTICAL_BOX_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_BOX_IMP
		redefine
			interface,
			make,
			layout,
			bounds_changed,
			minimum_height,
			minimum_width
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a vertical box.
		local
			control_ptr : POINTER
			rect : RECT_STRUCT
			err : INTEGER
		do
			base_make( an_interface )
			create rect.make_new_unshared
			rect.set_top ( 0)
			rect.set_left ( 0 )
			rect.set_right ( 0 )
			rect.set_bottom ( 0 )
			err := create_user_pane_control_external ( null, rect.item, {CONTROLS_ANON_ENUMS}.kControlSupportsEmbedding, $control_ptr )
			set_c_object ( control_ptr )

			err := create_user_pane_control_external ( null, rect.item, 0, $dummy_control )
			err := hiview_add_subview_external ( c_object, dummy_control )
		end

feature -- Measturement

	calculate_minimum_sizes
			local
		min_width, min_height, i: INTEGER
		do
		from
			min_width := 0
			min_height := 0
			i := 1
		until
			(i = 0) or (i = count + 1)
		loop
			min_width := min_width.max(i_th(i).minimum_width)
			min_height := min_height + i_th(i).minimum_height
			i := i + 1
		end
		min_width := min_width + child_offset_left + child_offset_right
		min_height := min_height + (count-1) * padding + child_offset_bottom + child_offset_top
		buffered_minimum_height := min_height.max (internal_minimum_height)
		buffered_minimum_width := min_width.max (internal_minimum_width)
	end

	minimum_height: INTEGER
			do
				Result := buffered_minimum_height
			end
	minimum_width: INTEGER
			do
				Result := buffered_minimum_width
			end


feature -- Implementation

	dummy_control : POINTER

	layout
			-- Setup positioning constraints for all children
		local
			w1, w2 : EV_WIDGET_IMP
			j : INTEGER
			err : INTEGER
			a_rect : CGRECT_STRUCT
			a_size : CGSIZE_STRUCT
			a_point : CGPOINT_STRUCT
			control_height : REAL
			old_height : INTEGER
			initial_control_height : INTEGER
			non_expandable_height : INTEGER
			expandable_height : INTEGER
			next_y : INTEGER
			i: INTEGER
			ratio : DOUBLE
			min_height, min_width: INTEGER
			w : EV_CONTAINER_IMP
		do
			-- Setup rect
			create a_rect.make_new_unshared
			create a_size.make_shared ( a_rect.size )
			create a_point.make_shared ( a_rect.origin )

			-- Calculate height of all controls
			from
				i := 1
				min_width := 0
			until
				(i = 0) or (i = count + 1)
			loop
				w1 ?= i_th (i).implementation
				check
					w1_not_void : w1 /= Void
				end
				if w1.expandable then
					expandable_height := expandable_height + w1.minimum_height
				else
					non_expandable_height := non_expandable_height + w1.minimum_height
				end
				min_width := min_width.max (w1.minimum_width)
				size_control_external ( w1.c_object, width - child_offset_left - child_offset_right, 1)
				i := i + 1
			end

			min_height :=  expandable_height + non_expandable_height + (count-1)*padding +child_offset_bottom + child_offset_top
			old_height := height -- save old height


			if is_homogeneous then
				control_height := ((old_height - child_offset_top - child_offset_bottom - (count-1)*padding) / count).rounded
			else
				control_height := ( (old_height - min_height) / expandable_item_count ).rounded
			end

			if (old_height < min_height) then
				ratio :=  (old_height - child_offset_top - child_offset_bottom - (count-1)*padding) / (min_height - child_offset_top - child_offset_bottom - (count-1)*padding)
			end

			from
				i := 1
				next_y := child_offset_top
			until
				(i = 0) or (i = count + 1)
			loop
					w1 ?= i_th (i).implementation
					check
						w1_not_void : w1 /= Void
					end

					--calculate rect
					a_point.set_x ( child_offset_right )
					a_point.set_y ( next_y )
					a_size.set_width ( width - child_offset_left - child_offset_right )


					if is_homogeneous then
						a_size.set_height ( control_height )
					elseif (old_height < min_height) then
						a_size.set_height (( w1.minimum_height.to_double * ratio).ceiling )
					elseif w1.expandable  then
						a_size.set_height ( w1.minimum_height + control_height )
					else
						a_size.set_height ( w1.minimum_height )
					end

					err := hiview_set_frame_external ( w1.c_object, a_rect.item )
					next_y := (a_point.y + a_size.height + padding).ceiling
					i := i + 1
			end
			buffered_minimum_width := internal_minimum_width.max (min_width + child_offset_left + child_offset_right)
			buffered_minimum_height := internal_minimum_height.max (min_height)
		end


		setup_bottom_binding ( lower_control : POINTER; left_of, right_of, bottom_of, top_of, a_padding: INTEGER )
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					HILayoutInfo LayoutInfo;
					LayoutInfo.version = kHILayoutInfoVersionZero;
					HIViewGetLayoutInfo( $lower_control, &LayoutInfo );
					
					LayoutInfo.binding.bottom.toView = NULL;
					LayoutInfo.binding.bottom.kind = kHILayoutBindBottom;
					LayoutInfo.binding.bottom.offset = $bottom_of;	
					
					HIViewSetLayoutInfo( $lower_control, &LayoutInfo );
					HIViewApplyLayout( $lower_control );

											
				}
			]"
		end

		setup_binding ( upper_control, lower_control : POINTER; left_of, right_of, bottom_of, top_of, a_padding: INTEGER )
		external
			"C inline use <Carbon/Carbon.h>"
		alias
			"[
				{
					HILayoutInfo LayoutInfo;
					LayoutInfo.version = kHILayoutInfoVersionZero;
					HIViewGetLayoutInfo( $lower_control, &LayoutInfo );
					
					// always allign to the box in x-direction
						LayoutInfo.position.x.toView = NULL;
						LayoutInfo.position.x.kind = kHILayoutPositionLeft;
						LayoutInfo.position.x.offset = $left_of;
						
						LayoutInfo.binding.right.toView = NULL;
						LayoutInfo.binding.right.kind = kHILayoutBindRight;
						LayoutInfo.binding.right.offset = $right_of;
				
					
					if ( $upper_control != NULL && $lower_control != NULL)
					{
						// Bind to upper control (maintain padding)
						LayoutInfo.binding.top.toView = $upper_control;
						LayoutInfo.binding.top.kind = kHILayoutBindBottom;
						LayoutInfo.binding.top.offset = $a_padding;
					}
					else if ($upper_control != NULL)
					{
						// For topmost control
						LayoutInfo.position.y.toView = NULL;
						LayoutInfo.position.y.kind = kHILayoutPositionTop;
						LayoutInfo.position.y.offset = $top_of;
					}
					
					
					HIViewSetLayoutInfo( $lower_control, &LayoutInfo );
					HIViewApplyLayout( $lower_control );
									
				}
			]"
		end

feature {NONE} -- Events



	bounds_changed ( options : NATURAL_32; original_bounds, current_bounds : CGRECT_STRUCT )
			-- Handler for the bounds changed event
		do
			if count > 0 then
				layout
			end
		end


feature {EV_ANY_I} -- Implementation

    interface: EV_VERTICAL_BOX;

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




end -- class EV_VERTICAL_BOX_IMP

