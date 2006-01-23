indexing
	description: "Registry manager"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	WEL_REGISTRY_KEY

create
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

	last_change: WEL_FILE_TIME;
			-- Last modification time

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




end -- class WEL_REGISTRY_KEY

