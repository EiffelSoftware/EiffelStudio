indexing
	description: "[
			Helper factory to create new TYPED_RESOURCEs.  This class is used by RESOURCE_MANAGER to 
			create new resources and values.  Use RESOURCE_MANAGER to manipulate RESOURCE objects in your
			code.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_FACTORY [G, H -> TYPED_RESOURCE [G] create make, make_from_string_value end]	

feature -- Commands

	new_resource (preferences: PREFERENCES; a_manager: RESOURCE_MANAGER; a_name, a_namespace: STRING; a_value: G): H is
			-- Create a new resource with name `a_name' and `a_value'.
		require
			preferences_not_void: preferences /= Void
			manager_not_void: a_manager /= Void
			not_has_resource: not a_manager.known_resource (a_name)
			name_valid: a_name /= Void 
			name_not_empty: not a_name.is_empty
			value_not_void: a_value /= Void
			namespace_not_void: a_namespace /= Void
			namespace_not_empty: not a_namespace.is_empty
		local
			l_fullname,
			l_value,
			l_desc: STRING
		do		
			l_fullname := a_namespace + "." + a_name					
			if preferences.session_values.has (l_fullname) then				
					-- Retrieve from saved values.
				l_value := preferences.session_values.item (l_fullname)
				create Result.make_from_string_value (a_manager, a_name, l_value)					
			elseif preferences.default_values.has (l_fullname) then
					-- Retrieve from default values.
				l_value ?= preferences.default_values.item (l_fullname).item (2)
				create Result.make_from_string_value (a_manager, a_name, l_value)				
			else				
					-- Create with `a_value'.
				create Result.make (a_manager, a_name, a_value)
			end
			
					-- Set the default value for future resetting by user.
			if preferences.default_values.has (l_fullname) then				
				l_desc ?= preferences.default_values.item (l_fullname).item (1)
				l_value ?= preferences.default_values.item (l_fullname).item (2)
				if l_desc /= Void then
					Result.set_description (l_desc)
				end				
				Result.set_default_value (l_value)
			end
			
					-- Add to list of know resources.
			preferences.resources.extend (Result, l_fullname)
		ensure
			has_result: Result /= Void
			resource_name_set: Result.name.is_equal (a_name)
			resource_added: preferences.has_resource (a_namespace + "." + a_name)
		end		

end -- class RESOURCE_FACTORY
