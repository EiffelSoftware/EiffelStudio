indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_FINAL_STATE_WINDOW

inherit
	WIZARD_STATE_WINDOW
		export
			{NONE} all
		redefine
			proceed_with_current_info,is_final_state
		end

feature -- Basic Operations

	build is
			-- Special display box for the first and the last state
		local
			text: EV_LABEL
			h1: EV_HORIZONTAL_BOX
			v1, v2: EV_VERTICAL_BOX
			sep_v: EV_VERTICAL_SEPARATOR
		do
			first_window.set_final_state
			Create h1
			Create text.make_with_text(message)
			Create sep_v
			h1.extend(pixmap)
			h1.extend(sep_v)
			h1.extend(text)
			h1.disable_child_expand(sep_v)
			main_box.extend(h1)			
		end

	proceed_with_current_info is
			-- destroy the window.
			-- Descendants have to redefine this routine
			-- if they want to add generation, warnings, ...
		do
			precursor
			first_window.destroy
		ensure then
			application_dead: first_window.is_destroyed
		end

feature {NONE}-- Access

	is_final_state: BOOLEAN is TRUE

end -- class WIZARD_FINAL_STATE_WINDOW
