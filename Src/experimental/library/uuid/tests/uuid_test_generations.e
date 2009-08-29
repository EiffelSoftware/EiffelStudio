note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	UUID_TEST_GENERATIONS

inherit
	EQA_TEST_SET

feature {NONE} -- Access

	uuid_gen: UUID_GENERATOR
			-- Shared access to a UUID generator
		once
			create Result
		end

feature -- Generation

	uuid_default_is_null
			-- Tests the default generation of a UUID is actual null.
		note
			testing:  "uuid", "generation", "defaults", "covers/{UUID}.is_null"
		do
			assert ("UUID is not null by default", (create {UUID}).is_null)
		end

	uuid_generation_is_not_null
			-- Tests the basic generation of a UUID is not a null UUID.
		note
			testing:  "uuid", "generation", "covers/{UUID_GENERATOR}.generate_uuid", "covers/{UUID}.is_null"
		do
			assert ("UUID is unexpectantly null", not uuid_gen.generate_uuid.is_null)
		end

	uuid_generation_is_unique
			-- Tests the basic generation of a UUID from two objects are unique.
		note
			testing:  "uuid", "generation", "unique", "covers/{UUID_GENERATOR}.generate_uuid"
		local
			l_generator_1: UUID_GENERATOR
			l_generator_2: UUID_GENERATOR
		do
			create l_generator_1
			create l_generator_2
			assert ("UUIDs are not unique", l_generator_1.generate_uuid /~ l_generator_2.generate_uuid)
		end

	uuid_out_is_valid_uuid_string
			-- Test to ensure a UUID string are valid UUIDs.
		note
			testing:  "uuid", "generation", "validity", "covers/{UUID_GENERATOR}.generate_uuid", "covers/{UUID}.out"
		local
			l_uuid: UUID
			l_str: READABLE_STRING_8
		do
			l_uuid := uuid_gen.generate_uuid
			l_str := l_uuid.out
			assert ("Valid UUID", l_uuid.is_valid_uuid (l_str))
			assert ("Valid UUID (lower-case)", l_uuid.is_valid_uuid (l_str.as_lower))
			assert ("Valid UUID (upper-case)", l_uuid.is_valid_uuid (l_str.as_upper))
		end

feature -- Comparison

	uuids_equal
			-- Tests if a twinned UUID is equal.
		note
			testing:  "uuid", "generation", "covers/{UUID_GENERATOR}.generate_uuid", "covers/{UUID}.twin"
		local
			l_uuid: UUID
			l_other_uuid: UUID
		do
			l_uuid := uuid_gen.generate_uuid
			l_other_uuid := l_uuid.twin
			assert ("UUIDs are not equal", l_uuid ~ l_other_uuid)
		end

feature -- Validation

	out_is_valid_uuid
			-- Test to ensure a outted generated UUID is a valid string UUID.
		note
			testing:  "uuid", "generation", "formatting", "validity", "covers/{UUID}.out", "covers/{UUID}.is_valid_uuid"
		do
			assert ("Valid UUID", (create {UUID}).is_valid_uuid (uuid_gen.generate_uuid.out))
		end

feature -- Exception cases

	string_generation_caught
			-- Test to ensure a UUID string are parsed correctly
		note
			testing:  "uuid", "generation", "validity", "covers/{UUID}.is_valid_uuid"
		do
			assert ("An invalid UUID is actual valid", not (create {UUID}).is_valid_uuid (uuid_bad_string))
		end

feature {NONE} -- Constants

	uuid_string: STRING      = "8370D3B3-34E2-4EC4-BEC9-3EA2671FCC86"
	uuid_null_string: STRING = "00000000-0000-0000-0000-000000000000"
	uuid_bad_string: STRING  = "IMNOTAUUID"

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end


