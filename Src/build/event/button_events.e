indexing
	description: "Page representing events that can %
				% be associated with a button."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class BUTTON_EVENTS 

inherit
	
    EVENT_PAGE
        redefine
            is_optional,
			make,
            make_button_visible
        end


creation

	make
	
feature {CATALOG}

	is_optional: BOOLEAN is True
	
feature {NONE}

	make (cat: like associated_catalog) is
		do
			{EVENT_PAGE} Precursor (cat)
			button_type := not_set
		end

feature {NONE}

	button_type: INTEGER

	not_set, toggle, other: INTEGER is UNIQUE

	symbol: PIXMAP is
		do
			Result := Pixmaps.button_pixmap
		end

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_button_pixmap
		end

	set_focus_string is
		do
			button.set_focus_string (Focus_labels.button_label)
		end

feature {CATALOG}
    
    make_button_visible (button_rc: ROW_COLUMN) is
            -- call cat_make_button_visible and set focus string for the button
        do
            {EVENT_PAGE} Precursor (button_rc)
            button.set_focus_string (Focus_labels.button_label)
        end

feature 

	update_content (a_context: CONTEXT) is
		local
			toggle_b_c: TOGGLE_B_C
			new_type: INTEGER
		do
			toggle_b_c ?= a_context
			if not (toggle_b_c = Void) then
				new_type := toggle
			else
				new_type := other
			end
			if new_type /= button_type then
				button_type := new_type
				wipe_out
				extend (but_arm_ev)
				extend (but_rel_ev)
				if (toggle_b_c = Void) then
					extend (but_act_ev)
				else
					extend (value_changed_ev)
				end
			end
		end

end
