class IMP_MENU_SELEC

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
			change_implementation_visibility							
		end

	change_implementation_visibility is
			-- Toggle aggregation links visibility
			-- Deep: propagate changes to all workareas.	
		local
			implementation_visibility_b: EV_TOOL_BAR_TOGGLE_BUTTON
		do
			implementation_visibility_b := toolbar.all_visibility_b

			if implementation_visibility_b /= Void then
				if implementation_visibility_b.is_selected then
					implementation_visibility_b.set_selected(FALSE)
				else
					implementation_visibility_b.set_selected(TRUE)
				end
			end
		end;

	select_actions is 
		do
			System.set_is_client_hidden (false)
			System.set_is_modified
		end

	unselect_actions is 
		do
			System.set_is_client_hidden (true)
			System.set_is_modified
		end

	symbol: EV_PIXMAP is
		do
			Result := pixmaps.hidden_comp_inherit_pixmap
		end

	selected_symbol: EV_PIXMAP is
		do
			Result := pixmaps.comp_inherit_pixmap
		end

end
