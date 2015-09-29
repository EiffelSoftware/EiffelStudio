note
	description: "Test if a processor adapts the correct region during a separate callback."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	ISE_SCOOP_RUNTIME

create
	make, set_next

feature

	next: detachable separate TEST

	set_next (a_test: like next)
		do
			next := a_test
		end

	make
			-- Entry point for the test.
		local
			l_next, l_next_next: separate TEST
		do
			create l_next_next.set_next (Current)
			create l_next.set_next (l_next_next)
			next := l_next

				-- Let Current impersonate next, then do a regular separate call to next_next,
				-- then do a callback to Current (while it's impersonating next).

			pin_to_thread
			pin_processor_to_thread (l_next_next)
			recursive_call (3).do_nothing
		end

	recursive_call (stop_after: INTEGER): BOOLEAN
			-- Walk around the reference circle until 'stop_after' is 0
		local
			sync: POINTER
			test_region: ANY
		do
			check attached next as l_next then
				if stop_after /= 0 then
					separate l_next as s_next do
							-- Synchronize first to make sure the second call is impersonated.
						sync := s_next.default_pointer
						Result := s_next.recursive_call (stop_after-1)
					end
				end
				create test_region
				check_same (Current, test_region)
				check_different (Current, l_next)
			end
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
