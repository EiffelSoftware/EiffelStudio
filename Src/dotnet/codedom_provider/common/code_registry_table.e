indexing
	description: "Table of value/key pairs persisted in the Windows registry%
						% Allows for multiple keys to be associated with the same value%
						% Two registry hives will be created:%
						%  * The key hive associates keys with a unique ID%
						%  * The value hive associates values with the unique ID corresponding to the matching key"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	note: "Some features of this class may raise exceptions if user doesn't have access rights%
				%to the corresponding registry hive."
class
	CODE_REGISTRY_TABLE

create
	make

feature {NONE} -- Initialization

	make (a_value_hive, a_key_hive: STRING) is
			-- Set `value_hive' and `key_hive'.
			-- These are paths under `HKCU'/`HKLM' where values and keys will be stored.
			-- E.g. 'Software\ISE\Eiffel CodeDom Provider\5.6\Configurations' and 'Software\ISE\Eiffel CodeDom Provider\5.6\Applications'
		require
			non_void_value_hive: a_value_hive /= Void
			non_void_key_hive: a_key_hive /= Void
		do
			value_hive := a_value_hive
			key_hive := a_key_hive
		ensure
			value_hive_set: value_hive = a_value_hive
			key_hive_set: key_hive = a_key_hive
		end

feature -- Access

	item (a_key: STRING): STRING is
			-- Value associated with key `a_key'
		require
			non_void_key: a_key /= Void
		local
			l_key: REGISTRY_KEY
			l_guid: STRING
			l_value: SYSTEM_STRING
		do
			l_guid := guid_from_key (a_key)
			if l_guid /= Void then
				l_key := {REGISTRY}.current_user.open_sub_key (value_hive, False)
				if l_key /= Void then
					l_value ?= l_key.get_value (l_guid.to_cil)
					if l_value /= Void then
						Result := l_value
					end
					l_key.close
				end
			end
		ensure
			non_void_result_iff_has_key: has (a_key) = (Result /= Void)
		end

	current_keys: LIST [STRING] is
			-- All registered keys
		local
			l_key: REGISTRY_KEY
			i, l_count: INTEGER
			l_guids: NATIVE_ARRAY [SYSTEM_STRING]
			l_value: SYSTEM_STRING
		do
			l_key := {REGISTRY}.current_user.open_sub_key (key_hive, False)
			if l_key /= Void then
				l_guids := l_key.get_value_names
				from
					l_count := l_guids.count
					create {ARRAYED_LIST [STRING]} Result.make (l_count)
				until
					i = l_count
				loop
					l_value ?= l_key.get_value (l_guids.item (i))
					Result.extend (l_value)
					i := i + 1
				end
				l_key.close
			end			
		end
		
	linear_representation: LIST [STRING] is
			-- All registered values
		local
			l_key: REGISTRY_KEY
			i, l_count: INTEGER
			l_guids: NATIVE_ARRAY [SYSTEM_STRING]
			l_value: SYSTEM_STRING
		do
			l_key := {REGISTRY}.current_user.open_sub_key (value_hive, False)
			if l_key /= Void then
				l_guids := l_key.get_value_names
				from
					l_count := l_guids.count
					create {ARRAYED_LIST [STRING]} Result.make (l_count)
					Result.compare_objects
				until
					i = l_count
				loop
					l_value ?= l_key.get_value (l_guids.item (i))
					if not Result.has (l_value) then -- There can be multiple guids for the same value because
						Result.extend (l_value)			-- multiple keys may have the same value
					end
					i := i + 1
				end
				l_key.close
			end			
		end

	value_hive: STRING
			-- Path under `HKCU'/`HKLM' where values will be stored

	key_hive: STRING
			-- Path under `HKCU'/`HKLM' where keys will be stored

feature -- Status Report

	has (a_key: STRING): BOOLEAN is
			-- Does key hive has entry `a_key'?
		require
			non_void_key: a_key /= Void
		do
			Result := guid_from_key (a_key) /= Void
		end

feature -- Basic Operations

	put (a_value, a_key: STRING) is
			-- Add value `a_value' associated with key `a_key'.
		require
			non_void_value: a_value /= Void
			non_void_key: a_key /= Void
			not_has_key: not has (a_key)
		local
			l_key: REGISTRY_KEY
			l_guid: SYSTEM_STRING
		do
			l_guid := {GUID}.new_guid.to_string
			l_key := {REGISTRY}.current_user.open_sub_key (key_hive, True)
			if l_key = Void then
				l_key := {REGISTRY}.current_user.create_sub_key (key_hive)
			end
			l_key.set_value (l_guid, a_key.to_cil)
			l_key.close
			replace (a_value, a_key)
		end
	
	replace (a_value, a_key: STRING) is
			-- Change value associated with key `a_key' to `a_value'.
		require
			non_void_value: a_value /= Void
			non_void_key: a_key /= Void
			has_key: has (a_key)
		local
			l_key: REGISTRY_KEY
			l_guid: STRING
		do
			l_guid := guid_from_key (a_key)
			l_key := {REGISTRY}.current_user.open_sub_key (value_hive, True)
			if l_key = Void then
				l_key := {REGISTRY}.current_user.create_sub_key (value_hive)
			end
			l_key.set_value (l_guid, a_value.to_cil)
			l_key.close
		end
	
	remove (a_key: STRING) is
			-- Remove value associated with key `a_key'.
		require
			non_void_key: a_key /= Void
			has_key: has (a_key)
		local
			l_key: REGISTRY_KEY
			l_guid: STRING
		do
			l_guid := guid_from_key (a_key)
			l_key := {REGISTRY}.current_user.open_sub_key (value_hive, True)
			if l_key /= Void then
				l_key.delete_value (l_guid)
				l_key.close
			end
			l_key := {REGISTRY}.current_user.open_sub_key (key_hive, True)
			if l_key /= Void then
				l_key.delete_value (l_guid)
				l_key.close
			end
		end

feature {NONE} -- Implementation

	guid_from_key (a_key: STRING): STRING is
			-- GUID associated with key `a_key'
		require
			non_void_key: a_key /= Void
		local
			l_key: REGISTRY_KEY
			l_values: NATIVE_ARRAY [SYSTEM_STRING]
			i, l_count: INTEGER
			l_value: SYSTEM_STRING
		do
			l_key := {REGISTRY}.current_user.open_sub_key (key_hive, False)
			if l_key /= Void then
				l_values := l_key.get_value_names
				from
					l_count := l_values.count
				until
					i = l_count or Result /= Void
				loop
					l_value ?= l_key.get_value (l_values.item (i))
					if l_value /= Void and then l_value.equals (a_key.to_cil) then
						Result := l_values.item (i)
					end
					i := i + 1
				end
				l_key.close
			end
		ensure
			non_void_guid_if_has_key: has (a_key) implies Result /= Void
		end

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


end -- class CODE_REGISTRY_TABLE

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