indexing
	description	: "Example on how to use the class WEL_DISK_SPACE"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	DISKSPACE_DEMO

creation
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

end -- class DISKSPACE_DEMO


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

