class INH_MENU_SELEC

inherit 

	MENU_SELEC
		select
			execute
		end

	EC_LICENCED_COMMAND
		redefine
			selected_symbol,
			select_actions,
			unselect_actions
		end

creation 
	make

feature


	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do		 			
			change_inheritance_visibility							
		end

	change_inheritance_visibility is
			-- Toggle aggregation links visibility
			-- Deep: propagate changes to all workareas.	
		local
			inherit_visibility_b: EV_TOOL_BAR_TOGGLE_BUTTON
		do
			inherit_visibility_b := toolbar.inheritance_visibility_b

			if inherit_visibility_b /= Void then
				if inherit_visibility_b.is_selected then
					inherit_visibility_b.set_selected(FALSE)
				else
					inherit_visibility_b.set_selected(TRUE)
				end
			end
		end;

	select_actions is 
		do
			System.set_is_inheritance_hidden (false)
			System.set_is_modified
		end

	unselect_actions is 
		do
			System.set_is_inheritance_hidden (true)
			System.set_is_modified
		end

	symbol: EV_PIXMAP is
		do
			Result := pixmaps.hidden_inherit_pixmap
		end

	selected_symbol: EV_PIXMAP is
		do
			Result := pixmaps.show_inherit_pixmap
		end

end
