indexing
	description: "Window which displays a state which is neither final nor initial."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INTERMEDIARY_STATE_WINDOW

inherit
	WIZARD_STATE_WINDOW
		export
			{NONE} all
		end

feature {NONE} -- Basic Operations

	display is
			-- Display Current state.
		do 
			build_frame
			build
		end

	build_frame is
			-- Build widgets
		require
			main_box_empty: main_box.count=0
		local
			h1: EV_HORIZONTAL_BOX
			sep_h: EV_HORIZONTAL_SEPARATOR
			text: EV_LABEL
		do
			Create h1
			Create text.make_with_text(title)
			h1.extend(text)
			h1.extend(pixmap)
			main_box.extend(h1)
			main_box.disable_child_expand(h1)
			Create sep_h
			main_box.extend(sep_h)
			main_box.disable_child_expand(sep_h)
			Create text.make_with_text(message)
			main_box.extend(text)
			Create choice_box
			main_box.extend(choice_box)
		ensure
			main_box_has_at_least_one_element: main_box.count > 0
		end

feature {INTERMEDIARY_STATE_WINDOW} -- Implementation

	choice_box: EV_VERTICAL_BOX

end -- class INTERMEDIARY_STATE_WINDOW
