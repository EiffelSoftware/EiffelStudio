indexing

	description: "License manager for EiffelBench under Windows."
	date: "$Date$"
	revision: "$Revision$"

class BENCH_LICENSE

inherit
	LICENSE
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
--			version := 4.3
--			application_name := "EiffelBench"
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
				!! shareware_prompt.make (Current, duration)
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
				date_name := clone ((time + thirty_days).out)
				environment.put (encoder.encrypt (date_name), "BENCH_TRIAL")
			end
		end

	time_left: INTEGER is
			-- Number of days left before license expires
		local
			date_of_expiration: INTEGER
		do
			date_of_expiration := expiration_date
			if time > date_of_expiration then
				Result := -1
			else
					-- Get the number of days from a result given in seconds.
				Result := ((date_of_expiration - time) // 3600) // 24
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
			Result := "%/28/%/05/%/37/%/16/%/01/%/03/%/07/%/39/%/63/%/25/%
					%%/37/%/34/%/23/%/19/%/54/%/63/%/21/%/53/%/32/%/40/%
					%%/30/%/06/%/12/%/21/%/53/%/35/%/59/%/19/%/57/%/03/%
					%%/44/%/10/%/12/%/01/%/25/%/35/%/16/%/19/%/21/%/02/%
					%%/37/%/21/%/16/%/01/%/98/%/55/%/44/%/09/%/37/%/49/%
					%%/11/%/62/%/09/%/46/%/32/%/45/%/15/%/53/%/46/%/25/%
					%%/07/%/05/%/54/%/38/%/61/%/48/%/76/%/03/%/59/%/38/%
					%%/35/%/24/%/38/%/39/%/12/%/02/%/53/%/10/%/40/%/19/%
					%%/39/%/51/%/36/%/02/%/57/%/62/%/39/%/24/%/82/%/56/%
					%%/09/%/01/%/31/%/19/%/20/%/49/%/25/%/29/%/49/%/09/%
					%%/36/%/61/%/10/%/03/%/45/%/34/%/42/%/10/%/31/%/39/%
					%%/50/%/02/%/30/%/17/%/17/%/49/%/63/%/10/%/58/%/38/%
					%%/14/%/21/%/14/%/18/%/13/%/04/%/11/%/57/"
		end

	Default_waiting_time: INTEGER is 10
			-- Number of seconds to wait before using EiffelBench for the first time.

	waiting_time: INTEGER is
			-- Number of seconds to wait before executing a command in the Trial edition.
			-- The value is etween 5 seconds and 30 seconds maximum.
		local
			number_of_days: INTEGER
		do
			number_of_days := ((time - installation_date) // 3600) // 24
			Result := 5 + (30).min ((0).max ((number_of_days - 10) // 2))
		ensure
			result_in_range: Result >= 5 and Result <= 30
		end

	installation_date: INTEGER is
			-- Give in seconds the installation date.
		do
			Result := expiration_date - thirty_days
		end

feature {NONE} -- Constants

	thirty_days: INTEGER is 2678400
			-- 31 days translated in seconds.

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
