indexing
	description: "Standard projection of a figure world onto a drawable device."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STANDARD_PROJECTION

inherit
	EV_PROJECTION

create
	make

feature -- Basic operations

	project is
			-- Make a standard projection of the world on the device.
		do
			device.set_background_color (world.background_color)
			clear_device
			world.invalidate_absolute_position
			project_figure_group (world)
		end

feature {NONE} -- Implementation

	erasing: BOOLEAN
			-- Is this pass just to erase the old canvas?

	clear_device is
			-- Do smart erasing of the canvas.
		do
			erasing := True
			device.set_foreground_color (world.background_color)
			project_figure_group (world)
			erasing := False
		end

	project_figure_group (group: EV_FIGURE_GROUP) is
			-- Draw all figures in group to device.
		local
			group_fig: EV_FIGURE_GROUP
			atomic_fig: EV_ATOMIC_FIGURE
		do
			from
				group.start
			until
				group.after
			loop
				group_fig ?= group.item
				if group_fig /= Void then
					project_figure_group (group_fig)
				else
					atomic_fig ?= group.item
					if atomic_fig /= Void then
						project_figure (atomic_fig)
					end
				end
				group.forth
			end
		end

	project_figure (figure: EV_ATOMIC_FIGURE) is
			-- Determine the figure and apply it to the device.
		local
			line: EV_FIGURE_LINE
			dot: EV_FIGURE_DOT
			ellipse: EV_FIGURE_ELLIPSE
			rectangle: EV_FIGURE_RECTANGLE
		do
			set_attributes (figure)
			line ?= figure
			if line /= Void then
				project_line (line)
			else
				dot ?= figure
				if dot /= Void then
					project_dot (dot)
				else
					ellipse ?= figure
					if ellipse /= Void then
						project_ellipse (ellipse)
					else
						rectangle ?= figure
						if rectangle /= Void then
							project_rectangle (rectangle)
						else
							io.put_string ("EV_STANDARD_PROJECTION: Figure not known.")
						end
					end
				end
			end
		end

	set_attributes (figure: EV_ATOMIC_FIGURE) is
			-- Set applicable attributes for `figure'.
		do
			if not erasing then
				device.set_foreground_color (figure.foreground_color)
			end
			device.set_line_width (figure.line_width)
			device.set_logical_mode (figure.logical_function_mode)
		end

	project_line (line: EV_FIGURE_LINE) is
			-- Make standard projection of EV_FIGURE_LINE.
		do
			device.draw_segment (line.coordinates_a, line.coordinates_b)
		end

	project_dot (dot: EV_FIGURE_DOT) is
			-- Make standard projection of EV_FIGURE_DOT.
		do
			device.draw_point (dot.coordinates)
		end

	project_ellipse (ellipse: EV_FIGURE_ELLIPSE) is
			-- Make standard projection of EV_FIGURE_ELLIPSE.
		do
			if ellipse.fill_color /= Void then
				--device.set_background_color (figure.fill_color)
				device.fill_ellipse (ellipse.center, ellipse.radius1, ellipse.radius2, ellipse.orientation)
			else
				device.draw_ellipse (ellipse.center, ellipse.radius1, ellipse.radius2, ellipse.orientation)
			end
		end

	project_rectangle (rectangle: EV_FIGURE_RECTANGLE) is
			-- Make standard projection of EV_FIGURE_RECTANGLE.
		do
			if rectangle.fill_color /= Void then
				--device.set_background_color (figure.fill_color)
				device.fill_rectangle (rectangle.top_left, rectangle.width, rectangle.height, rectangle.orientation)
			else
				device.draw_rectangle (rectangle.top_left, rectangle.width, rectangle.height, rectangle.orientation)
			end
		end

end -- class EV_STANDARD_PROJECTION
