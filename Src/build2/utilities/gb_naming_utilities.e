indexing
	description: "Objects that provide useful functions for naming."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_NAMING_UTILITIES

feature -- Basic operations

	valid_class_name (a_name: STRING): BOOLEAN is
			-- Check that name `class_name' is a valid class name.
		local
			cn: STRING
			cchar: CHARACTER
			i: INTEGER
		do
			Result := True
			cn := a_name
			if not cn.is_empty then
				if cn = void or else not (cn @ 1).is_alpha then
					Result := False
				else
					from
						i := 2
					until
						i > cn.count or not Result
					loop
						cchar := (cn @ i)
						Result := cchar.is_alpha or cchar.is_digit or cchar = '_'
						i := i + 1
					end
				end
			else
				Result := False
			end
		end


	unique_name (existing_names: ARRAYED_LIST [STRING]; hint_name: STRING): STRING is
			-- `Result' is a STRING guaranteed not to be contained in `existing_names',
			-- which is the value of `hint_name' with an underscore and a number appended to it.
			-- The algorithm used does not guarantee that this is the first available number.
		local
			names: ARRAYED_LIST [STRING]
			matches: INTEGER
			hint_name_lower, item_lower: STRING
			suggested_result: STRING
		do
			hint_name_lower := hint_name
			hint_name_lower.to_lower
				-- We clone `existing_names' so when we compare references, we
				-- do not affect the list that was passed in.
			names := clone (existing_names)
			names.compare_objects
			from
				names.start
			until
				names.off
			loop
				item_lower := names.item
				item_lower.to_lower
					-- This converts the list names to lower case.
					-- This is essential for "not has" used at end of this feature.
				names.replace (item_lower)
				if item_lower.count > hint_name_lower.count and
					item_lower.substring (1, hint_name_lower.count).is_equal (hint_name_lower) then
					matches := matches + 1	
				end
				names.forth
			end
				-- Increase matches for initial suggested name.
			matches := matches + 1
			
			suggested_result := hint_name_lower + "_" + matches.out
			if names.has (suggested_result) then
				from
				until
					not names.has (suggested_result)
				loop
					matches := matches + 1
					suggested_result := hint_name_lower + "_" + matches.out
				end
				Result := suggested_result
			else
				Result := suggested_result
			end
				-- Unable to provide a postcondition, so we have a check instead.
			check
				Result_is_uniqe_name: not names.has (Result)
			end
		end
		
	undo_last_character (text_field: EV_TEXT_FIELD) is
			-- Remove last character added to `text_field'.
			-- Dependent on caret position, so this should be called
			-- immediately after the change, and before anything modifies
			-- the caret position.
			-- The change_actions of `text_field' are blocked.
		local
			current_caret_position: INTEGER
		do
			current_caret_position := text_field.caret_position
				text_field.change_actions.block
					-- We must handle three different cases in order to restore the text if an
					-- invalid character was received.
				if current_caret_position = text_field.text.count + 1 then
					text_field.set_text (text_field.text.substring (1, text_field.text.count - 1))
					text_field.set_caret_position (current_caret_position - 1)
				elseif current_caret_position = 2 then
					text_field.set_text (text_field.text.substring (2, text_field.text.count))	
					text_field.set_caret_position (1)
				else
					text_field.set_text (text_field.text.substring (1, current_caret_position - 2) + text_field.text.substring (current_caret_position, text_field.text.count))
					text_field.set_caret_position (current_caret_position - 1)
				end
				text_field.change_actions.resume
		end
		

end -- class GB_NAMING_UTILITIES
