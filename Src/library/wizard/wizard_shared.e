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

	pixmap: EV_PIXMAP is
			-- Pixmap on which can be displayed a picture which 
			-- goes with the state.
		do
			Result := first_window.main_pixmap
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

	wizard_bmp_path: STRING is 
			-- Bitmaps location
		once
			Result := wizard_source+ "\bmp" 
		end

	wizard_resources_path: STRING is
			-- Resource location.
		once
			Result := wizard_source +"\resources"
		end

end -- class WIZARD_SHARED
