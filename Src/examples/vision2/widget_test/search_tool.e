indexing
	description: "Objects that provide facilities for searching an EV_TEXT"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SEARCH_TOOL
	
create
	make_with_ev_text
	
feature {NONE} -- Initialization

	make_with_ev_text (a_text: EV_TEXT) is
			-- Create `Current' and assign `a_text' to `text_control'.
		require
			a_text_not_void: a_text /= Void
		do
			text_control := a_text
		ensure
			text_control_set: text_control = a_text
		end

feature -- Access

	associate_text_entry (text_entry: EV_TEXT_FIELD) is
			-- Mark `text_entry' as associated text input field
			-- for searching.
		require
			text_entry_not_void: text_entry /= Void
		do
			internal_text_entry := text_entry
			internal_text_entry.change_actions.extend (agent update_text_entry_for_change)
		ensure
			text_entry_set: internal_text_entry = text_entry
		end

feature -- Status setting

	enable_case_matching is
			-- Ensure `case_matching is `True'
		do
			case_matching := True
			internal_text_entry.set_foreground_color ((create {EV_STOCK_COLORS}).black)
		ensure
			case_matching_on: case_matching
		end
		
	disable_case_matching is
			-- Ensure `case_matching is `False'
		do
			case_matching := False
			internal_text_entry.set_foreground_color ((create {EV_STOCK_COLORS}).black)
		ensure
			case_matching_off: not case_matching
		end

feature -- Basic operations

	search (a_string: STRING) is
			-- Search for `a_string' in `text' of `text_control'
			-- and highlight if found.
		local
			found_position,	caret_position: INTEGER
			search_text, search_string: STRING
		do
			search_string := a_string
			if not case_matching then
				search_string := search_string.as_upper
			end
			caret_position := text_control.caret_position
			search_text := text_control.text.substring (caret_position, text_control.text.count)
			if not case_matching then
				search_text := search_text.as_upper
			end
			found_position := search_text.substring_index (search_string, 1)
			if found_position = 0 then
				search_text := text_control.text.substring (1, caret_position)
				if not case_matching then
					search_text := search_text.as_upper
				end
				found_position := search_text.substring_index (search_string, 1)
			else
				found_position := found_position + caret_position
			end
			if found_position /= 0 then
				text_control.select_region (found_position, found_position + a_string.count - 1)
				text_control.set_focus
				text_control.scroll_to_line (text_control.current_line_number)
			else
				if internal_text_entry /= Void then
					internal_text_entry.set_foreground_color ((create {EV_STOCK_COLORS}).red)
				end
			end
		end

feature {NONE} -- Implementation

	update_text_entry_for_change is
			-- If `internal_text_entry' /= Void then update color.
		do
			if internal_text_entry /= Void then
				internal_text_entry.set_foreground_color ((create {EV_STOCK_COLORS}).black)
			end
		end
		

	text_control: EV_TEXT
		-- The control on which searching will be performed.
		
	case_matching: BOOLEAN
		-- Should searches match the case?
		
	last_search_location: INTEGER
		-- Last location from searching, if `text_control' does not have
		-- focus.
		
	internal_text_entry: EV_TEXT_FIELD
		-- text field used for inputting search strings.
		-- External to `Currrent' and may be Void if not associated.

end -- class SEARCH_TOOL
