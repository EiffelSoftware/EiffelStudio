note
	description: "Test if objects are created on the correct region upon impersonation."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	ISE_SCOOP_RUNTIME

create
	make, default_create

feature

	make
			-- Entry point for the test.
		local
			same: TEST
			other: separate TEST
			generated: separate TEST
		do
				-- Check the basic stuff without impersonation.
			create same
			check_same (Current, same)

			create other
			check_different (Current, other)

			separate other as l_other do
				generated := l_other.new_test
				check_same (l_other, generated)
				check_different (Current, generated)

					-- This is the first impersonated call.
				generated := l_other.new_test
				check_same (l_other, generated)
				check_different (Current, generated)
			end

				-- Same test with a passive processor.
			create <NONE> other
			check_different (Current, other)
			separate other as l_other do
				generated := l_other.new_test
				check_same (l_other, generated)
				check_different (Current, generated)

				generated := l_other.new_test
				check_same (l_other, generated)
				check_different (Current, generated)
			end
		end

	new_test: TEST
		do
			create Result
		end

	check_same (a,b: separate ANY)
		do
			if region_id (a) /= region_id (b) then
				print ("ERROR: Region ID does not match.%N")
			end
		end

	check_different (a,b: separate ANY)
		do
			if region_id (a) = region_id (b) then
				print ("ERROR: Region ID is the same.%N")
			end
		end

end
