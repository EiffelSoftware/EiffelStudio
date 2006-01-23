indexing
	description: "[
						Pixmaps drawn on `point'.
	
					  p1 --------- p2
					  |............
					  |............
					  |............
					 p3
					 
					 point.x = p1.x and point.y = p1.y
					 
			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figure, picture, pixmap"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_PICTURE

inherit
	EV_MODEL_ATOMIC
		redefine
			default_create,
			recursive_transform
		end

	EV_MODEL_SINGLE_POINTED
		undefine
			default_create,
			point_count
		end
		
	EV_SHARED_SCALE_FACTORY
		undefine
			default_create
		end

create
	default_create,
	make_with_point,
	make_with_pixmap,
	make_with_identified_pixmap,
	make_with_position

feature {NONE} -- Initialization

	default_create is
			-- Create in (0, 0)
		do
			Precursor {EV_MODEL_ATOMIC}
			pixmap_factory.register_pixmap (default_pixmap)
			id_pixmap := default_pixmap
			scaled_pixmap := pixmap
			is_default_pixmap_used := True
			create point_array.make (3)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 0)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 1)
			point_array.put (create {EV_COORDINATE}.make (0, 0), 2)
		end

	make_with_pixmap (a_pixmap: EV_PIXMAP) is
			-- Create with `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			default_create
			set_pixmap (a_pixmap)
		end
		
	make_with_identified_pixmap (an_id_pixmap: EV_IDENTIFIED_PIXMAP) is
			-- Create with `an_id_pixmap'.
		require
			an_id_pixmap_not_Void: an_id_pixmap /= Void
		do
			default_create
			set_identified_pixmap (an_id_pixmap)
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- Pixmap that is displayed.
		do
			Result := id_pixmap.pixmap
		end
			
	angle: DOUBLE is 0.0
			-- Since not rotatable

	point_x: INTEGER is
			-- x position of `point'.
		do
			Result := point_array.item (0).x
		end
		
	point_y: INTEGER is
			-- y position of `point'.
		do
			Result := point_array.item (0).y
		end

feature -- Status report

	width: INTEGER is
			-- Width of pixmap.
		do
			Result := as_integer (point_array.item (1).x_precise - point_array.item (0).x_precise)
		end

	height: INTEGER is
			-- Height of Pixmap.
		do
			Result := as_integer (point_array.item (2).y_precise - point_array.item (0).y_precise)
		end

	is_default_pixmap_used: BOOLEAN
			-- Is `Current' using a default pixmap?
			
	is_rotatable: BOOLEAN is False
			-- Is rotatable? (No)
			
	is_scalable: BOOLEAN is True
			-- Is scalable? (Yes)
			
	is_transformable: BOOLEAN is False
			-- Is transformable? (No)

feature -- Status setting

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `pixmap' to `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			set_identified_pixmap (pixmap_factory.registered_pixmap (a_pixmap))
		ensure
			pixmap_assigned: pixmap = a_pixmap
		end
		
	set_identified_pixmap (an_id_pixmap: EV_IDENTIFIED_PIXMAP) is
			-- Set `id_pixmap' to `an_id_pixmap' and initialize `scaled_pixmap'.
		require
			an_id_pixmap_not_Void: an_id_pixmap /= Void
		do
			id_pixmap := an_id_pixmap
			pixmap_factory.register_pixmap (id_pixmap)
			scaled_pixmap := pixmap
			is_default_pixmap_used := False
			point_array.item (1).set_x_precise (point_array.item (0).x_precise + pixmap.width)
			point_array.item (2).set_y_precise (point_array.item (0).y_precise + pixmap.height)
			invalidate
			center_invalidate
		ensure
			set: id_pixmap = an_id_pixmap
		end
		
	set_point_position (ax, ay: INTEGER) is
			-- Set position of `point' to `a_point'.
		local
			a_delta_x, a_delta_y: DOUBLE
			l_point_array: like point_array
			p0, p1, p2: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			p1 := l_point_array.item (1)
			p2 := l_point_array.item (2)
			
			a_delta_x := ax - p0.x_precise
			a_delta_y := ay - p0.y_precise
			p0.set_precise (ax, ay)
			p1.set_precise (p1.x_precise + a_delta_x, p1.y_precise + a_delta_y)
			p2.set_precise (p2.x_precise + a_delta_x, p2.y_precise + a_delta_y)
			invalidate
			center_invalidate
		end

feature -- Events

	position_on_figure (a_x, a_y: INTEGER): BOOLEAN is
			-- Is (`a_x', `a_y') on this figure?
		local
			ax, ay: DOUBLE
			p0: EV_COORDINATE
			l_point_array: like point_array
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			ax := p0.x_precise
			ay := p0.y_precise
			Result := point_on_rectangle (a_x, a_y, ax, ay, l_point_array.item (1).x_precise, l_point_array.item (2).y_precise)
		end
		
feature {EV_MODEL_GROUP}
		
	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION) is
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		do
			Precursor {EV_MODEL_ATOMIC} (a_transformation)
			update_scaled_pixmap
		end
		
feature {EV_MODEL_DRAWER}

	scaled_pixmap: like pixmap
			-- Scaled version of `pixmap'.
			
feature {NONE} -- Implementation

	id_pixmap: EV_IDENTIFIED_PIXMAP
		
	default_pixmap: EV_IDENTIFIED_PIXMAP is
			-- Pixmap set by `default_create'.
		once
			Result := pixmap_factory.registered_pixmap (create {EV_PIXMAP})
			pixmap_factory.register_pixmap (Result)
		end

	set_center is
			-- Set the center.
		local
			l_point_array: like point_array
			p0: EV_COORDINATE
		do
			l_point_array := point_array
			p0 := l_point_array.item (0)
			center.set_precise ((p0.x_precise + l_point_array.item (1).x_precise) / 2, (p0.y_precise + l_point_array.item (2).y_precise) / 2)
			is_center_valid := True
		end
		
	update_scaled_pixmap is
			-- Scale `pixmap' store result in `scaled_pixmap'.
		do
			if scaled_pixmap.width /= width or else scaled_pixmap.height /= height then
				scaled_pixmap := pixmap_factory.scaled_pixmap (id_pixmap, width.max (1), height.max (1))
			end
		end

invariant
	pixmap_exists: pixmap /= Void

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




end -- class EV_MODEL_PICTURE

