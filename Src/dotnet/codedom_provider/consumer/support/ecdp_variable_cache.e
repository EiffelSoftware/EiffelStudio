indexing
	description: "Record all variables in currently analyzed type to resolve Eiffel names and types	"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_VARIABLE_CACHE

feature -- Access

	variable_type (a_name: STRING): STRING is
			-- Type of feature `a_name'
		do
			Variables.search (a_name)
			if Variables.found then
				Result := Variables.found_item
			else
				(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Variable_name_not_found, [a_name])
			end
		end

	is_variable (a_name: STRING): BOOLEAN is
			-- Is `a_name' a variable name?
		do
			Result := Variables.has (a_name)
		end

	cast_variable_suffix: STRING is
			-- Assignment attempt assignee suffix
		do
			Result := Cast_variable_number.out
		end
	
feature -- Basic Operations

	increase_cast_variable_suffix is
			-- Increase number for assignment attempt assignee suffix
		do
			Cast_variable_number.put (Cast_variable_number.item + 1)
		end
		
	add_variable (a_type_name: STRING; a_unique_variable_name: STRING) is
			-- Add variable `a_unique_variable_name' with type `a_type_name' to `Variables'.
		require
			non_void_a_type_name: a_type_name /= Void
			not_empty_a_type_name: not a_type_name.is_empty
			non_void_a_variable_name: a_unique_variable_name /= Void
			not_empty_a_variable_name: not a_unique_variable_name.is_empty
		do
			Variables.put (a_type_name, a_unique_variable_name)
		ensure
			variable_set: Variables.has_item (a_type_name)
		end

	clear_all_local_variables is
			-- clear all content of `variables'
		do
			Variables.clear_all
			Cast_variable_number.put (1)
		end

feature {NONE} -- Implementation

	Variables: HASH_TABLE [STRING, STRING] is
			-- All variables in current_feature: parameters and locals
			-- Value: `STRING' corresponding to Eiffel type name
			-- Key: ID corresponding to the Eiffel variable name]
		once
			create Result.make (20)
		ensure
			non_void_result: Result /= Void
		end

	Cast_variable_number: CELL [INTEGER] is
			-- number of cast local variable.
		once
			create Result.put (1)
		ensure
			non_void_result: Result /= Void
		end

end -- class ECDP_VARIABLE_CACHE

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