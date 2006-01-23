indexing
	description	: "Example on how to use the class WEL_DISK_SPACE"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	DISKSPACE_DEMO

create
	make

feature -- Initialization

	make is
			-- Main Initialization routine.
		local
			drive: CHARACTER -- Current drive checked.
		do
			from
				drive := 'C'
				disk_space.query_local_drive(drive)
			until
				drive > 'Z'
			loop
				disk_space.query_local_drive(drive)
				if disk_space.last_query_success then
					io.putstring ("Drive ")
					io.putchar (drive)
					io.putstring (" :%T");
					io.putstring (disk_space.last_free_space_in_string+" Free / ")
					io.putstring (disk_space.last_total_space_in_string+ " Total")
					io.new_line
				end

				drive := drive + 1
			end
		end

	disk_space: WEL_DISK_SPACE is
			-- Object use to query disk space.
		once
			create Result
		end

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


end -- class DISKSPACE_DEMO


