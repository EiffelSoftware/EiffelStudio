indexing

	description: "License manager for EiffelBench under Windows."
	date: "$Date$"
	revision: "$Revision$"

class BENCH_LICENSE

inherit
	LICENSE
		rename
			product_key as key
		redefine
			verify_current_user
		end

	ENV_INTERP

creation
	make

feature -- Initialization

	make is
			-- Initialization.
		do
			has_been_launched := False
		end

feature -- Validity

	alive: BOOLEAN is True
			-- The license is always alive

	licensed: BOOLEAN
			-- Is the product licensed?

feature -- Registration

	get_license is 
			-- Get the license for EiffelBench.
		local
			shareware_prompt: SHAREWARE_PROMPT
			environment: EXECUTION_ENVIRONMENT
			duration: INTEGER
		do
			!! environment
			username := clone (environment.get ("BENCH_USERNAME"))
			password := clone (environment.get ("BENCH_PASSWORD"))

			verify_current_user

				-- We display the register dialog only when the user did not register yet,
				-- or when the user has an expired copy or when opening EiffelBench without
				-- having a valid license
			if (not licensed or else demo_mode) then
				if not has_been_launched then
						-- We launched EiffelBench once, we do not need anymore
						-- to display this message all the time.
					has_been_launched := True
					duration := Default_waiting_time.max (waiting_time)
				else
					duration := waiting_time
				end

					-- Before asking anything to the user, we restore the default settings.
				licensed := False
				demo_mode := False

					-- Display dialog information
				!! shareware_prompt.make (Current, duration, time_left)
				shareware_prompt.activate
				if licensed then
						-- The user seems to have enter the correct information
						-- We now need to store it in the registry keys
					environment.put (username, "BENCH_USERNAME")
					environment.put (password, "BENCH_PASSWORD")
				elseif demo_mode then
					licensed := True
				end
			end
		end

	release is 
			-- Release the license.
		do 
			licensed := False
		end

feature -- Info

	expiration_date: INTEGER is
			-- Expiration date of the application (used here for the demo version).
		local
			date_name: STRING
			encoder: DES_ENCODER
			environment: EXECUTION_ENVIRONMENT
		do
			!! environment

				-- Create the DES encoder/decoder
			!! encoder.make_with_key (key)

				-- Get the stored expiration date
			date_name := clone (environment.get ("BENCH_TRIAL"))

			if date_name /= Void and then date_name.count > 0 then
				check
					encoder.decrypt (date_name).is_integer
				end
				Result := encoder.decrypt (date_name).to_integer
			else
					-- This is the first time that we launched EiffelBench, so we need
					-- to store the expiration date, which is the current date plus
					-- a month
				from
					date_name := (time + thirty_days).out
				until
					date_name.index_of ('%U', 1) = 0
				loop
					date_name := (time + thirty_days).out
				end
				environment.put (encoder.encrypt (date_name), "BENCH_TRIAL")
			end
			encoder.terminate
		end

	time_left: INTEGER is
			-- Number of days left before license expires
		local
			date_of_expiration: INTEGER
			local_time: INTEGER
		do
			date_of_expiration := expiration_date
			local_time := time
			if local_time > date_of_expiration then
				Result := -1
			else
					-- Get the number of days from a result given in seconds.
				Result := ((date_of_expiration - local_time) // 3600) // 24
			end
		end

feature -- Init

	verify_current_user is
			-- Check current user information.
		local
			encoder: DES_ASCII_ENCODER
		do
			if
				username /= Void and then
				username.count > 5 and then
				password /= Void
			 then
				!! encoder.make_with_key (key)
				licensed := encoder.encrypt (username).is_equal (password)
				encoder.terminate
			end
		end

feature {NONE} -- Not applicable

	daemon_alive: BOOLEAN is True
	is_unlimited: BOOLEAN is True
	license_count: INTEGER is 0
	license_host: STRING is "WINDOWS"
	usage_info: STRING is ""
	valid_expiration_date: BOOLEAN is True

feature {NONE} -- Implementation

	has_been_launched: BOOLEAN
			-- Has the application been launched once?

	key: STRING is
		once
			Result := "%/44/%/55/%/66/%/22/%/11/%/34/%/45/%/56/%/34/%/56/%
					%%/34/%/21/%/76/%/89/%/54/%/63/%/25/%/53/%/32/%/40/%
					%%/45/%/06/%/12/%/25/%/53/%/35/%/59/%/54/%/57/%/03/%
					%%/44/%/88/%/12/%/01/%/90/%/35/%/16/%/54/%/25/%/02/%
					%%/37/%/25/%/16/%/01/%/98/%/55/%/44/%/09/%/37/%/49/%
					%%/11/%/62/%/09/%/46/%/32/%/45/%/15/%/53/%/46/%/90/%
					%%/07/%/05/%/54/%/53/%/61/%/48/%/76/%/03/%/59/%/53/%
					%%/35/%/24/%/53/%/39/%/12/%/02/%/53/%/88/%/40/%/54/%
					%%/39/%/51/%/36/%/02/%/57/%/62/%/39/%/24/%/82/%/56/%
					%%/09/%/01/%/31/%/54/%/20/%/49/%/90/%/29/%/49/%/09/%
					%%/36/%/61/%/88/%/03/%/45/%/34/%/42/%/88/%/31/%/39/%
					%%/50/%/02/%/45/%/17/%/17/%/49/%/63/%/88/%/58/%/53/%
					%%/14/%/25/%/14/%/18/%/13/%/04/%/11/%/57/"
		end

	Default_waiting_time: INTEGER is 15
			-- Number of seconds to wait before using EiffelBench for the first time.

	waiting_time: INTEGER is
			-- Number of seconds to wait before executing a command in the Trial edition.
			-- The value is etween 5 seconds and 30 seconds maximum.
		do
			Result := 5 + (30).min ((0).max ((number_of_days - 10) // 2))
		ensure
			result_in_range: Result >= 5 and Result <= 30
		end

	number_of_days: INTEGER is
			-- Number of days since the first installation
		do
			Result := ((time - installation_date) // 3600) // 24
		end

	installation_date: INTEGER is
			-- Give in seconds the installation date.
		do
			Result := expiration_date - thirty_days
		end

feature {NONE} -- Constants

	thirty_days: INTEGER is 2592030
			-- 30 days + 30 seconds translated in seconds.

feature {NONE} -- Externals

	time: INTEGER is
		do
			c_time ($Result)
		end

	c_time (t: POINTER) is
		external
			"C | <time.h>"
		alias
			"time"
		end

end -- class BENCH_LICENSE
