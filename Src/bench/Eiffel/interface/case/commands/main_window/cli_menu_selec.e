class CLI_MENU_SELEC

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

feature -- Actions

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do		 			
			change_client_visibility							
		end

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

	change_client_visibility is
			-- Toggle aggregation links visibility
			-- Deep: propagate changes to all workareas.	
		local
			client_visibility_b: EV_TOOL_BAR_TOGGLE_BUTTON
		do
			client_visibility_b := toolbar.client_link_visibility_b

			if client_visibility_b /= Void then
				if client_visibility_b.is_selected then
					client_visibility_b.set_selected(FALSE)
				else
					client_visibility_b.set_selected(TRUE)
				end
			end
		end;

	symbol: EV_PIXMAP is
		do
			Result := pixmaps.hidden_client_pixmap
		end

	selected_symbol: EV_PIXMAP is
		do
			Result := pixmaps.show_client_pixmap
		end

end
