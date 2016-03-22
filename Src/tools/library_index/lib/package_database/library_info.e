note
	description: "Summary description for {LIBRARY_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_INFO

inherit
	HASHABLE

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_system: CONF_SYSTEM)
		do
			name := a_system.name
			uuid := a_system.uuid
			location := a_system.file_path
			create dependencies.make (1)
			create classes.make (5)

			if
				attached a_system.library_target as t and then
				attached t.root as l_root_info
			then
				is_application := not l_root_info.is_all_root
				void_safety_option := t.options.void_safety.out
			else
				void_safety_option := Void
			end
		end

feature -- Access

	name: READABLE_STRING_8

	uuid: UUID

	location: PATH

	void_safety_option: detachable READABLE_STRING_8

	dependencies: ARRAYED_LIST [TUPLE [name: READABLE_STRING_GENERAL; location: READABLE_STRING_32; evaluated_location: PATH]]

	classes: ARRAYED_LIST [READABLE_STRING_8]

	hash_code: INTEGER
			-- Hash code value
		do
			Result := uuid.hash_code
		end

feature -- Status report

	is_application: BOOLEAN

	is_testing_project: BOOLEAN
		do
			Result := across dependencies as ic some
							ic.item.location.starts_with ({STRING_32} "$ISE_LIBRARY\library\testing\testing")
						end
		end

feature -- Change

	add_dependency (a_lib: CONF_LIBRARY)
		do
			dependencies.force ([a_lib.name, a_lib.location.original_path, a_lib.location.evaluated_path])
		end

feature -- Status report

	debug_output: STRING_32
		do
			create Result.make_empty
			Result.append (name)
			Result.append (" :")
			Result.append_integer (classes.count)
			Result.append (" classes")
			Result.append (" (")
			Result.append (location.name)
			Result.append (")")
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
