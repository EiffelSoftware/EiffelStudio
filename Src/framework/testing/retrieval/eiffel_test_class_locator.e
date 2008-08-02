indexing
	description: "[
		Objects that partially implement {EIFFEL_TEST_CLASS_LOCATOR_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_TEST_CLASS_LOCATOR

inherit
	EIFFEL_TEST_CLASS_LOCATOR_I
		rename
			locate_classes as internal_locate_classes
		end

	SHARED_TEST_CONSTANTS

feature -- Access

	project: !EIFFEL_TEST_PROJECT is
			-- <Precursor>
		do
			Result ?= internal_project
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
			l_universe := project.project.system.universe
			l_lib_list := l_universe.library_of_uuid (l_uuid, False)
			if not l_lib_list.is_empty then
				l_lib := l_lib_list.first
				if {l_ec: !EIFFEL_CLASS_I} l_universe.class_named (common_test_class_ancestor_name, l_lib) then
					Result := l_ec
				end
			end
		end

feature -- Status report

	is_locating: BOOLEAN
			-- <Precursor>

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature {EIFFEL_TEST_PROJECT_I} -- Status setting

	frozen internal_locate_classes (a_project: like project)
			-- <Precursor>
		do
			is_locating := True
			internal_project := a_project
			locate_classes
			is_locating := False
		end

	locate_classes
			-- Locate potential test classes in `project'.
		require
			locating: is_locating
		deferred
		end

end
