-- Procedure text for class VIEW
-- (See ``Guided Tour'' of EiffelBuild manual.)

execute is
		-- Switch to file viewing.
	do
		if not asked_for_name then
			saved_text.wipe_out
			saved_text.append (build_open_argument1.text)
			asked_for_name := True
			file_box.popup (Current)
		else
			{BUILD_OPEN} Precursor
			if equal (open_label, transition_label) then
				build_open_argument1.set_read_only
				set_transition_label (view_label)
			end
		end
	end
