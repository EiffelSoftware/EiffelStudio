indexing
	description: "Registry manager"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	WEL_REGISTRY_KEY

creation
	make
	
feature -- Initialization

	make (a_name, a_class_id: STRING; a_modification_time: WEL_FILE_TIME) is
			-- Create current instance.
		do
			name := a_name
			class_id := a_class_id
			last_change := a_modification_time
		ensure
			name_set: name = a_name
			class_id_set: class_id = a_class_id
			last_change_set: last_change = a_modification_time
		end
		
feature -- Access

	name: STRING
			-- Name of key
		
	class_id: STRING
			-- Class of key

	last_change: WEL_FILE_TIME
			-- Last modification time

end -- class WEL_REGISTRY_KEY

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

