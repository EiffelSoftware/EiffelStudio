indexing
	description	: "Class which is launching the profiler wizard."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_PROFILER_WIZARD_MANAGER

inherit
	EB_WIZARD_MANAGER
		export
			{NONE} all
		end
	
	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch (a_parent_window: EV_WINDOW) is
			-- Create and display the profiler wizard.
			-- The window is shown modal to `a_parent_window'.
		local
			wizard_initial_state: EB_PROFILER_WIZARD_INITIAL_STATE
			wizard_initial_info: EB_PROFILER_WIZARD_INFORMATION
		do
			create wizard_initial_info.make
			create wizard_initial_state.make (wizard_initial_info)
			
			make_and_show (a_parent_window, wizard_initial_state)
		end
		
feature {NONE} -- Implementation

	wizard_title: STRING is
			-- Title for the wizard
		do
			Result := Interface_names.t_Profiler_Wizard
		end
	
	wizard_pixmap: EV_PIXMAP is
			-- Pixmap for the initial and final states of the wizard.
			-- This pixmap is displayed on the left of the window.
			--
			-- (`wizard_pixmap_icon' is drawn on it in the upper-right
			-- corner.)
		do
			Result := Pixmaps.bm_Wizard_blue
		end		
	
	wizard_icon_pixmap: EV_PIXMAP is
			-- Pixmap for the intermediary states.
			--
			-- (It is drawn on `wizard_pixmap' in the upper-right
			-- corner for the initial and final states.)
		do
			Result := Pixmaps.bm_Wizard_profiler_icon
		end
		
	wizard_window_icon: EV_PIXMAP is
			-- Icon for the wizard window
		do
			Result := Pixmaps.Icon_profiler_window
		end
	
end -- class EB_PROFILER_WIZARD_MANAGER
