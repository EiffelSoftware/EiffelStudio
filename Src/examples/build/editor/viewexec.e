-- Procedure text for class VIEW
-- (See ``Guided Tour'' of EiffelBuild manual.)
execute is
		-- Switch to file viewing.
	do
		if not asked_for_name then
			saved_text.wipe_out;
			saved_text.append (open_argument1.text);
			asked_for_name := true;
			file_box.popup (Current)
		else
			open_execute;
			if equal (open_label, transition_label) then
				open_argument1.set_read_only;
				set_transition_label (view_label)
			end
		end
	end
