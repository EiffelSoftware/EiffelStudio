indexing
	description: "Object is a view for an EG_LINKABLE"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EG_LINKABLE_FIGURE

inherit
	EG_FIGURE
		redefine
			default_create,
			recursive_transform,
			model,
			request_update,
			xml_element,
			xml_node_name,
			set_with_xml_element,
			recycle
		end
		
feature {NONE} -- Initialisation

	default_create is
			-- Create a EG_LINKABLE_FIGURE.
		do
			Precursor {EG_FIGURE}
			create links.make (0)
			start_actions.extend (agent on_handle_start)
			end_actions.extend (agent on_handle_end)
			set_step (1)
		end
		
feature -- Status report

	is_fixed: BOOLEAN
			-- Does the layouter not move `Current'?
			
	has_visible_link: BOOLEAN is
			-- Has `Current' at least one visible link?
		local
			l_links: like links
			i, nb: INTEGER
		do
			l_links := links
			if not l_links.is_empty then
				from
					i := 1
					nb := l_links.count
				until
					i > nb or else Result
				loop
					if l_links.i_th (i).is_show_requested then
						Result := True
					end
					i := i + 1
				end
			end
		end

feature -- Access

	cluster: EG_CLUSTER_FIGURE
			-- Cluster figure `Current' is part of.
	
	model: EG_LINKABLE
			-- The model for `Current'.
			
	port_x: INTEGER is
			-- x position where links are starting.
		deferred
		end
		
	port_y: INTEGER is
			-- y position where links are starting.
		deferred
		end
		
	xml_node_name: STRING is
			-- Name of the xml node returned by `xml_element'.
		do
			Result := "EG_LINKABLE_FIGURE"
		end
		
	xml_element (node: XM_ELEMENT): XM_ELEMENT is
			-- Xml element representing `Current's state.
		do
			Result := Precursor {EG_FIGURE} (node)
			Result.put_last (Xml_routines.xml_node (Result, "IS_FIXED", is_fixed.out))
			Result.put_last (xml_routines.xml_node (Result, "PORT_X", port_x.out))
			Result.put_last (xml_routines.xml_node (Result, "PORT_Y", port_y.out))
		end
		
	set_with_xml_element (node: XM_ELEMENT) is
			-- Retrive state from `node'.
		local
			ax, ay: INTEGER
		do
			Precursor {EG_FIGURE} (node)
			set_is_fixed (xml_routines.xml_boolean (node, "IS_FIXED"))
			
			ax := xml_routines.xml_integer (node, "PORT_X")
			ay := xml_routines.xml_integer (node, "PORT_Y")
			set_port_position (ax, ay)
		end

	size: EV_RECTANGLE is
			-- Size of `Current'.
		deferred
		ensure
			result_not_void: Result /= Void
		end
		
	height: INTEGER is
			-- Height in pixels.
		deferred
		ensure
			result_not_negative: Result >= 0
		end
		
	width: INTEGER is
			-- Width in pixels.
		deferred
		ensure
			result_not_negative: Result >= 0
		end

	minimum_size: EV_RECTANGLE is
			-- `Current' has to be of `Result' size
			-- to include all visible elements starting from `number_of_figures' + 1.
		local
			l_area: like area
			l_item: EV_MODEL
			i, nb: INTEGER
			l_bbox: like bounding_box
		do
			if count <= number_of_figures then
				create Result
			else
				from
					l_area := area
					i := number_of_figures
					nb := count - 1
				until
					i > nb or else l_area.item (i).is_show_requested
				loop
					i := i + 1
				end
				if i <= nb then
					Result := l_area.item (i).bounding_box
					from
						i := i + 1
					until
						i > nb
					loop
						l_item := l_area.item (i)
						if l_item.is_show_requested then
							l_bbox := l_item.bounding_box
							if l_bbox.height > 0 or else l_bbox.width > 0 then
								Result.merge (l_bbox)
							end
						end
						i := i + 1
					end
				else
					create Result
				end
			end
		ensure
			result_not_void: Result /= Void
		end
		
	number_of_figures: INTEGER is 
			-- number of figures used to visialize `Current'.
		deferred
		ensure
			result_greater_equal_zero: Result >= 0
		end
		
feature -- Status settings

	request_update is
			-- 
		local
			l_links: like links
		do
			Precursor {EG_FIGURE}
			if cluster /= Void then
				cluster.request_update
			end
			from
				l_links := links
				l_links.start
			until
				l_links.after
			loop
				l_links.item.request_update
				l_links.forth
			end
		end
		
