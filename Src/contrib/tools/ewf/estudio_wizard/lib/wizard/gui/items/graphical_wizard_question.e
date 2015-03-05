note
	description: "Summary description for {GRAPHICAL_WIZARD_QUESTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GRAPHICAL_WIZARD_QUESTION

inherit
	WIZARD_QUESTION
		redefine
			make
		end

	GRAPHICAL_WIZARD_INPUT_FIELD
		rename
			make as make_field
		undefine
			make_field
		end

feature {NONE} -- Initialization

	make (a_id: like id; a_title: READABLE_STRING_GENERAL; a_optional_description: detachable READABLE_STRING_GENERAL)
			-- Create field identified by `a_id', with title `a_title'
			-- and optional description `a_optional_description'.
		do
			Precursor (a_id, a_title, a_optional_description)

			initialize
		end

	initialize
		deferred
		ensure
			widget_created: widget /= Void
		end

feature {NONE} -- Implementation

	append_indented_widget (w: EV_WIDGET; a_container: EV_BOX)
		local
			lab: EV_LABEL
			hb: EV_HORIZONTAL_BOX
		do
			create hb
			append_cell_to (20, hb)

			hb.extend (w)
			hb.disable_item_expand (w)

			a_container.extend (hb)
			a_container.disable_item_expand (hb)
		end

end
