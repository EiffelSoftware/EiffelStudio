note
	description: "Helper functions for the SCOOP email_client tutorial."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TUTORIAL_HELPER

feature -- Basic operations

	random_wait
			-- Wait for a random amount of time between 100 ms and 1 second.
		do
			wait (random (100, 1000))
		end

	wait (milliseconds: INTEGER_64)
			-- Sleep for `milliseconds' milliseconds.
			-- If the argument is negative, the function will pick a random argument between 100 ms and 1 second.
		require
			positive: milliseconds >= 0
		local
			environment: EXECUTION_ENVIRONMENT
		do
			create environment
			environment.sleep (milliseconds * 1_000_000)
		end

	random (a, b: INTEGER): INTEGER
			-- Generate a pseudo-random number in the interval [a,b].
		require
			valid_interval: a <= b
		do
			if a = b then
				Result := a
			else
				Result := random_generator.item
				random_generator.forth
					-- Make sure the result is in the interval [a,b]
				Result := (Result \\ (b-a)) + a
			end
		end

feature {NONE} -- Implementation

	random_generator: RANDOM
			-- A pseudo-random number generator.
		local
			time: C_DATE
			seed: INTEGER
		attribute
				-- Use the current time in milliseconds as the main seed.
			create time.make_utc
			seed := time.hour_now * 60
			seed := (seed + time.minute_now) * 60
			seed := (seed + time.second_now) * 1000
			seed := seed + time.millisecond_now
				-- Also throw in the type ID, just in case two objects are created at almost the same time.
			seed := seed + (100 * generating_type.type_id)
				-- Create the random number generator.
			create Result.set_seed (seed)
			Result.start
		end

end
