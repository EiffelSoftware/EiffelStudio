indexing
	description: "Objects that is a cluster figure that can be resized by moving one of its edges."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_RESIZABLE_CLUSTER_FIGURE

inherit
	EG_CLUSTER_FIGURE
		redefine
			default_create,
			update,
			xml_node_name,
			xml_element,
			set_with_xml_element,
			recycle
		end
		
feature {NONE} -- Initialization

	default_create is
			-- Create a EG_CLUSTER_FIGURE
		local
			rectangle: EV_MODEL_RECTANGLE
		do
			Precursor {EG_CLUSTER_FIGURE}
			
			create resizer_top_left
			resizer_top_left.disable_rotating
			resizer_top_left.disable_scaling
			resizer_top_left.move_actions.extend (agent on_move_top_left)
			resizer_top_left.set_pointer_style (default_pixmaps.sizenwse_cursor)
			create rectangle.make_with_positions (0, 0, resizers_width, resizers_height)
			resizer_top_left.extend (rectangle)
			rectangle.hide
			extend (resizer_top_left)
			
			create resizer_top_right
			resizer_top_right.disable_rotating
			resizer_top_right.disable_scaling
			resizer_top_right.move_actions.extend (agent on_move_top_right)
			resizer_top_right.set_pointer_style (default_pixmaps.sizenesw_cursor)
			create rectangle.make_with_positions (-resizers_width, 0, 0, resizers_height)
			resizer_top_right.extend (rectangle)
			rectangle.hide
			extend (resizer_top_right)
			
			create resizer_bottom_right
			resizer_bottom_right.disable_rotating
			resizer_bottom_right.disable_scaling
			resizer_bottom_right.move_actions.extend (agent on_move_bottom_right)
			resizer_bottom_right.set_pointer_style (default_pixmaps.sizenwse_cursor)
			create rectangle.make_with_positions (-resizers_width, -resizers_height, 0, 0)
			resizer_bottom_right.extend (rectangle)
			rectangle.hide
			extend (resizer_bottom_right)
			
			create resizer_bottom_left
			resizer_bottom_left.disable_rotating
			resizer_bottom_left.disable_scaling
			resizer_bottom_left.move_actions.extend (agent on_move_bottom_left)
			resizer_bottom_left.set_pointer_style (default_pixmaps.sizenesw_cursor)
			create rectangle.make_with_positions (0, -resizers_height, resizers_width, 0)
			resizer_bottom_left.extend (rectangle)
			rectangle.hide
			extend (resizer_bottom_left)
			
--			start_actions.extend (agent set_move_cursor)
--			end_actions.extend (agent set_default_cursor)
			disable_rotating
			disable_scaling
		end
		
feature -- Access

	left: INTEGER is
			-- 
		deferred
		end

	top: INTEGER is
			-- 
		deferred
		end
		
	right: INTEGER is
			-- 
		deferred
		end
		
	bottom: INTEGER is
			--
		deferred
		end
		
	user_size: EV_RECTANGLE
			-- User resized `Current' to `user_size' if not void.
			
	xml_node_name: STRING is
			-- Name of the xml node returned by `xml_element'.
		do
			Result := once "EG_RESIZABLE_CLUSTER_FIGURE"
		end
		
	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml element representing `Current's state.
		local
			l_colon: STRING
			l_user_size: like user_size
		do
			Result := Precursor {EG_CLUSTER_FIGURE} (node)
			l_colon := ";"
			l_user_size := user_size
			if l_user_size = Void then
				Result.put_last (Xml_routines.xml_node (Result, is_user_sized_string, boolean_representation (False)))
			else
				Result.put_last (Xml_routines.xml_node (Result, is_user_sized_string, boolean_representation (True)))
				Result.put_last (Xml_routines.xml_node (Result, user_size_string, 
					l_user_size.left.out + l_colon +
					l_user_size.top.out + l_colon +
					l_user_size.width.out + l_colon +
					l_user_size.height.out + l_colon))
			end
		end

	is_user_sized_string: STRING is "IS_USER_SIZED"
	user_size_string: STRING is "USER_SIZE"
		-- String constants for XML handling.
		
	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		local
			size_str: STRING
		do
			Precursor {EG_CLUSTER_FIGURE} (node)
			if xml_routines.xml_boolean (node, is_user_sized_string) then
				size_str := xml_routines.xml_string (node, user_size_string)
				user_size := rectangle_from_string (size_str)
			end
		end
		
feature -- Element change

	recycle is
			-- Free `Current's resources.
		do
			Precursor {EG_CLUSTER_FIGURE}
			resizer_top_left.move_actions.prune_all (agent on_move_top_left)
			resizer_top_right.move_actions.prune_all (agent on_move_top_right)
			resizer_bottom_right.move_actions.prune_all (agent on_move_bottom_right)
			resizer_bottom_left.move_actions.prune_all (agent on_move_bottom_left)
		end
		
	reset_user_size is
			-- Set `user_size' to Void
		do
			user_size := Void
		ensure
			set: user_size = Void
		end
		
feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update
			
	update is
			-- Some properties of `Current' may have changed.
		do
			resizer_top_left.set_point_position (left, top)
			resizer_top_right.set_point_position (right, top)
			resizer_bottom_right.set_point_position (right, bottom)
			resizer_bottom_left.set_point_position (left, bottom)
			is_update_required := False
		end

feature {NONE} -- Implementation

	set_top_left_position (ax, ay: INTEGER) is
			-- Set position of top left corner to (`ax', `ay').
		deferred
		end
		
	set_bottom_right_position (ax, ay: INTEGER) is
			-- Set position of bottom right corner to (`ax', `ay').
		deferred
		end

		
	resizer_top_left: EV_MODEL_MOVE_HANDLE
			-- resizer for top left corner.
			
	resizer_top_right: EV_MODEL_MOVE_HANDLE
			-- resizer for top right corner.
			
	resizer_bottom_right: EV_MODEL_MOVE_HANDLE
			-- resizer for bottom right corner.
			
	resizer_bottom_left: EV_MODEL_MOVE_HANDLE
			-- resizer for bottom left corner.
			
	resizers_width: INTEGER is 20
			-- width of the resizers in pixel.
			
	resizers_height: INTEGER is 20
			-- height of the resizers in pixel.
			
	on_move_top_left (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- `resizer_top_left' was moved for (`ax', `ay').
		local
			new_x, new_y: INTEGER
		do
			new_x := (left + ax).min (right)
			new_y := (top + ay).min (bottom)
			set_top_left_position (new_x, new_y)
			resizer_top_left.set_point_position (new_x, new_y)
			resizer_bottom_left.set_point_position (new_x, resizer_bottom_left.point_y)
			resizer_top_right.set_point_position (resizer_top_right.point_x, new_y)
			update_user_size
			request_update
		end

	on_move_top_right (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- `resizer_top_right' was moved to (`ax', `ay').
		local
			new_x, new_y: INTEGER
		do
			new_x := (right + ax).max (left)
			new_y := (top + ay).min (bottom)
			set_top_left_position (left, new_y)
			set_bottom_right_position (new_x, bottom)
			resizer_top_right.set_point_position (new_x, new_y)
			resizer_top_left.set_point_position (resizer_top_left.point_x, new_y)
			resizer_bottom_right.set_point_position (new_x, resizer_bottom_right.point_y)
			update_user_size
			request_update
		end
		
	on_move_bottom_right (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- `resizer_bottom_right' was moved to (`ax', `ay').
		local
			new_x, new_y: INTEGER
		do
			new_x := (right + ax).max (left)
			new_y := (bottom + ay).max (top)
			set_bottom_right_position (new_x, new_y)
			resizer_bottom_right.set_point_position (new_x, new_y)
			resizer_top_right.set_point_position (new_x, resizer_top_right.point_y)
			resizer_bottom_left.set_point_position (resizer_bottom_left.point_x, new_y)
			update_user_size
			request_update
		end
		
	on_move_bottom_left (ax, ay: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- `resizer_bottom_left' was moved to (`ax', `ay').
		local
			new_x, new_y: INTEGER
		do
			new_x := (left + ax).min (right)
			new_y := (bottom + ay).max (top)
			set_top_left_position (new_x, top)
			set_bottom_right_position (right, new_y)
			resizer_bottom_left.set_point_position (new_x, new_y)
			resizer_top_left.set_point_position (new_x, resizer_top_left.point_y)
			resizer_bottom_right.set_point_position (resizer_bottom_right.point_x, new_y)
			update_user_size
			request_update
		end
		
	update_user_size is
			-- Set `user_size' to current size.
		do
			if user_size = Void then
				create user_size.make (left, top, right - left, bottom - top)
			else
				user_size.move_and_resize (left, top, right - left, bottom - top)
			end
		end
		
	rectangle_from_string (a_size: STRING): EV_RECTANGLE is
			-- 
		require
			a_size_not_void: a_size /= Void
		local
			strs: LIST [STRING]
			s: STRING
			l, t, w, h: INTEGER
		do
			strs := a_size.split (';')
			strs.start
			s := strs.item
			if s.is_integer then
				l := s.to_integer
			end
			strs.forth
			s := strs.item
			if s.is_integer then
				t := s.to_integer
			end
			strs.forth
			s := strs.item
			if s.is_integer then
				w := s.to_integer
			end
			strs.forth
			s := strs.item
			if s.is_integer then
				h := s.to_integer
			end
			create Result.make (l, t, w, h)
		end

invariant
	risizers_not_void: resizer_top_left /= Void and resizer_top_right /= Void and resizer_bottom_right /= Void and resizer_bottom_left /= Void

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




end -- class EG_RESIZABLE_CLUSTER_FIGURE

