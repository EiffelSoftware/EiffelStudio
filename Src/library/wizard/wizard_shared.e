note
	description: "Proxy to shared references"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SHARED

inherit
	EV_LAYOUT_CONSTANTS

	ARGUMENTS

feature -- Access

	first_window: WIZARD_WINDOW
			-- Main Window
		require
			first_window_cell_not_empty: first_window_cell.item /= Void
		do
			Result := first_window_cell.item
		ensure
			first_window_not_void: Result /= Void
		end

	first_window_cell: CELL [detachable WIZARD_WINDOW]
			-- Main Window ( i.e. the wizard window frame )
		once
			create Result.put (Void)
		ensure
			exists: Result /= Void
		end

	main_box: EV_VERTICAL_BOX
			-- Box in which we display the different pages the
			-- user will see. All the WIZARD_STATE_WINDOW instances will
			-- be displayed child of this box.
		once
			Result := first_window.wizard_page
		ensure
			exists: Result /= Void
		end

	history: TWO_WAY_LIST [WIZARD_STATE_WINDOW]
			-- History of the different pages
			-- the user has processed.
		once
			Create Result.make
		ensure
			Result_exists: Result /= Void
		end

	wizard_source: STRING
			-- Wizard sources
		require
			argument(1).count>0
		once
			Result := argument(1)
		ensure
			exists: Result /= Void
		end

	wizard_pixmaps_path: FILE_NAME
			-- Bitmaps location
		once
			create Result.make_from_string (wizard_source)
			Result.extend ("pixmaps")
		end

	wizard_resources_path: FILE_NAME
			-- Resource location.
		once
			create Result.make_from_string (wizard_source)
			Result.extend ("resources")
		end

	pixmap_extension: STRING
			-- Extension used for pixmaps.
		once
			Result := "png"
		end

	platform_is_unix: BOOLEAN
			-- False because this class is windows-related.
		once
			Result := not (create {PLATFORM}).is_windows
		end

	pixmap: EV_PIXMAP
			-- Pixmap on which can be displayed a picture which
			-- goes with the state.
		once
			create Result
		end

	pixmap_icon: EV_PIXMAP
			-- Pixmap for the small icon of the wizard
		once
			create Result
		end

	current_application: EV_APPLICATION
		do
			Result:= app_cell.item
		end

	app_cell: CELL [detachable EV_APPLICATION]
		once
			create Result.put (Void)
		end

	set_application (app: EV_APPLICATION)
		do
			app_cell.put (app)
		end

	help_engine: WIZARD_HELP_ENGINE
			-- Help engine
		once
			create Result.make
		ensure
			help_engine_created: Result /= Void
		end

	locale: I18N_LOCALE
			-- Current locale.
		local
			l_manager: I18N_LOCALE_MANAGER
		do
			Result := locale_cell.item
			if Result = Void then
				create l_manager.make ("")
				Result := l_manager.system_locale
				locale_cell.put (Result)
			end
		ensure
			locale_not_void: Result /= Void
		end

feature -- Element Change

	set_locale (a_locale: like locale)
			-- Set `locale' with `a_locale'.
		do
			locale_cell.put (a_locale)
		end

feature -- Colors

	White_color: EV_COLOR
		once
			create Result.make_with_rgb (1,1,1)
		end

	Blue_color: EV_COLOR
		once
			create Result.make_with_rgb (0,0,1)
		end

	Red_color: EV_COLOR
		once
			create Result.make_with_rgb (1,0,0)
		end

	Green_color: EV_COLOR
		once
			create Result.make_with_rgb (0,1,0)
		end

	Welcome_title_font: EV_FONT
			-- Title for welcome page
		local
			font_constants: EV_FONT_CONSTANTS
		once
			create font_constants
			create Result
			Result.set_family (font_constants.Family_screen)
			Result.set_weight (font_constants.Weight_bold)
			Result.set_shape (font_constants.Shape_regular)
			if platform_is_unix then
				Result.preferred_families.extend ("Tahoma")
			else
				Result.preferred_families.extend ("Verdana")
				Result.preferred_families.extend ("Arial")
			end
			Result.preferred_families.extend ("Helvetica")
			Result.set_height (16)
		end

	Interior_title_font: EV_FONT
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
			if not platform_is_unix then
				Result.preferred_families.extend ("Arial")
			end
			Result.preferred_families.extend ("Helvetica")
			Result.set_height (11)
		end

	Interior_font: EV_FONT
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
			if not platform_is_unix then
				Result.preferred_families.extend ("Arial")
			end
			Result.preferred_families.extend ("Helvetica")
			Result.set_height (11)
		end

	Title_border_width: INTEGER
			-- Border on the left of the title
		once
			Result := dialog_unit_to_pixels (22)
		end

	Title_right_border_width: INTEGER
			-- Border on the right of the title
		once
			Result := dialog_unit_to_pixels (5)
		end

	Subtitle_border_width: INTEGER
			-- Border on the left of the subtitle
		once
			Result := dialog_unit_to_pixels (20)
		end

	Interior_border_width: INTEGER
			-- Border on the left of the text in the core of the wizard.
		once
			Result := dialog_unit_to_pixels (42)
		end

feature -- Interface names

	b_back: STRING_GENERAL do Result := locale.translation ("< Back ") end
	b_next: STRING_GENERAL do Result := locale.translation ("Next >") end
	b_cancel: STRING_GENERAL do Result := locale.translation ("Cancel") end
	b_help: STRING_GENERAL do Result := locale.translation ("Help") end
	b_finish: STRING_GENERAL do Result := locale.translation ("Finish") end
	b_abort: STRING_GENERAL do Result := locale.translation ("Abort") end
	b_browse: STRING_GENERAL do Result := locale.translation ("Browse...") end

	t_choose_directory: STRING_GENERAL do Result := locale.translation ("Please choose a folder.") end

feature {NONE} -- Implementation

	locale_cell: CELL [detachable I18N_LOCALE]
		once
			create Result.put (Void)
		end

invariant
	memory_for_pixmap_allocated: pixmap /= Void
	wizard_resource_path_exists: wizard_resources_path /= Void
	wizard_pixmaps_path_exists: wizard_pixmaps_path /= Void
	wizard_source_exists: wizard_source /= Void
	history_exists: history /= Void

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WIZARD_SHARED


