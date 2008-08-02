indexing
	description: "[
		Objects that scan a project for tests by traversing fully compiled descendants of {TEST_SET}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_TEST_COMPILED_LOCATOR

inherit
	EIFFEL_TEST_CLASS_LOCATOR

feature {NONE} -- Query

	is_class_alive (a_class: !EIFFEL_CLASS_C): BOOLEAN is
			-- Is `a_class' registered in system and contains ast?
		do
			Result := a_class.is_valid and then a_class.has_ast
		end

--	is_valid_compiled_class (a_class: !EIFFEL_CLASS_C): BOOLEAN is
--			-- Can `a_class' contain test routines?
--		local
--			l_ancestor: EIFFEL_CLASS_I
--		do
--			l_ancestor := common_ancestor
--			if l_ancestor.is_compiled then
--				Result := is_class_alive (a_class) and then
--					is_valid_class_as ({!CLASS_AS} #? a_class.ast) and
--					a_class.conform_to (l_ancestor.compiled_class)
--			end
--		end

feature {NONE} -- Implementation

	locate_classes is
			-- <Precursor>
		local
			l_ancestor: EIFFEL_CLASS_I
		do
			l_ancestor := common_ancestor
			if l_ancestor.is_compiled then
				find_descendants ({!EIFFEL_CLASS_C} #? l_ancestor.compiled_class)
			end
		end

	find_descendants (an_ancestor: !EIFFEL_CLASS_C) is
			-- Fill `test_class_map' with classes containing test routines resusing
			-- existing items. For new or modified classes, parse list of test routines
			-- and addopt `test_routine_map' accordingly and notify observers of any changes.
			--
			-- `an_ancestor': Look in effective descendants (excluding `an_ancestor') for test
			-- 		routines. `fill_test_class_map' will call itself recursively for each
			-- 		descendant found.
		require
			an_ancestor_alive: is_class_alive (an_ancestor)
		local
			l_list: ARRAYED_LIST [CLASS_C]
			l_test_class: !EIFFEL_TEST_CLASS
			l_parse: BOOLEAN
			l_class: !EIFFEL_CLASS_I
		do
				-- Note: because of multiple inheritance and possible (but rare)
				-- corrupted EIFGENs we need to check whether `test_class_map'
				-- already contains item for `an_ancestor'
			l_class ?= an_ancestor.original_class
			project.report_test_class (l_class)
			l_list := an_ancestor.direct_descendants
			from
				l_list.start
			until
				l_list.after
			loop
				if {l_ec: !EIFFEL_CLASS_C} l_list.item and then is_class_alive (l_ec) then
					find_descendants (l_ec)
				end
				l_list.forth
			end
		end

end
