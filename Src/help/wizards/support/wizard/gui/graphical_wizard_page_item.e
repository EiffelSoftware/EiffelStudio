note
	description: "Summary description for {GRAPHICAL_WIZARD_PAGE_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GRAPHICAL_WIZARD_PAGE_ITEM

inherit
	WIZARD_PAGE_ITEM

feature -- Conversion

	widget: EV_WIDGET
		deferred
		end

	is_initialized: BOOLEAN
		do
			Result := widget /= Void
		end

end
