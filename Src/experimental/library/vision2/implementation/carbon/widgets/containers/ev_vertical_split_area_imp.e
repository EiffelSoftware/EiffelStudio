note
	description:
		"Eiffel Vision Split Area, Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_SPLIT_AREA_IMP

inherit
	EV_VERTICAL_SPLIT_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_SPLIT_AREA_IMP
		redefine
			initialize,
			interface,
			client_height,
			client_width
		end

create
	make

feature {NONE} -- Implementation

	initialize
			--
		do
			Precursor
			create splitter_image.make_with_file ("HSplitter.png")
			create ridges_image.make_with_file ("HRidges.png")
		end


	calculate_rects
			-- Calculate the CGRECTS rect_a, rect_b and splitter_rect
		local
			bounds : CGRECT_STRUCT
			bounds_size : CGSIZE_STRUCT
			err : INTEGER
			size : REAL_32
		do
			create bounds.make_new_unshared
			create bounds_size.make_shared ( bounds.size )
			err := hiview_get_bounds_external ( c_object, bounds.item )

			size := bounds_size.height - splitter_width
			if first /= void and then (( bounds_size.height - splitter_width ) * split_ratio).rounded < first.minimum_height then
				split_ratio := first.minimum_height / size
			end
			if second /= void and then (( bounds_size.height - splitter_width) * (1-split_ratio)).rounded < second.minimum_height then
				split_ratio := (1-second.minimum_height/size)
			end

			rect_a_size.set_width ( bounds_size.width )
			rect_a_size.set_height ( ( (bounds_size.height - splitter_width) * split_ratio ).rounded )
			rect_a_origin.set_x ( 0 )
			rect_a_origin.set_y ( 0 )

			splitter_rect_origin.set_x ( rect_a_origin.x )
			splitter_rect_origin.set_y ( rect_a_origin.y + rect_a_size.height )
			splitter_rect_size.set_width ( rect_a_size.width )
			splitter_rect_size.set_height ( splitter_width )

			rect_b_size.set_width ( bounds_size.width )
			rect_b_size.set_height ( bounds_size.height - splitter_width - rect_a_size.height )
			rect_b_origin.set_x ( splitter_rect_origin.x )
			rect_b_origin.set_y ( splitter_rect_origin.y + splitter_rect_size.height )
		end

	calculate_minimum_sizes
			--calculate the minimum sizes for buffered_minimum_heigth and width
		local
			first_width, second_width, first_height, second_height: INTEGER
		do
			if first /= void then
				first_width := first.minimum_width
				first_height := first.minimum_height
			end
			if second /= void then
				second_width := second.minimum_width
				second_height := second.minimum_height
			end

			buffered_minimum_width :=  first_width.max (second_width)
			buffered_minimum_height := first_height + second_height + splitter_width
		end

	track ( event :POINTER ) : TUPLE[INTEGER, INTEGER_16]
			-- Tracking event handler
		local
			err : INTEGER
			actual_type, actual_size : NATURAL_32
			where, last_where : CGPOINT_STRUCT
			port : POINTER
			part, last_part : INTEGER_16
			bounds : CGRECT_STRUCT
			bounds_size : CGSIZE_STRUCT
			size : REAL_32
			click_offset_min, click_offset_max : REAL_32
			break : BOOLEAN
			point : POINT_STRUCT
			mouse_result : INTEGER_16
			last_ratio : REAL_32
		do
			-- Init
			last_part := kcontrolnopart

			create where.make_new_unshared
			err := get_event_parameter_external ( event, {CARBONEVENTS_ANON_ENUMS}.keventparammouselocation, {CARBONEVENTS_ANON_ENUMS}.typehipoint, $actual_type, where.sizeof, $actual_size, where.item )

			-- Check again to see if the mouse is in the view
			part := hit_test ( where )

			-- The tracking loop
			if part = ksubviewsplitter then
				create bounds.make_new_unshared
				create bounds_size.make_shared ( bounds.size )
				err := hiview_get_bounds_external ( c_object, bounds.item )

				-- Set up the size
				size := bounds_size.height - splitter_width

				-- Don't let the splitter get dragged offscreen.  Calculate
				-- offsets that show where within the splitter the original
				-- click occurred and track accordingly.
				calculate_rects
				click_offset_min := where.y - cgrect_get_min_y_external ( splitter_rect.item )
				click_offset_max := splitter_rect_size.height - click_offset_min

				create last_where.make_new_unshared
				last_where.set_x ( where.x )
				last_where.set_y ( where.y )

				from
					break := false
				until
					break
				loop
					-- Watch the mouse for change
					port := {EV_APPLICATION_IMP}.int_to_pointer (-1)
					create point.make_new_unshared
					err := track_mouse_location_external ( port, point.item, $mouse_result )
					where := qdglobal_to_hiview_local ( point, c_object )

					-- Bail out when the mouse is released
					if mouse_result = {CARBONEVENTS_ANON_ENUMS}.kmousetrackingmouseup  then
						break := True
					else
						if where.y < cgrect_get_min_y_external ( bounds.item ) + click_offset_min then
							where.set_y ( cgrect_get_min_y_external ( bounds.item ) + click_offset_min )
						elseif where.y > cgrect_get_max_y_external ( bounds.item ) - click_offset_max then
							where.set_y ( cgrect_get_max_y_external ( bounds.item ) - click_offset_max )
						end

						-- Keep track of the ratio
						last_ratio := split_ratio

						-- Update ratio if mouse moved
						if last_where.y /= where.y then
							split_ratio := split_ratio - ( last_where.y -where.y ) / size

							if first /= void and then (( bounds_size.height - splitter_width ) * split_ratio).rounded < first.minimum_height then
								split_ratio := first.minimum_height / size
							end
							if second /= void and then (( bounds_size.height - splitter_width ) * (1-split_ratio)).rounded < second.minimum_height then
								split_ratio := (1-second.minimum_height/size)
							end
						end

						-- Update subview sizes if ratio changed
						if last_ratio /= split_ratio then
							calculate_rects
							adjust_subviews
							last_where.set_x ( where.x )
							last_where.set_y ( where.y )
						end

						-- Check again to see if the mouse is in the view
						part := hit_test( where )
					end
				end
			end

			err := set_event_parameter_external ( event, {CARBONEVENTS_ANON_ENUMS}.keventparamcontrolpart, {CARBONEVENTS_ANON_ENUMS}.typecontrolpartcode, 2, $last_part ) -- 2 = sizeof(INTEGER_16)

			Result := [err, part]
		end

feature -- access

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
			Result := height - child_offset_top - child_offset_bottom - splitter_width
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_SPLIT_AREA;
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_VERTICAL_SPLIT_AREA_IMP

