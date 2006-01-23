indexing
	description: "Represent a standard UML object diagram node."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_OBJECT_NODE

inherit

	EG_LINKABLE_FIGURE
			redefine
				default_create,
				xml_node_name,
				model,
				set_name_label_text
			end

create
	make_with_model

create {MA_OBJECT_NODE}
	make_filled

feature {NONE} -- Initialization

	default_create is
			-- Create an EG_SIMPLE_NODE.
		do
			Precursor {EG_LINKABLE_FIGURE}

			figure_size := 80

			create node_figure.make_with_positions ( 0, 0, figure_size, figure_size)
			node_figure.set_background_color (color)

			extend (node_figure)
			bring_to_front (name_label)
			disable_scaling
			disable_rotating
			set_center

			create text_underline.default_create
			extend (text_underline)
		end

	make_with_model (a_model: EG_NODE) is
			-- Create a EG_SIMPLE_NODE using `a_model'.
		require
			a_model_not_void: a_model /= Void
		do
			default_create
			model := a_model
			initialize
		end

feature -- Access

	model: EG_NODE
			-- Model `Current' is a view for.

	port_x: INTEGER is
			-- x position where links are starting.
		do
			Result := point_x
		end

	port_y: INTEGER is
			-- y position where links are starting.
		do
			Result := point_y
		end

	size: EV_RECTANGLE is
			-- Size of `Current'.
		do
			Result := node_figure.bounding_box
		end

	height: INTEGER is
			-- Height in pixels.
		do
			Result := node_figure.height
		end

	width: INTEGER is
			-- Width in pixels.
		do
			Result := node_figure.width
		end

	xml_node_name: STRING is
			-- Name of `xml_element'.
		do
			Result := "EG_SIMPLE_NODE"
		end

feature -- Element change

	update_edge_point (p: EV_COORDINATE; an_angle: DOUBLE) is
			-- Set `p' position such that it is on a point on the edge of `Current'.
		do
			P.set_x (port_x)
			p.set_y (port_y)
		end

	set_name_label_text (a_text: STRING) is
			-- update the text and change the figure size to fit the text
		do
			Precursor (a_text)
			node_figure.set_width (name_label.font.string_width (name_label.text) + 2 * left_space)
			node_figure.set_height (name_label.font.height_in_points + 2 * up_space)
			name_label.set_point_position (point_x + left_space , point_y + up_space)

			-- draw the underline of the text
			text_underline.set_line_width (1)
			text_underline.set_point_a_position (name_label.bounding_box.left, name_label.bounding_box.bottom)
			text_underline.set_point_b_position (name_label.bounding_box.right, name_label.bounding_box.bottom)
		end


feature {EG_FIGURE, EG_FIGURE_WORLD} -- Update

	update is
			-- Some properties may have changed.
		do
			is_update_required := False
		end

feature {NONE} -- Implementation

	set_is_selected (an_is_selected: like is_selected) is
			-- Set `is_selected' to `an_is_selected'.
		do
			if is_selected /= an_is_selected then
				is_selected := an_is_selected
				if is_selected then
					node_figure.set_line_width (node_figure.line_width * 2)
				else
					node_figure.set_line_width (node_figure.line_width // 2)
				end
			end
		end

	figure_size: INTEGER
			-- Size of figure in pixel.

	color: EV_COLOR is
			-- Color of the figure.
		once
			Result := (create{EV_STOCK_COLORS}).white
		ensure
			result_not_void: Result /= Void
		end

	node_figure: EV_MODEL_RECTANGLE
			-- The figure visualizing `Current'.

	text_underline: EV_MODEL_LINE
			-- The underline of the text.

	number_of_figures: INTEGER is 3
			-- Number of figures used to visualize `Current'.
			-- (`name_label' and `node_figure')

	left_space: INTEGER is 10
			-- the space in the figure between left border and the text ( is the same space between right border and the text)

	up_space: INTEGER is 10
			-- the space in the figure between up border and the text ( is the same space between bottom border and the text)

feature {NONE} -- Implementation

	new_filled_list (n: INTEGER): like Current is
			-- New list with `n' elements.
		do
			create Result.make_filled (n)
		end

invariant
	node_figure_not_void: node_figure /= Void

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




end
