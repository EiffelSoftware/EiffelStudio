indexing
	description: "Sets information for a connection. Inherited by main_window"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DB_CONNECTION
	
feature -- Use

	retrieve_info is
			-- Sets information.
		do
			username:= "<TAG_USERNAME>"
			password:= "<TAG_PASSWORD>"
			data_source:= "<TAG_DATA_SOURCE>"
		ensure
			not_void: username /= Void and then password /= Void and then data_source /= Void
		end

feature -- Implementation

	username: STRING
		-- Username given in the wizard.
		
	password: STRING
		-- Password given in the wizard.
	
	data_source: STRING
		-- Data source given in the wizard.
	
end -- class DB_CONNECTION


--|----------------------------------------------------------------
--| Eiffel COOL:Jex: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
