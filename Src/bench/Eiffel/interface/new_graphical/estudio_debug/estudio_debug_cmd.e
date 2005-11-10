indexing
	description : "Objects that represents the special debug menu access point"
	date        : "$Date$"
	revision    : "$Revision$"

class
	ESTUDIO_DEBUG_CMD
inherit
	SYSTEM_CONSTANTS
	
	EB_SHARED_PREFERENCES 
	
	SHARED_EXEC_ENVIRONMENT
	
feature -- Status report

	have_menu: BOOLEAN is
			-- If the command alread have the EiffelStudio debug menu ?
		require
			window_not_void: window /= Void
		do 
			if window.menu_bar /= Void then
				Result := window.menu_bar.has (menu)
			else
				Result := False
			end
		
		end

	preference_enable_menu: BOOLEAN is
			-- If the preference_want_to_show_estudio_debug_menu ?
		do
			Result := preferences.debugger_data.enable_estudio_debug_menu
		end
	
feature -- Element change

	set_main_window (a_w: like window) is
			-- Set main_window
		require
			a_window_not_void: a_w /= Void
		do
			window := a_w
			if preference_enable_menu then
				add_accelerator
			end
		ensure
			a_window_set: a_w = window
		end
	
feature -- Access

	window: EB_VISION_WINDOW
			-- Window related to current's accelerator.

	accelerator: EV_ACCELERATOR
			-- Accelerator used to trigger current command.

feature {NONE} -- Implementation

	menu: ESTUDIO_DEBUG_MENU
			-- Menu created when current command is executed.
						
feature -- Command

	build_menu_bar is
			-- Add/remove menu bar based on preference, don't change the preference.
		require
			window_not_void: window /= Void
		do
			if not window.is_destroyed and then window.menu_bar /= Void then
				if menu /= Void and then menu.is_destroyed then
					menu := Void
				end
		    	if preferences.development_window_data.show_eiffel_studio_debug_preference.value then
					add_menu
			    else    		
					remove_menu
		    	end
			end
		end
	
	build_menu_bar_by_accelerator is
			-- Add/remove menu bar by build_menu_bar_by_accelerator when `show_eiffel_studio_debug_preference' is True.
		require
			preference_set: preference_set
		do
			if menu /= Void then
				window.menu_bar.prune (menu)
		    	menu.wipe_out
		    	menu := Void			
		    	preferences.development_window_data.show_debug_menu_with_accelerator_preference.set_value (False)
	    	else
				create menu.make_with_window (window)
	    		window.menu_bar.extend (menu)
	    		preferences.development_window_data.show_debug_menu_with_accelerator_preference.set_value (True)
			end
				
		end
		
	add_accelerator is
			-- Add accelerator related to Current command.
		require
			window_not_void: window /= Void
		do
			create accelerator.make_with_key_combination (
					create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_d) ,
					True, True, False
				)
			accelerator.actions.extend (agent build_menu_bar_by_accelerator)				
			window.accelerators.extend (accelerator)

		end	
		
	remove_accelerator is
			-- Remove `accelerator' from main development window. 
		do
			if accelerator /= Void then
				window.accelerators.prune (accelerator)
			end
		end
	
	remove_menu is
			-- Remove menu from menu bar then change the preference.
		do
    		if menu /= Void then
				window.menu_bar.prune (menu)
		    	menu.wipe_out
		    	menu := Void	    			
    		end		
			preferences.development_window_data.show_eiffel_studio_debug_preference.set_value (False)
			preferences.development_window_data.show_debug_menu_with_accelerator_preference.set_value (True)	
		end
		
	add_menu is
			-- Add menu to menu bar then change the preference.
		do
			if preferences.development_window_data.show_debug_menu_with_accelerator_preference.value then
	    		create menu.make_with_window (window)
		    	window.menu_bar.extend (menu)				
			end
			preferences.development_window_data.show_eiffel_studio_debug_preference.set_value (True)	    				
		end
		
feature -- States report

	preference_set: BOOLEAN is
			-- If user preference want to show debug menu?
		do
			Result := preferences.development_window_data.show_eiffel_studio_debug_preference.value
		end
		
invariant
	accelerator_not_void: accelerator /= Void

end
