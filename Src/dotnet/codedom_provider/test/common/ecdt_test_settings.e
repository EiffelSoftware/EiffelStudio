indexing
	description: "Test settings, such as path to codedom trees"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDT_TEST_SETTINGS

inherit
	ECD_SHARED_EVENT_MANAGER

feature -- Access

	Codedom_trees_key: STRING is "Software\ISE\Eiffel Codedom Provider\Test\Codedom Trees"
			-- Registry key holding path to serialized codedom trees

	codedom_trees_directory: STRING is
			-- Path to serialized codedom trees
		local
			l_key: REGISTRY_KEY
		do
			l_key := feature {REGISTRY}.local_machine.open_sub_key (Codedom_trees_key, False)
			if l_key /= Void then
				
			else
				Event_manager.raise_event (feature {ECD_EVENTS_IDS}.Missing_config, ["Codedom Trees"])
		end
	
	compile_units_directory: STRING is
			-- Path to compile units codedom trees
		local
			l_path: STRING
		do
			l_path := codedom_trees_directory
			create Result.make (l_path.count + 14)
			Result.append (l_path)
			Result.append ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			Result.append ("compile_units")
		end
		
	namespaces_directory: STRING is
			-- Path to compile units codedom trees
		local
			l_path: STRING
		do
			l_path := codedom_trees_directory
			create Result.make (l_path.count + 11)
			Result.append (l_path)
			Result.append ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			Result.append ("namespaces")
		end
		
	types_directory: STRING is
			-- Path to compile units codedom trees
		local
			l_path: STRING
		do
			l_path := codedom_trees_directory
			create Result.make (l_path.count + 6)
			Result.append (l_path)
			Result.append ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			Result.append ("types")
		end
		
	expressions_directory: STRING is
			-- Path to compile units codedom trees
		local
			l_path: STRING
		do
			l_path := codedom_trees_directory
			create Result.make (l_path.count + 12)
			Result.append (l_path)
			Result.append ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			Result.append ("expressions")
		end
		
	statements_directory: STRING is
			-- Path to compile units codedom trees
		local
			l_path: STRING
		do
			l_path := codedom_trees_directory
			create Result.make (l_path.count + 11)
			Result.append (l_path)
			Result.append ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			Result.append ("statements")
		end
		
end -- class ECDT_TEST_SETTINGS

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
