note
	description: "Used for global once storage for EV_ENVIRONMENT_I."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ENVIRONMENT_HANDLER

inherit
	EV_ANY_HANDLER

create {EV_ENVIRONMENT_I}
	make

feature {NONE} -- Creation

	make
			-- Create and initialize handler for EV_ENVIRONMENT.
		do
			create {EV_APPLICATION_IMP} application_i.make
			create internal_helper
		end

feature {EV_ENVIRONMENT_I} -- Access

	application: detachable EV_APPLICATION
		do
			Result := application_i.interface
		end

	application_i: EV_APPLICATION_I;
		-- Application implementation object.

feature -- Object Factory

	new_object_from_type_id (a_type_id: INTEGER): EV_ANY
		do
			check attached {EV_ANY} internal_helper.new_instance_of (a_type_id) as l_any then
					-- Make sure that default_create is called on new instance.
				l_any.default_create
				Result := l_any
			end
		end

	string_from_separate_string (a_string: separate READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- Create a new string on the same processor of `Current'.
		local
			i, l_count: INTEGER
			l_code: NATURAL_32
			l_string: STRING_GENERAL
		do
			l_count := a_string.count
			if a_string.is_string_8 then
					-- Make `Result' a STRING_8 if `a_string' is to save memory.
				create {STRING_8} l_string.make_filled ('%U', l_count)
			else
				create {STRING_32} l_string.make_filled ('%U', l_count)
			end
			from
				i := 1
			until
				i > l_count
			loop
				l_code := a_string.code (i)
				l_string.put_code (l_code, i)
				i := i + 1
			end
			Result := l_string
		end

feature {NONE} -- Implementation

	internal_helper: INTERNAL;
		-- Internal object used for creating new objects.

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
