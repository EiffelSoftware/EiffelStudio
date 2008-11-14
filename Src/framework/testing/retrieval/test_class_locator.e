indexing
	description: "[
		Objects that partially implement {TEST_CLASS_LOCATOR_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEST_CLASS_LOCATOR

inherit
	TEST_CLASS_LOCATOR_I
		rename
			locate_classes as locate_class_impl,
			is_test_class as is_test_class_impl
		end

feature -- Access

	project: !TEST_PROJECT is
			-- <Precursor>
		local
			l_project: like internal_project
		do
			l_project := internal_project
			check l_project /= Void end
			Result := l_project
		end

feature {NONE} -- Access

	internal_project: ?like project
			-- Internal storage of project

feature {NONE} -- Query

	common_ancestor: ?EIFFEL_CLASS_I is
			-- Look for compiled test class ancestor and store it in
			-- `common_compiled_ancestor' if found.
		require
			locating: is_locating
		local
			l_uuid: UUID
			l_lib_list: LIST [CONF_LIBRARY]
			l_lib: CONF_LIBRARY
			l_universe: UNIVERSE_I
		do
			create l_uuid.make_from_string ("B77B3A44-A1A9-4050-8DF9-053598561C33")
			l_universe := project.eiffel_project.system.universe
			l_lib_list := l_universe.library_of_uuid (l_uuid, False)
			if not l_lib_list.is_empty then
				l_lib := l_lib_list.first
				if {l_ec: !EIFFEL_CLASS_I} l_universe.safe_class_named ({TEST_CONSTANTS}.common_test_class_ancestor_name, l_lib) then
					Result := l_ec
				end
			end
		end

feature -- Status report

	is_locating: BOOLEAN
			-- <Precursor>
		do
			Result := internal_project /= Void
		end

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature {TEST_PROJECT_I} -- Status setting

	frozen locate_class_impl (a_project: like project)
			-- <Precursor>
		do
			internal_project := a_project
			locate_classes
			internal_project := Void
		end

feature {TEST_PROJECT_I} -- Query

	is_test_class_impl (a_class: !EIFFEL_CLASS_I; a_project: like project): BOOLEAN
			-- <Precursor>
		do
			internal_project := a_project
			Result := is_test_class (a_class)
			internal_project := Void
		end

feature {NONE} -- Query

	is_test_class (a_class: !EIFFEL_CLASS_I): BOOLEAN
			-- Is `a_class' a valid test class?
		require
			locating: is_locating
		deferred
		end

feature {NONE} -- Implementation

	locate_classes
			-- Locate potential test classes in `eiffel_project'.
		require
			locating: is_locating
		deferred
		end

end
