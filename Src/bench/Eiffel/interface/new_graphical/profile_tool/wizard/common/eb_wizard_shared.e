indexing
	description	: "Proxy to shared references"
	author		: "Pascal FREUND, Arnaud PICHERY [arnaud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_WIZARD_SHARED

inherit
	EV_LAYOUT_CONSTANTS

feature -- Access

	first_window: EB_WIZARD_WINDOW is
			-- Main Window ( i.e. the wizard window frame )
		do
			Result := first_window_cell.item
		end

	main_box: EV_VERTICAL_BOX is
			-- Box in which we display the different pages the
			-- user will see. All the WIZARD_STATE_WINDOW instances will
			-- be displayed child of this box.
		require
			first_window_valid: first_window /= Void
		do
			Result := first_window.wizard_page
		ensure
			exists: Result /= Void
		end

	history: TWO_WAY_LIST [EB_WIZARD_STATE_WINDOW] is
			-- History of the different pages
			-- the user has processed.
		once
			Create Result.make
		ensure
			Result_exists: Result /= Void
		end

	pixmap: EV_PIXMAP is
			-- Pixmap on which can be displayed a picture which 
			-- goes with the state.
		do
			Result := pixmap_cell.item
		end
		
	pixmap_icon: EV_PIXMAP is
			-- Pixmap for the small icon of the wizard
		do
			Result := pixmap_icon_cell.item
		end

feature -- Element change

	set_first_window (a_wizard_window: EB_WIZARD_WINDOW) is
			-- Set the main Window (i.e. the wizard window frame) to `a_wizard_window'
		require
			a_wizard_window_valid: a_wizard_window /= Void
		do
			first_window_cell.put (a_wizard_window)
		ensure
			first_window_not_void: first_window /= Void
			set: first_window = a_wizard_window
		end

	remove_first_window is
			-- Set the main Window (i.e. the wizard window frame) to `a_wizard_window'
		do
			first_window_cell.put (Void)
		ensure	
			no_first_window: first_window = Void
		end

	set_pixmaps (left_pixmap: EV_PIXMAP; icon_pixmap: EV_PIXMAP) is
			-- Set the pixmap displayed on the left of initial and
			-- final state to `left_pixmap' and the pixmap displayed
			-- in intermediary states to `icon_pixmap'.
		require
			valid_left_pixmap: left_pixmap /= Void
			valid_icon_pixmap: icon_pixmap /= Void
		do
			pixmap_cell.put (clone (left_pixmap))
			pixmap_icon_cell.put (clone (icon_pixmap))
		ensure
			pixmap_not_void: pixmap /= Void
			pixmap_icon_not_void: pixmap_icon /= Void
		end

	remove_pixmaps is
			-- Set the pixmap displayed on the left of initial and
			-- final state to `left_pixmap' and the pixmap displayed
			-- in intermediary states to `icon_pixmap'.
		do
			pixmap_cell.put (Void)
			pixmap_icon_cell.put (Void)
		ensure
			pixmap_void: pixmap = Void
			pixmap_icon_void: pixmap_icon = Void
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
		once
			create Result
			Result.set_family ((create {EV_FONT_CONSTANTS}).Family_screen)
			Result.set_weight ((create {EV_FONT_CONSTANTS}).Weight_bold)
			Result.set_shape ((create {EV_FONT_CONSTANTS}).Shape_regular)
			Result.preferred_families.extend ("Verdana")
			Result.preferred_families.extend ("Arial")
			Result.preferred_families.extend ("Helvetica")
			Result.set_height (16)
		end

	Interior_title_font: EV_FONT is
			-- Title for interior pages
		once
			create Result
			Result.set_family ((create {EV_FONT_CONSTANTS}).Family_screen)
			Result.set_weight ((create {EV_FONT_CONSTANTS}).Weight_bold)
			Result.set_shape ((create {EV_FONT_CONSTANTS}).Shape_regular)
			Result.preferred_families.extend ("Tahoma")
			Result.preferred_families.extend ("Arial")
			Result.preferred_families.extend ("Helvetica")
			Result.set_height (11)
		end

	Interior_font: EV_FONT is
			-- Title for interior pages
		once
			create Result
			Result.set_family ((create {EV_FONT_CONSTANTS}).Family_screen)
			Result.set_weight ((create {EV_FONT_CONSTANTS}).Weight_regular)
			Result.set_shape ((create {EV_FONT_CONSTANTS}).Shape_regular)
			Result.preferred_families.extend ("Tahoma")
			Result.preferred_families.extend ("Arial")
			Result.preferred_families.extend ("Helvetica")
			Result.set_height (11)
		end

	Title_border_width: INTEGER is
			-- Border on the left of the title
		do
			Result := dialog_unit_to_pixels (22)
		end

	Title_right_border_width: INTEGER is 
			-- Border on the right of the title
		do
			Result := dialog_unit_to_pixels (5)
		end

	Subtitle_border_width: INTEGER is
			-- Border on the left of the subtitle
		do
			Result := dialog_unit_to_pixels (20)
		end
	
	Interior_border_width: INTEGER is
			-- Border on the left of the text in the core of the wizard.
		do
			Result := dialog_unit_to_pixels (42)
		end

feature {NONE} -- Implementation

	first_window_cell: CELL [EB_WIZARD_WINDOW] is
			-- Main Window ( i.e. the wizard window frame )
		once
			create Result.put (Void)
		end

	pixmap_cell: CELL [EV_PIXMAP] is
			-- Pixmap on which can be displayed a picture which 
			-- goes with the state.
		once
			create Result.put (Void)
		end

	pixmap_icon_cell: CELL [EV_PIXMAP] is
			-- Pixmap for the small icon of the wizard
		once
			create Result.put (Void)
		end

end -- class EB_WIZARD_SHARED
