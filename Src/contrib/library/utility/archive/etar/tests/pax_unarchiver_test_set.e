note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	PAX_UNARCHIVER_TEST_SET

inherit
	TAR_TEST_SET_BASE

feature -- Test routines

	test_pax_unarchiver_easy
			--Test pax unarchiver with testset easy
		local
			unit_under_test: PAX_UNARCHIVER
			p: MANAGED_POINTER
		do
			create unit_under_test
			create p.make_from_pointer (easy_payload_blob.base_address, easy_payload_blob.count)

			unit_under_test.initialize (easy_header)
			assert ("Not finished after setting header", not unit_under_test.unarchiving_finished)

			unit_under_test.unarchive_block (p, 0)

			assert ("Finished after single block", unit_under_test.unarchiving_finished)
			assert ("No errors", not unit_under_test.has_error)
			assert ("path parsed", unit_under_test.value ("path") /= Void)
			assert ("correct path", unit_under_test.value ("path") ~ "/dev/sda1")
			assert ("mtime parsed", unit_under_test.value ("mtime") /= Void)
			assert ("correct mtime", unit_under_test.value ("mtime") ~ "1451293316.085474313")
		end

	test_pax_unarchiver_error
			-- Test pax unarchiver with testset containing errors
		local
			unit_under_test: PAX_UNARCHIVER
			p: MANAGED_POINTER
		do
			create unit_under_test
			create p.make_from_pointer (error_too_long_payload_blob.base_address, error_too_long_payload_blob.count)

			unit_under_test.initialize (error_too_long_header)
			assert ("Not finished after setting header", not unit_under_test.unarchiving_finished)

			unit_under_test.unarchive_block (p, 0)

			assert ("Finished", unit_under_test.unarchiving_finished)
			assert ("Has error", unit_under_test.has_error)

			unit_under_test.reset_error
			unit_under_test.initialize (error_non_num_header)
			assert ("Not finished after setting header", not unit_under_test.unarchiving_finished)

			create p.make_from_pointer (error_non_num_payload_blob.base_address, error_non_num_payload_blob.count)
			unit_under_test.unarchive_block (p, 0)

			assert ("Finished", unit_under_test.unarchiving_finished)
			assert ("Has error", unit_under_test.has_error)

		end


feature {NONE} -- Data - pax header template

	pax_header: TAR_HEADER
			-- Return a template for a pax_header (without size)
		do
			create Result
			Result.set_filename (create {PATH}.make_from_string ({TAR_CONST}.pax_header_filename))
			Result.set_mode ({TAR_CONST}.pax_header_mode)
			Result.set_user_id ({TAR_CONST}.pax_header_uid)
			Result.set_group_id ({TAR_CONST}.pax_header_gid)
			Result.set_typeflag ({TAR_CONST}.tar_typeflag_pax_extended)
		end

feature {NONE} -- Data - easy

	easy_payload_string: STRING_8 =
	"[
18 path=/dev/sda1
30 mtime=1451293316.085474313

	]"
			-- Payload string for easy testset
	easy_payload_blob: SPECIAL [CHARACTER_8]
			-- Payload blob for easy testset
		once
			create Result.make_filled ('%U', needed_blocks (easy_payload_string.count) * {TAR_CONST}.tar_block_size)
			Result.copy_data (easy_payload_string.area, 0, 0, easy_payload_string.count)
		end

	easy_header: TAR_HEADER
			-- Return header for easy testset
		once
			Result := pax_header
			Result.set_size (easy_payload_string.count.as_natural_64)
		end

feature {NONE} -- Data - error (too long)

	error_too_long_payload_string: STRING_8 =
	"[
17 path=/dev/sda131 mtime=1451293316.085474313

	]"
			-- Payload string for error testset

	error_too_long_payload_blob: SPECIAL [CHARACTER_8]
			-- Payload blob for error testset
		once
			create Result.make_filled ('%U', needed_blocks (error_too_long_payload_string.count) * {TAR_CONST}.tar_block_size)
			Result.copy_data (error_too_long_payload_string.area, 0, 0, error_too_long_payload_string.count)
		end

	error_too_long_header: TAR_HEADER
			-- Return header for error testset
		once
			Result := pax_header
			Result.set_size (error_too_long_payload_string.count.as_natural_64)
		end

feature {NONE} -- Data - error (non-numeric length)

	error_non_num_payload_string: STRING_8 =
	"[
ab path=/dev/sda131 mtime=1451293316.085474313

	]"
			-- Payload string for error testset

	error_non_num_payload_blob: SPECIAL [CHARACTER_8]
			-- Payload blob for error testset
		once
			create Result.make_filled ('%U', needed_blocks (error_non_num_payload_string.count) * {TAR_CONST}.tar_block_size)
			Result.copy_data (error_non_num_payload_string.area, 0, 0, error_non_num_payload_string.count)
		end

	error_non_num_header: TAR_HEADER
			-- Return header for error testset
		once
			Result := pax_header
			Result.set_size (error_non_num_payload_string.count.as_natural_64)
		end
end


