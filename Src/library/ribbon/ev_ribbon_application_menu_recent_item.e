note
	description: "Summary description for {EV_RIBBON_APPLICATION_MENU_RECENT_ITEM}."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_APPLICATION_MENU_RECENT_ITEM

feature -- Query

	label: detachable STRING_32
			-- String label

feature -- Command

	set_label (a_label: like label)
			-- Set `label' with `a_label'
		do
			label := a_label
		ensure
			set: label = a_label
		end

end
