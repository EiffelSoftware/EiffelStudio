indexing

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class SCALABLE

feature

	old_width, old_height: INTEGER
			-- Old height and width of Current scalable

	widget_coordinates: LINKED_LIST [WIDGET_RATIO]
			-- List of widget ratios for Current scalable

	width: INTEGER is
			-- Width of Scalable
		deferred
		end

	height: INTEGER is
			-- Height of Scalable
		deferred
		end

	record_resize_policy (a_widget: WIDGET
			foll_x, foll_y,
			width_res, height_res: BOOLEAN) is
		require
			valid_height: height > 0
			valid_width: width > 0
		local
			widget_ratio: WIDGET_RATIO
		do
			!! widget_ratio.make (a_widget,
					foll_x, foll_y,
					width_res, height_res)
			widget_coordinates.extend (widget_ratio)
			widget_ratio.set_ratios
					(width, height)
		end

feature 

	update_ratios (a_widget: WIDGET) is
		require
			valid_widget: a_widget /= Void
		do
			search_widget (a_widget)
			widget_coordinates.item.set_ratios (old_width,
				old_height)
		end

	follow_x (a_widget: WIDGET; flag: BOOLEAN) is
		require
			valid_widget: a_widget /= Void
		do
			search_widget (a_widget)
			widget_coordinates.item.follow_x (flag)
			clean_list
		end

	follow_y (a_widget: WIDGET; flag: BOOLEAN) is
		require
			valid_widget: a_widget /= Void
		do
			search_widget (a_widget)
			widget_coordinates.item.follow_y (flag)
			clean_list
		end

	width_resizeable (a_widget: WIDGET; flag: BOOLEAN) is
		require
			valid_widget: a_widget /= Void
		do
			search_widget (a_widget)
			widget_coordinates.item.width_resizeable (flag)
			clean_list
		end

	height_resizeable (a_widget: WIDGET; flag: BOOLEAN) is
		require
			valid_widget: a_widget /= Void
		do
			search_widget (a_widget)
			widget_coordinates.item.height_resizeable (flag)
			clean_list
		end

	search_widget (a_widget: WIDGET) is
		local
			widget_ratio: WIDGET_RATIO
		do
			old_width := width
			old_height := height
			from
				widget_coordinates.start
			until
				widget_coordinates.after or else
				widget_coordinates.item.widget = a_widget
			loop
				widget_coordinates.forth
			end
			if widget_coordinates.after then
				!! widget_ratio.make_with_widget (a_widget)
				widget_coordinates.finish
				widget_coordinates.put_right (widget_ratio)
				widget_coordinates.forth
			end
			widget_coordinates.item.set_ratios (old_width,
						old_height)
		end

	clean_list is
		do
			if widget_coordinates.item.useless then
				widget_coordinates.remove
			end
		end

feature {NONE} -- Configure event

	execute (argument: ANY) is
		local
			widget_ratio: WIDGET_RATIO
			perm_wind: PERM_WIND
		do
			if argument = Current then
				perm_wind ?= argument
				if perm_wind = Void or else
					perm_wind /= Void and then not perm_wind.is_iconic_state
				then
					if old_width /= 0 and old_height /= 0 and then
						(old_width /= width or else
						old_height /= height) 
					then
						from
							widget_coordinates.start
						until
							widget_coordinates.after
						loop
							widget_ratio := widget_coordinates.item

							if widget_ratio.widget.destroyed then
								widget_coordinates.remove
							else
								widget_ratio.update_widget
									(width, height)
								widget_coordinates.forth
							end
						end
					end
					old_width := width
					old_height := height
				end
			end
		end

end

--|----------------------------------------------------------------
--| EiffelBuild library.
--| Copyright (C) 1995 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
