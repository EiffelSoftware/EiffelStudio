indexing
	description: "Proxy to shared references"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED

inherit
	PROJECT_SHARED

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
			-- user will see. All the STATE_WINDOW instances will
			-- be displayed child of this box.
		once
			Result := first_window.wizard_page
		ensure
			exists: Result /= Void
		end

	history: TWO_WAY_LIST [STATE_WINDOW] is
			-- History of the different pages
			-- the user has processed.
		once
			Create Result.make
		ensure
			Result_exists: Result /= Void
		end

end -- class SHARED
