indexing
	description: "Shared settings between serializer gui and provider%
			%Used to pass location of serialized file."
	date: "$Date$"
	revision: "$Revision$"

class
	ECDS_SHARED_SETTINGS

feature -- Access

	serialized_tree_location: STRING is
			-- Serialized codedom tree location if any
		local
			l_key: REGISTRY_KEY
			l_path: SYSTEM_STRING
		do
			l_key := feature {REGISTRY}.local_machine.open_sub_key (Temp_key)
			if l_key /= Void then
				l_path ?= l_key.get_value (Serialized_path_key)
				if l_path /= Void then
					Result := l_path
				end
			end
		end

feature -- Element Settings

	set_serialized_tree_location (a_location: STRING) is
			-- Set `serialized_tree_location' with `a_location'.
		require
			non_void_location: a_location /= Void
			valid_location: not a_location.is_empty
		local
			l_key: REGISTRY_KEY
		do
			l_key := feature {REGISTRY}.local_machine.create_sub_key (Temp_key)
			if l_key /= Void then
				l_key.set_value (Serialized_path_key, a_location.to_cil)
			end
		ensure
			location_set: serialized_tree_location.is_equal (a_location)
		end

feature {NONE} -- Implementation

	Temp_key: STRING is "SOFTWARE\ISE\Eiffel Codedom Provider\Temp"
			-- Key to temporary values
	
	Serialized_path_key: STRING is "serialized_path"
			-- Key which holds path to serialized codedom tree

	Directory_separator: CHARACTER is
			-- Platform directory separator
		once
			Result := (create {OPERATING_ENVIRONMENT}).Directory_separator
		end
		
end -- class ECDS_SHARED_SETTINGS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Serializer
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------