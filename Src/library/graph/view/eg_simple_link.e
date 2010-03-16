note
	description: "A very simple implementation for a EG_LINK_FIGURE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_SIMPLE_LINK

inherit
	EG_LINK_FIGURE
		redefine
			default_create,
			xml_node_name,
			make_filled
		end

create
	make_with_model

create {EG_SIMPLE_LINK}
	make_filled

feature {NONE} -- Initialization

	default_create
			-- Create an EG_SIMPLE_LINK.
		do
			Precursor {EG_LINK_FIGURE}
			create line
			extend (line)
			create reflexive.make_with_positions (0, 0, 10, 10)
		end

	make_with_model (a_model: EG_LINK)
			-- Make a link using `a_model'.
		require
			a_model_not_void: a_model /= Void
		local
			l_reflexive: like reflexive
		do
			-- Satisfy invariant
			create line

			default_create
			model := a_model
			initialize

			if a_model.is_directed then
				line.enable_end_arrow
			end
			if a_model.is_reflexive then
				prune_all (line)
				l_reflexive := reflexive
				check l_reflexive /= Void end -- Implied by `is_reflexive'
				extend (l_reflexive)
			end

			disable_moving
			disable_scaling
			disable_rotating

			update
		end

	make_filled (n: INTEGER_32)
			-- <Precursor>
		do
			create line

			Precursor {EG_LINK_FIGURE} (n)
		end

feature -- Access

	xml_node_name: STRING
			-- Name of `xml_element'.
		do
			Result := "EG_SIMPLE_LINK"
		end

	arrow_size: INTEGER
			-- Size of the arrow.
		do
			Result := line.arrow_size
		end

feature -- Element change

	set_arrow_size (i: INTEGER)
			-- Set `arrow_size' to `i'.
		require
			i_positive: i > 0
		do
			line.set_arrow_size (i)
		ensure
			set: arrow_size = i
		end

feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update

	update
			-- Some properties may have changed.
		local
			p1, p2: EV_COORDINATE
			an_angle: DOUBLE
			source_size: EV_RECTANGLE
			l_model: like model
			l_reflexive: like reflexive
		do
			l_model := model
			check l_model /= Void end -- FIXME: Implied by ...?
			if not l_model.is_reflexive then
				if attached source as l_source and then attached target as l_target then
					p1 := line.point_array.item (0)
					p2 := line.point_array.item (1)

					p1.set (l_source.port_x, l_source.port_y)
					p2.set (l_target.port_x, l_target.port_y)

					an_angle := line_angle (p1.x_precise, p1.y_precise, p2.x_precise, p2.y_precise)
					l_source.update_edge_point (p1, an_angle)
					an_angle := pi + an_angle
					l_target.update_edge_point (p2, an_angle)
				elseif attached source as l_source_2 then
					p1 := line.point_array.item (0)
					p1.set (l_source_2.port_x, l_source_2.port_y)
					l_source_2.update_edge_point (p1, 0)
				elseif attached target as l_target_2 then
					p2 := line.point_array.item (1)
					p2.set (l_target_2.port_x, l_target_2.port_y)
					l_target_2.update_edge_point (p2, 0)
				end

				line.invalidate
				line.center_invalidate
				if is_label_shown then
					name_label.set_point_position (line.x, line.y)
				end
			else
				if attached source as l_source then
					source_size := l_source.size
					l_reflexive := reflexive
					check l_reflexive /= Void end -- FIXME: Implied by ...?
					l_reflexive.set_x_y (source_size.right + l_reflexive.radius1, source_size.top + source_size.height // 2)
				end
				if is_label_shown then
					l_reflexive := reflexive
					check l_reflexive /= Void end -- FIXME: Implied by ...?
					name_label.set_point_position (l_reflexive.x + l_reflexive.radius1, l_reflexive.y)
				end
			end
			is_update_required := False
		end

feature {NONE} -- Implementation

	set_is_selected (an_is_selected: like is_selected)
			-- Set `is_selected' to `an_is_selected'.
		do
			is_selected := an_is_selected
		end

	line: EV_MODEL_LINE
			-- The line representing the link.

	reflexive: detachable EV_MODEL_ELLIPSE
			-- The ellipse used when link `is_reflexive'.

	on_is_directed_change
			-- `model'.`is_directed' changed.
		local
			l_model: like model
		do
			l_model := model
			check l_model /= Void end -- FIXME: Implied by ...?
			if l_model.is_directed then
				line.enable_end_arrow
			else
				line.disable_end_arrow
			end
			line.invalidate
			line.center_invalidate
		end

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end

invariant
	line_not_void: line /= Void

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




end -- class EG_SIMPLE_LINK

