note
	description: "Summary description for {EWF_WIZARD_WINDOW}."
	date: "$Date$"
	revision: "$Revision$"

class
	EWF_WIZARD_WINDOW

inherit
	GRAPHICAL_WIZARD_WINDOW
		redefine
			side_bar_items
		end

feature {NONE} -- Initialization

	new_wizard: EWF_WIZARD
		do
			create Result.make (Current)
		end

feature -- Access

	side_bar_items (a_page: WIZARD_PAGE): ARRAYED_LIST [WIZARD_PAGE_ITEM]
		local
			lab: EV_LABEL
		do
			Result := Precursor (a_page)
			if a_page.page_id.is_case_insensitive_equal_general ("first")
				or a_page.page_id.is_case_insensitive_equal_general ("final")
			then
				create lab.make_with_text ("EiffelWeb")
				lab.set_foreground_color (colors.white)
				Result.extend (create {GRAPHICAL_WIZARD_PAGE_WIDGET}.make_with_widget (lab))
			end
		end

end
