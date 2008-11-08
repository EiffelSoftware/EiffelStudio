indexing
	description: "[
		Objects that implement {TEST_CLASS_LOCATOR_I} by traversing compiled descendants of
		{TEST_SET}.
		
		Note: {TEST_COMPILED_LOCATOR} is the counterpart to {EIFFEL_TEST_UNCOMPILED_LOCATOR},
		      which means they are optimized so each of them locates disjoint subsets of test classes..
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_COMPILED_LOCATOR

inherit
	TEST_CLASS_LOCATOR

feature {NONE} -- Query

	is_class_alive (a_class: !EIFFEL_CLASS_C): BOOLEAN is
			-- Is `a_class' registered in system and contains ast?
		do
			Result := a_class.is_valid and then a_class.has_ast
		end

	is_test_class (a_class: !EIFFEL_CLASS_I): BOOLEAN
			-- <Precursor>
		local
			l_ancestor: like common_ancestor
			l_retried: BOOLEAN
		do
			if not l_retried then
				if a_class.is_compiled and then {l_class: !EIFFEL_CLASS_C} a_class.compiled_class then
					l_ancestor := common_ancestor
					if l_ancestor /= Void and then l_ancestor.is_compiled then
						Result := l_class.conform_to (l_ancestor.compiled_class)
					end
				end
			end
		rescue
			l_retried := True
			retry
		end

feature {NONE} -- Implementation

	locate_classes is
			-- <Precursor>
		local
			l_ancestor: EIFFEL_CLASS_I
		do
			l_ancestor := common_ancestor
			if l_ancestor /= Void and then l_ancestor.is_compiled and then {a: EIFFEL_CLASS_C} l_ancestor.compiled_class then
				report_descendants (a)
			end
		end

	report_descendants (an_ancestor: !EIFFEL_CLASS_C) is
			-- Report effective descendants to project as potential test classes.
			--
			-- `an_ancestor': Recursively report all errektive descendants (including `an_ancestor') as
			--                potential test class to project.
		require
			an_ancestor_alive: is_class_alive (an_ancestor)
			locating: is_locating
		local
			l_list: ARRAYED_LIST [CLASS_C]
			l_test_class: !TEST_CLASS
			l_parse: BOOLEAN
			l_class: !EIFFEL_CLASS_I
		do
				-- Note: because of multiple inheritance and possible (but rare) corrupted EIFGENs we need to
				--       check whether class has already been added to project. Although this gets checked by
				--       the project, we make sure the class is not deferred before reporting.
			l_class ?= an_ancestor.original_class
			if not an_ancestor.is_deferred then
				project.report_test_class (l_class)
			end
			l_list := an_ancestor.direct_descendants
			from
				l_list.start
			until
				l_list.after
			loop
				if {l_ec: EIFFEL_CLASS_C} l_list.item and then is_class_alive (l_ec) then
					report_descendants (l_ec)
				end
				l_list.forth
			end
		end

end
