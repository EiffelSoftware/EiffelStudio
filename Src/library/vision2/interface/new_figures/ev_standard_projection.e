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
			--| FIXME Maybe send an event here?

			--| This is to tell the world that changes to relative
			--| positions have to be taken into account, and
			--| positioners have to be called again.
			world.invalidate_absolute_position

			--| FIXME We can do all calculation right now by calling
			--world.calculate_absolute_position
			--| But since x_abs and y_abs are called anyway, why bother?
			--| At least not in this implementation of EV_PROJECTION.

			device.clear
			project_figure_group (world)
		end

feature {NONE} -- Implementation

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
			point: EV_FIGURE_POINT
			ellipse: EV_FIGURE_ELLIPSE
			rectangle: EV_FIGURE_RECTANGLE
		do
			set_attributes (figure)
			line ?= figure
			if line  /= Void then
				project_line (line)
			end
			point ?= figure
			if point  /= Void then
				project_point (point)
			end
			ellipse ?= figure
			if ellipse  /= Void then
				project_ellipse (ellipse)
			end
			rectangle ?= figure
			if rectangle  /= Void then
				project_rectangle (rectangle)
			end
		end

	set_attributes (figure: EV_ATOMIC_FIGURE) is
			-- Set applicable attributes for `figure'.
		do
			device.set_foreground_color (figure.foreground_color)
			device.set_line_width (figure.line_width)
			device.set_logical_mode (figure.logical_function_mode)
		end

	project_line (line: EV_FIGURE_LINE) is
			-- Make standard projection of EV_FIGURE_LINE.
		do
			device.draw_segment (line.coordinates_a, line.coordinates_b)
			device.draw_segment (create {EV_COORDINATES}.set (5,5), create {EV_COORDINATES}.set (50,50))
		end

	project_point (point: EV_FIGURE_POINT) is
			-- Make standard projection of EV_FIGURE_POINT.
		do
			device.draw_point (point.coordinates)
		end

	project_ellipse (ellipse: EV_FIGURE_ELLIPSE) is
			-- Make standard projection of EV_FIGURE_ELLIPSE.
		do
			if ellipse.fill_color /= Void then
				--device.set_background_color (figure.fill_color)
				device.fill_ellipse (ellipse.center, ellipse.radius1, ellipse.radius2, base_angle)
			else
				device.draw_ellipse (ellipse.center, ellipse.radius1, ellipse.radius2, base_angle)
			end
		end

	project_rectangle (rectangle: EV_FIGURE_RECTANGLE) is
			-- Make standard projection of EV_FIGURE_RECTANGLE.
		do
			if rectangle.fill_color /= Void then
				--device.set_background_color (figure.fill_color)
				device.fill_rectangle (rectangle.top_left, rectangle.width, rectangle.height, base_angle)
			else
				device.draw_rectangle (rectangle.top_left, rectangle.width, rectangle.height, base_angle)
			end
		end

	base_angle: EV_ANGLE is
			-- 3 o'clock angle.
		do
			create Result.make_radians (0)
		end

end -- class EV_STANDARD_PROJECTION
