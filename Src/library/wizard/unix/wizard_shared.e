indexing
	description: "Proxy to shared references"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_SHARED

inherit
	WIZARD_PROJECT_SHARED

	EV_LAYOUT_CONSTANTS

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

	wizard_pixmaps_path: FILE_NAME is 
			-- Bitmaps location
		once
			create Result.make_from_string (wizard_source)
			Result.extend ("pixmaps")
		end

	wizard_resources_path: FILE_NAME is
			-- Resource location.
		once
			create Result.make_from_string (wizard_source)
			Result.extend ("unix_resources")
		end

	pixmap_extension: STRING is
			-- Extension used for pixmaps.
		once
			Result := "png"
		end

	platform_is_unix: BOOLEAN is True
			-- Are we on a Unix system (as opposed to a Windows one)?

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

	help_engine: WIZARD_HELP_ENGINE is
			-- Help engine
		do
			create Result.make
		ensure
			help_engine_created: Result /= Void
		end

feature -- Colors

	White_color: EV_COLOR is
		once
			create Result.make_with_rgb (1,1,1)
		end

	Blue_color: EV_COLOR is
		once
			create Result.make_with_rgb (0,0,1)
		end

	Red_color: EV_COLOR is
		once
			create Result.make_with_rgb (1,0,0)
		end

	Green_color: EV_COLOR is
		once
			create Result.make_with_rgb (0,1,0)
		end

	Welcome_title_font: EV_FONT is
			-- Title for welcome page
		local
			font_constants: EV_FONT_CONSTANTS
		once
			create font_constants
			create Result
			Result.set_family (font_constants.Family_screen)
			Result.set_weight (font_constants.Weight_bold)
			Result.set_shape (font_constants.Shape_regular)
			Result.preferred_families.extend ("Verdana")
			Result.preferred_families.extend ("Arial")
			Result.preferred_families.extend ("Helvetica")
			Result.set_height (16)
		end

	Interior_title_font: EV_FONT is
			-- Title for interior pages
		local
			font_constants: EV_FONT_CONSTANTS
		once
			create font_constants
			create Result
			Result.set_family (font_constants.Family_screen)
			Result.set_weight (font_constants.Weight_bold)
			Result.set_shape (font_constants.Shape_regular)
			Result.preferred_families.extend ("Tahoma")
			Result.preferred_families.extend ("Arial")
			Result.preferred_families.extend ("Helvetica")
			Result.set_height (11)
		end

	Interior_font: EV_FONT is
			-- Title for interior pages
		local
			font_constants: EV_FONT_CONSTANTS
		once
			create font_constants
			create Result
			Result.set_family (font_constants.Family_screen)
			Result.set_weight (font_constants.Weight_regular)
			Result.set_shape (font_constants.Shape_regular)
			Result.preferred_families.extend ("Tahoma")
			Result.preferred_families.extend ("Arial")
			Result.preferred_families.extend ("Helvetica")
			Result.set_height (11)
		end

	Title_border_width: INTEGER is
			-- Border on the left of the title
		once
			Result := dialog_unit_to_pixels (22)
		end

	Title_right_border_width: INTEGER is 
			-- Border on the right of the title
		once
			Result := dialog_unit_to_pixels (5)
		end

	Subtitle_border_width: INTEGER is
			-- Border on the left of the subtitle
		once
			Result := dialog_unit_to_pixels (20)
		end
	
	Interior_border_width: INTEGER is
			-- Border on the left of the text in the core of the wizard.
		once
			Result := dialog_unit_to_pixels (42)
		end

invariant
	memory_for_pixmap_allocated: pixmap /= Void
	wizard_resource_path_exists: wizard_resources_path /= Void
	wizard_pixmaps_path_exists: wizard_pixmaps_path /= Void
	wizard_source_exists: wizard_source /= Void
	history_exists: history /= Void
	window_exists: first_window /= Void

end -- class WIZARD_SHARED


--|----------------------------------------------------------------
--| EiffelWizard: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

