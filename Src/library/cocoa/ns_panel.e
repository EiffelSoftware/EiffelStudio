note
	description: "Summary description for {NS_PANEL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_PANEL

inherit
	NS_WINDOW

feature
	is_floating_panel : BOOLEAN
		do
			Result := panel_is_floating_panel(cocoa_object)
		end

	set_floating_panel (a_flag: BOOLEAN)
		do
			panel_set_floating_panel(cocoa_object, a_flag)
		end

	becomes_key_only_if_needed : BOOLEAN
		do
			Result := panel_becomes_key_only_if_needed(cocoa_object)
		end

	set_becomes_key_only_if_needed (a_flag: BOOLEAN)
		do
			panel_set_becomes_key_only_if_needed(cocoa_object, a_flag)
		end

	works_when_modal : BOOLEAN
		do
			Result := panel_works_when_modal(cocoa_object)
		end

	set_works_when_modal (a_flag: BOOLEAN)
		do
			panel_set_works_when_modal(cocoa_object, a_flag)
		end

feature -- Objective-C implementation

	frozen panel_is_floating_panel (a_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSPanel*)$a_panel isFloatingPanel];"
		end

	frozen panel_set_floating_panel (a_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSPanel*)$a_panel setFloatingPanel: $a_flag];"
		end

	frozen panel_becomes_key_only_if_needed (a_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSPanel*)$a_panel becomesKeyOnlyIfNeeded];"
		end

	frozen panel_set_becomes_key_only_if_needed (a_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSPanel*)$a_panel setBecomesKeyOnlyIfNeeded: $a_flag];"
		end

	frozen panel_works_when_modal (a_panel: POINTER): BOOLEAN
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSPanel*)$a_panel worksWhenModal];"
		end

	frozen panel_set_works_when_modal (a_panel: POINTER; a_flag: BOOLEAN)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSPanel*)$a_panel setWorksWhenModal: $a_flag];"
		end

feature -- Constants

	frozen ok_button: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSOKButton;"
		end

	frozen cancel_button: INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return NSCancelButton;"
		end

end
