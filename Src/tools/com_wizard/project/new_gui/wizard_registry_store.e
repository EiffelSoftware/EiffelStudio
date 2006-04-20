indexing
	description: "Expose features to persist and retrieve data to and from registry"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_REGISTRY_STORE

feature -- Access

	root_key: STRING is "hkey_current_user\software\ise\EiffelCOM Wizard\Settings\"
			-- Root registry key were all settings are saved

	saved_string (a_key: STRING): STRING is
			-- String value associated with `a_key'
		require
			non_void_key: a_key /= Void
			valid_key: is_saved_string (a_key)
		local
			l_registry: WEL_REGISTRY
			l_value: WEL_REGISTRY_KEY_VALUE
		do	
			create l_registry
			l_value := l_registry.open_key_value (root_key, a_key)
			if l_value /= Void and then l_value.type = l_value.reg_sz then
				Result := l_value.string_value
			end
		ensure
			non_void_string: Result /= Void
		end
	
	saved_integer (a_key: STRING): INTEGER is
			-- Integer value associated with `a_key'
		require
			non_void_key: a_key /= Void
			valid_key: is_saved_integer (a_key)
		do
			Result := saved_string (a_key).to_integer
		end
	
	saved_boolean (a_key: STRING): BOOLEAN is
			-- Boolean value associated with `a_key'
		require
			non_void_key: a_key /= Void
			valid_key: is_saved_boolean (a_key)
		do
			Result := saved_string (a_key).to_boolean
		end
	
	saved_list (a_key: STRING): LIST [STRING] is
			-- List associated with key `a_key'
		require
			non_void_key: a_key /= Void
			valid_key: is_saved_list (a_key)
		local
			l_value: STRING
		do
			l_value := saved_string (a_key)
			Result := decoded_list (l_value)
			Result.compare_objects
		ensure
			non_void_list: Result /= Void
			compare_objects: Result.object_comparison
		end

feature -- Status Report

	is_saved_string (a_key: STRING): BOOLEAN is
			-- Is there a string value associated with `a_key'?
		require
			non_void_key: a_key /= Void
		local
			l_registry: WEL_REGISTRY
			l_value: WEL_REGISTRY_KEY_VALUE
		do	
			create l_registry
			l_value := l_registry.open_key_value (root_key, a_key)
			Result := l_value /= Void and then l_value.type = l_value.reg_sz
		end
		
	is_saved_integer (a_key: STRING): BOOLEAN is
			-- Is there an integer value associated with `a_key'?
		require
			non_void_key: a_key /= Void
		local
			l_registry: WEL_REGISTRY
			l_value: WEL_REGISTRY_KEY_VALUE
		do
			create l_registry
			l_value := l_registry.open_key_value (root_key, a_key)
			Result := l_value /= Void and then l_value.type = l_value.reg_sz and then l_value.string_value.is_integer
		end
		
	is_saved_boolean (a_key: STRING): BOOLEAN is
			-- Is there a boolean value associated with `a_key'?
		require
			non_void_key: a_key /= Void
		local
			l_registry: WEL_REGISTRY
			l_value: WEL_REGISTRY_KEY_VALUE
		do
			create l_registry
			l_value := l_registry.open_key_value (root_key, a_key)
			Result := l_value /= Void and then l_value.type = l_value.reg_sz and then l_value.string_value.is_boolean
		end
		
	is_saved_list (a_key: STRING): BOOLEAN is
			-- Is there a list associated with `a_key'?
		require
			non_void_key: a_key /= Void
		do
			Result := is_saved_string (a_key)
		end

feature -- Basic Operations

	save_string (a_value, a_key: STRING) is
			-- Persist value `a_value' associated with key `a_key'.
			-- Override existing value associated with key `a_key' if any.
		require
			non_void_value: a_value /= Void
			non_void_key: a_key /= Void
		local
			l_value: WEL_REGISTRY_KEY_VALUE
			l_registry: WEL_REGISTRY
		do	
			create l_registry
			create l_value.make (feature {WEL_REGISTRY_KEY_VALUE_TYPE}.Reg_sz, a_value)
			l_registry.save_key_value (root_key, a_key, l_value)
		ensure
			saved: is_saved_string (a_key) and then saved_string (a_key).is_equal (a_value)
		end
		
	save_integer (a_value: INTEGER; a_key: STRING) is
			-- Persist value `a_value' associated with key `a_key'.
			-- Override existing value associated with key `a_key' if any.
		require
			non_void_key: a_key /= Void
		do
			save_string (a_value.out, a_key)
		ensure
			saved: is_saved_integer (a_key) and then saved_integer (a_key) = a_value
		end
		
	save_boolean (a_value: BOOLEAN; a_key: STRING) is
			-- Persist value `a_value' associated with key `a_key'.
			-- Override existing value associated with key `a_key' if any.
		require
			non_void_key: a_key /= Void
		do
			save_string (a_value.out, a_key)
		ensure
			saved: is_saved_boolean (a_key) and then saved_boolean (a_key) = a_value
		end
		
	save_list (a_list: LIST [STRING]; a_key: STRING) is
			-- Persist list `a_list' associated with key `a_key'.
			-- Override existing value associated with key `a_key' if any.
		require
			non_void_list: a_list /= Void
			non_void_key: a_key /= Void
		do
			a_list.compare_objects
			save_string (encoded_list (a_list), a_key)
		ensure
			saved: is_saved_list (a_key) and then saved_list (a_key).is_equal (a_list)
		end

	remove_entry (a_key: STRING) is
			-- Remove entry with key `a_key'.
		require
			non_void_key: a_key /= Void
		do	
			(create {WEL_REGISTRY}).delete_key_value (root_key, a_key)
		ensure
			removed: not is_saved_string (a_key) and not is_saved_integer (a_key) and
						not is_saved_boolean (a_key) and not is_saved_list (a_key)
		end
		
feature {NONE} -- Implementation

	encoded_list (a_list: LIST [STRING]): STRING is
			-- One string encoded list `a_list'
		require
			non_void_list: a_list /= Void
		do
			from
				create Result.make (240 * a_list.count)
				a_list.start
				if not a_list.after then
					Result.append (a_list.item)
					a_list.forth
				end
			until
				a_list.after
			loop
				Result.append_character (',')
				Result.append (a_list.item)
				a_list.forth
			end
		ensure
			non_void_encoded_list: Result /= Void
		end
	
	decoded_list (a_encoded_list: STRING): LIST [STRING] is
			-- List from encoded string created with `encoded_list'
		require
			non_void_encoded_list: a_encoded_list /= Void
		do
			Result := a_encoded_list.split (',')
		ensure
			non_void_result: Result /= Void
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
end -- class WIZARD_REGISTRY_STORE

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

