indexing

	description: 	
		"Command to draw lassoed area in workarea.";
	date: "$Date$";
	revision: "$Revision $"


class WORKAREA_SELECT_LASSO_COM

inherit

	WORKAREA_MOVE_DATA_COM

creation

	make

feature -- Execution

	cancel_selection : BOOLEAN

	execute_button_release (notused: NONE; butrel_data: EV_BUTTON_EVENT_DATA) is
			-- Called when the mouse button is released.
	--	local
	--		closure: EC_CLOSURE;
	--		p1, p2: EC_COORD_XY;
	--		list: LINKED_LIST [GRAPH_FORM]
		do
		--	workarea.remove_button_motion_action (1, Current, void);
		--	workarea.remove_button_release_action (1, Current, void);
		--	if moving then
		--		erase;
		--		moving := false;
		--		!!closure.make;
		--		!!p1;
		--		!!p2;
		--		p1.set (relative_x, relative_y);
		--		p2.set (start_rel_x, start_rel_y);
		--		closure.enlarge (p1);
		--		closure.enlarge (p2);
		--		list := workarea.figures_in (closure);
		--		from
		--			list.start
		--		until
		--			list.after
		--		loop
		--			if not cancel_selection then
		--				if not list.item.selected then
		--					list.item.select_it;
		--				end;
		--			else
		--				if list.item.selected then
		--					list.item.set_unselected
		--				end
		--			end
		--			list.forth
		--		end;
		--		workarea.refresh;
		--		workarea.analysis_window.update_unzoom_button
		--	end
		ensure then
			not_moving: not moving
		end

feature {NONE} -- Implementation

	draw is
			-- Draw lasso rectangle.
		do
			workarea.inverted_painter.draw_rectangle_from_to
				(start_rel_x, start_rel_y, relative_x, relative_y)
		end;

	erase is
			-- Erase lasso rectangle.
		do
			draw
		end

end -- class WORKAREA_SELECT_LASSO_COM
