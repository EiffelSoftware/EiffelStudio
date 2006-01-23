indexing
	description: "Persist and retrieve settings by name%
					%For now settings consist of strictly positive integer or strings.%
					%A value of 0 or Void means that the setting hasn't been initialized"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SETTINGS_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_path: STRING) is
			-- Set `registry_path' with `a_path'.
		require
			non_void_path: a_path /= Void
			valid_path: {REGISTRY}.current_user.create_sub_key (a_path) /= Void
		do
			registry_path := a_path
		ensure
			path_set: registry_path = a_path
		end
		
feature -- Access

	registry_path: STRING
			-- Path to registry settings

	setting (a_name: STRING): INTEGER is
			-- Integer value stored under `a_name' in `registry_path' registry hive
			-- 0 if none
		require
			non_void_name: a_name /= Void
		local
			l_key: REGISTRY_KEY
		do	
			l_key := {REGISTRY}.current_user.open_sub_key (registry_path, False)
			if l_key /= Void then
				Result ?= l_key.get_value (a_name)
			end
			if Result = 0 then
				Default_values.search (a_name)
				if Default_values.found then
					Result := Default_values.found_item
				end
			end
		ensure
			valid_result: Result > 0 or else 
			((Default_values.found implies Result = Default_values.item (a_name)) and
			(not Default_values.found implies Result = 0))
		end

	text_setting (a_name: STRING): STRING is
			-- String value stored under `a_name' in `registry_path' registry hive
			-- Empty string if none
		require
			non_void_name: a_name /= Void
		local
			l_key: REGISTRY_KEY
			l_string: SYSTEM_STRING
		do	
			l_key := {REGISTRY}.current_user.open_sub_key (registry_path, False)
			if l_key /= Void then
				l_string ?= l_key.get_value (a_name)
				if l_string /= Void then
					Result := l_string
				end
			end
			if Result = Void then
				Default_text_values.search (a_name)
				if Default_text_values.found then
					Result := Default_text_values.found_item
				else
					create Result.make_empty
				end
			end
		ensure
			non_void_setting: Result /= Void
		end

	Default_values: HASH_TABLE [INTEGER, STRING] is
			-- Default values if none were found in registry
		once
			create Result.make (16)
		end

	Default_text_values: HASH_TABLE [STRING, STRING] is
			-- Default text values if none were found in registry
		once
			create Result.make (16)
		end

feature -- Basic Operations

	set_setting (a_name: STRING; a_value: INTEGER) is
			-- Set value stored under `a_name' in `registry_path' registry hive
		require
			non_void_name: a_name /= Void
		local
			l_key: REGISTRY_KEY
		do 
			l_key := {REGISTRY}.current_user.open_sub_key (registry_path, True)
			if l_key = Void then
				l_key := {REGISTRY}.current_user.create_sub_key (registry_path)
			end
			l_key.set_value (a_name, a_value)
		ensure
			value_set: setting (a_name) = a_value
		end

	set_text_setting (a_name: STRING; a_value: STRING) is
			-- Set value stored under `a_name' in `registry_path' registry hive
		require
			non_void_name: a_name /= Void
			non_void_value: a_value /= Void
		local
			l_key: REGISTRY_KEY
		do 
			l_key := {REGISTRY}.current_user.open_sub_key (registry_path, True)
			if l_key = Void then
				l_key := {REGISTRY}.current_user.create_sub_key (registry_path)
			end
			l_key.set_value (a_name, a_value.to_cil)
		ensure
			value_set: text_setting (a_name).is_equal (a_value)
		end

invariant
	non_void_registry_path: registry_path /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CODE_SETTINGS_MANAGER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------