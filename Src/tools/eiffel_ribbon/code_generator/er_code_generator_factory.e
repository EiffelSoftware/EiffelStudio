note
	description: "Summary description for {ER_CODE_GENERATOR_FACTORY}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_CODE_GENERATOR_FACTORY

feature -- factory method

	code_generator: ER_COMMON_CODE_GENERATOR
			--
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
			--
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
