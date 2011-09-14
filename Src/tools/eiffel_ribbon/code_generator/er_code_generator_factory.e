note
	description: "[
					Code generater and tree manager factory for different generating modes:
					Application Modes or DLL
																							]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_CODE_GENERATOR_FACTORY

feature -- factory method

	code_generator: ER_COMMON_CODE_GENERATOR
			-- Code generator factory method
		local
			l_misc: ER_MISC_CONSTANTS
		do
			create l_misc
			if l_misc.is_using_application_mode.item then
				create {ER_CODE_GENERATOR_AM} Result.make
			else
				create {ER_CODE_GENERATOR} Result.make
			end
		end

	tree_manager: ER_LAYOUT_CONSTRUCTOR_TREE_MANAGER
			-- Tree manager factory method
		local
			l_misc: ER_MISC_CONSTANTS
		do
			create l_misc
			if l_misc.is_using_application_mode.item then
				create {ER_LAYOUT_CONSTRUCTOR_TREE_MANAGER_AM} Result.make
			else
				create {ER_LAYOUT_CONSTRUCTOR_TREE_MANAGER_DLL} Result.make
			end
		end

end
