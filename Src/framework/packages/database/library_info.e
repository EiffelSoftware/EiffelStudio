note
	date: "$Date$"
	revision: "$Revision$"

class
	LIBRARY_INFO

inherit
	HASHABLE

	DEBUG_OUTPUT

create
	make_from_conf_system,
	make

feature {NONE} -- Initialization

	make_from_conf_system (a_system: CONF_SYSTEM)
		do
			make (a_system.name, a_system.uuid, a_system.file_path)

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

	make (a_name: like name; a_uuid: like uuid; a_location: like location)
		do
			name := a_name
			uuid := a_uuid
			location := a_location

			create dependencies.make (1)
			create classes.make (5)
			is_application := False
		end

feature -- Access

	name: READABLE_STRING_32

	uuid: UUID

	location: PATH

	void_safety_option: detachable READABLE_STRING_8

	dependencies: ARRAYED_LIST [TUPLE [name: READABLE_STRING_GENERAL; location: READABLE_STRING_32; evaluated_location: PATH]]

	classes: ARRAYED_LIST [READABLE_STRING_32]

	hash_code: INTEGER
			-- Hash code value
		do
			Result := uuid.hash_code
		end

feature -- Status report

	is_application: BOOLEAN

	is_testing_project: BOOLEAN
		do
			Result := ∃ ic: dependencies ¦
					ic.location.starts_with ({STRING_32} "$ISE_LIBRARY\library\testing\testing")
		end

feature -- Change

	set_is_application (b: BOOLEAN)
		do
			is_application := b
		end

	set_void_safety_option (v: detachable READABLE_STRING_GENERAL)
		do
			if v = Void then
				void_safety_option := Void
			elseif v.is_valid_as_string_8 then
				void_safety_option := v.to_string_8
			else
				void_safety_option := Void
			end
		end

	add_dependency (a_lib: CONF_LIBRARY)
		do
			dependencies.force ([a_lib.name, a_lib.location.original_path, a_lib.location.evaluated_path])
		end

feature {NONE} -- Output

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
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
