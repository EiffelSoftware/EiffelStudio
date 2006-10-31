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

create 
	make

feature  -- Initialization

	make (arg1: SCROLLED_T) is
		do
			argument1 := arg1
			Precursor {BUILD_OPEN} (arg1)
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
				Precursor {BUILD_OPEN}
				if equal (open_label, transition_label) then
					build_open_argument1.set_read_only
					set_transition_label (view_label)
				end
			end
		end

feature  -- Access

	view_label: STRING is "view"
	
	argument1: SCROLLED_T;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class COMMAND1
