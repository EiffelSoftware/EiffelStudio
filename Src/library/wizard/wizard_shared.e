indexing
	description: "Proxy to shared references"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SHARED

inherit
	PROJECT_WIZARD_SHARED

	ARGUMENTS

feature -- Access

	first_window:  WIZARD_WINDOW is
			-- Main Window ( i.e. the wizard window frame )
		once
			create Result.make
		ensure	
			exists: Result /= Void
		end

	main_box: EV_VERTICAL_BOX is
			-- Box in which we display the different pages the
			-- user will see. All the WIZARD_STATE_WINDOW instances will
			-- be displayed child of this box.
		once
			Result := first_window.wizard_page
		ensure
			exists: Result /= Void
		end

	history: TWO_WAY_LIST [WIZARD_STATE_WINDOW] is
			-- History of the different pages
			-- the user has processed.
		once
			Create Result.make
		ensure
			Result_exists: Result /= Void
		end

	wizard_source: STRING is
			-- Wizard sources
		require
			argument(1).count>0   
		once
			Result := argument(1)
		ensure
			exists: Result /= Void
		end

	wizard_pixmaps_path: STRING is 
			-- Bitmaps location
		once
			Result := wizard_source+ "\pixmaps" 
		end

	wizard_resources_path: STRING is
			-- Resource location.
		once
			Result := wizard_source +"\resources"
		end

	pixmap: EV_PIXMAP is
			-- Pixmap on which can be displayed a picture which 
			-- goes with the state.
		once
			create Result
		end

	pixmap_icon: EV_PIXMAP is
			-- Pixmap for the small icon of the wizard
		once
			create Result
		end

	current_application: EV_APPLICATION is
		do
			Result:= app_cell.item
		end

	app_cell: CELL [EV_APPLICATION] is
		once
			Create Result.put (Void)
		end

	set_application (app: EV_APPLICATION) is
		do
			app_cell.put (app)
		end

feature -- Colors

	white_color: EV_COLOR is
		once
			Create Result.make_with_rgb (1,1,1)
		end

invariant
	memory_for_pixmap_allocated: pixmap /= Void
	wizard_resource_path_exists: wizard_resources_path /= Void
	wizard_pixmaps_path_exists: wizard_pixmaps_path /= Void
	wizard_source_exists: wizard_source /= Void
	history_exists: history /= Void
	window_exists: first_window /= Void
	window_content_exists: main_box /= Void
end -- class WIZARD_SHARED
