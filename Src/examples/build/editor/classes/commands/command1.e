indexing
	visual_name: "View"

class COMMAND1

inherit
	BUILD_OPEN
		rename
			argument1 as build_open_argument1
		redefine
			execute, make
		end;
	SHARED

creation 
	make

feature  -- Initialization

	make (arg1: SCROLLED_T) is
		do
			argument1 := arg1
			{BUILD_OPEN} Precursor (arg1)
		end

feature  -- Command

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

feature  -- Access

	view_label: STRING is "view"
	
	argument1: SCROLLED_T

end -- class COMMAND1