feature -- Element change

	recycle is
			-- Free resources of `Current' such that GC can collect it.
			-- Leave it in an unstable state.
		do
			Precursor {EG_FIGURE}
			start_actions.prune_all (agent on_handle_start)
			end_actions.prune_all (agent on_handle_end)
		end

	set_port_position (ax, ay: INTEGER) is
			-- Set `port_x' to `ax' and `port_y' to `ay'.
		local
			d_x, d_y: INTEGER
		do
			d_x := ax - port_x
			d_y := ay - port_y
			set_x_y (x + d_x, y + d_y)
		end
		
	update_edge_point (p: EV_COORDINATE; an_angle: DOUBLE) is
			-- Move `p' to a point on the edge of `Current' 
			-- where the outline intersects a line from the 
			-- center point in direction `an_angle'.
		require
			p_not_void: p /= Void
		deferred
		ensure
			p_not_void: p /= Void
		end
		
feature -- Status settings

	set_is_fixed (b: BOOLEAN) is
			-- Set `is_fixed' to `b'.
		do
			is_fixed := b
		ensure
			set: is_fixed = b
		end

feature {EG_FIGURE_WORLD} -- Element change
		
	add_link (a_link: EG_LINK_FIGURE) is
			-- add `a_link' to `links'.
		require
			a_link_not_void: a_link /= Void
		do
			if not links.has (a_link) then
				links.extend (a_link)
			end
		ensure
			links_has_a_link: links.has (a_link)
		end
		
	remove_link (a_link: EG_LINK_FIGURE) is
			-- Remove `a_link' from `links'.
		require
			a_link_not_void: a_link /= Void
		do
			links.prune_all (a_link)
		ensure
			links_not_has_a_link: not links.has (a_link)
		end
		
feature {EG_CLUSTER_FIGURE, EG_FIGURE_WORLD} -- Element change

	set_cluster (a_cluster: EG_CLUSTER_FIGURE) is
			-- set `cluster' to `a_cluster' without adding `Current' to `a_cluster'.
		do
			if a_cluster = Void then
				world.root_cluster.extend (Current)
				world.extend (Current)
			else
				world.root_cluster.prune_all (Current)
			end
			if cluster /= Void then
				cluster.prune_all (Current)
			end
			cluster := a_cluster
		ensure
			set: cluster = a_cluster
		end

feature {EV_MODEL_GROUP} -- Figure group

	recursive_transform (a_transformation: EV_MODEL_TRANSFORMATION) is
			-- Same as transform but without precondition
			-- is_transformable and without invalidating
			-- groups center
		do
			Precursor {EG_FIGURE} (a_transformation)
			request_update
		end
		
feature {EG_LAYOUT} -- Layouter

	dx: DOUBLE
			-- `Current' can be translated for `dx' when `translate' is called.
			
	dy: DOUBLE
			-- `Current' can be translated for `dy' when `translate' is called.
	
	step: DOUBLE

	set_dx_dy (a_dx, a_dy: DOUBLE) is
			-- Set `dx' to `a_dx' and `dy' to `a_dy'
		do
			dx := a_dx
			dy := a_dy
		ensure
			set: dx = a_dx and dy = a_dy
		end
	
	set_step (a_step: DOUBLE) is
			-- Set `step' to `a_step'
		do
			step := a_step.min (1000)
		ensure
			set: a_step < 1000 implies step = a_step
			set: a_step >=1000 implies step = 1000
		end
		
	translate (a_fence: EV_RECTANGLE) is
			-- Translate `Current' for `dx' * `step' and  `dy' * `step'
			-- but not out of `a_fence' if not Void.
			-- Set `dx' and `dy' to 0. 
		local
			ax, ay: DOUBLE
			l_size: like size
			border_x, border_y: INTEGER
		do
			ax := x + step * dx
			ay := y + step * dy
			
			if a_fence /= Void then
				l_size := size
				border_x := l_size.width // 2
				border_y := l_size.height // 2
				ax := ax.max (a_fence.left + border_x).min (a_fence.right - border_x)
				ay := ay.max (a_fence.top + border_y).min (a_fence.bottom - border_y)
			end
			dx := 0.0
			dy := 0.0
			set_x_y (ax.truncated_to_integer, ay.truncated_to_integer)
		ensure
			set: dx = 0.0 and dy = 0.0
		end

feature {EG_LAYOUT, EG_FIGURE} -- Implementation

	links: ARRAYED_LIST [EG_LINK_FIGURE]
			-- links to other figures.
		
feature {NONE} -- Implementation

	on_handle_start is
			-- User started to move `Current'.
		do
			was_fixed := is_fixed
			set_is_fixed (True)
		end
		
	on_handle_end is
			-- User ended to move `Current'.
		do
			set_is_fixed (was_fixed)
		end
		
	was_fixed: BOOLEAN

invariant
	links_not_void: links /= Void

end -- class EG_LINKABLE_FIGURE

--|----------------------------------------------------------------
--| EiffelGraph: library of graph components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

