indexing

	description: "License manager for $EiffelGraphicalCompiler$ under Windows."
	date: "$Date$"
	revision: "$Revision$"

class BENCH_LICENSE

inherit
	LICENSE
		rename
			product_key as key,
			non_commercial_product_key as non_commercial_key
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
			-- Get the license for $EiffelGraphicalCompiler$.
		local
			shareware_prompt: SHAREWARE_PROMPT
			environment: EXECUTION_ENVIRONMENT
			duration: INTEGER
		do
			create environment
			username := clone (environment.get ("BENCH_USERNAME"))
			password := clone (environment.get ("BENCH_PASSWORD"))

			verify_current_user

				-- We display the register dialog only when the user did not register yet,
				-- or when the user has an expired copy or when opening
				-- $EiffelGraphicalCompiler$ without having a valid license
			if (not licensed or else demo_mode) then
				if not Is_beta then
					if not has_been_launched then
							-- We launched $EiffelGraphicalCompiler$ once, we do not need anymore
							-- to display this message all the time.
						has_been_launched := True
						duration := Default_waiting_time.max (waiting_time)
					else
						duration := waiting_time
					end
				end

					-- Before asking anything to the user, we restore the default settings.
				licensed := False
				demo_mode := False

					-- Display dialog information
				if not Is_beta or else (time_left = -1) then
					create shareware_prompt.make (Current, Is_beta, duration, time_left, Max_days)
					shareware_prompt.activate
				else
					if username = Void or else password = Void then
						username := "Beta user"
						password := "Beta user"
					end
					licensed := True
				end
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
			create environment

				-- Create the DES encoder/decoder
			create encoder.make_with_key (key)

				-- Get the stored expiration date
			date_name := clone (environment.get ("BENCH_TRIAL_50"))

			if date_name /= Void and then date_name.count > 0 then
				check
					encoder.decrypt (date_name).is_integer
				end
				Result := encoder.decrypt (date_name).to_integer
			else
					-- This is the first time that we launched $EiffelGraphicalCompiler$,
					-- so we need to store the expiration date, which is the current date
					-- plus a month. Here we have a protection against null character in
					-- registry keys.
				from
					Result := time + Max_days_in_seconds
					date_name := encoder.encrypt (Result.out)
				until
					date_name.index_of ('%U', 1) = 0
				loop
					Result := time + Max_days_in_seconds
					date_name := encoder.encrypt (Result.out)
				end
				environment.put (date_name, "BENCH_TRIAL_50")
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
			if local_time > date_of_expiration or (Is_beta and then local_time > Beta_limit) then
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
			licensed := False
			non_commercial_mode := False
			if
				username /= Void and then
				username.count > 5 and then
				password /= Void
			 then
				create encoder.make_with_key (key)
				licensed := encoder.encrypt (username).is_equal (password)
				encoder.terminate
				if not licensed then
					create encoder.make_with_key (non_commercial_key)
					licensed := encoder.encrypt (username).is_equal (password)
					encoder.terminate
					non_commercial_mode := True
				end
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
			Result := "%/43/%/55/%/66/%/22/%/11/%/34/%/45/%/52/%/34/%/56/%
					%%/34/%/21/%/76/%/89/%/54/%/63/%/25/%/53/%/32/%/40/%
					%%/45/%/26/%/12/%/25/%/53/%/35/%/59/%/54/%/57/%/03/%
					%%/44/%/88/%/12/%/01/%/90/%/35/%/16/%/54/%/25/%/02/%
					%%/37/%/55/%/16/%/01/%/98/%/55/%/44/%/09/%/37/%/49/%
					%%/11/%/62/%/09/%/46/%/32/%/45/%/15/%/53/%/46/%/90/%
					%%/07/%/65/%/54/%/53/%/65/%/48/%/79/%/03/%/59/%/53/%
					%%/35/%/24/%/53/%/39/%/12/%/02/%/55/%/88/%/40/%/54/%
					%%/39/%/71/%/36/%/02/%/57/%/62/%/39/%/24/%/82/%/56/%
					%%/09/%/01/%/31/%/54/%/20/%/49/%/90/%/29/%/49/%/09/%
					%%/36/%/61/%/88/%/03/%/45/%/34/%/48/%/82/%/31/%/39/%
					%%/50/%/02/%/35/%/17/%/17/%/49/%/63/%/81/%/58/%/53/%
					%%/14/%/25/%/14/%/18/%/23/%/04/%/11/%/57/"
		end
		
	non_commercial_key: STRING is
			-- Key that unlocks EiffelStudio but still generates a runtime popup
		once
			Result := "%/42/%/15/%/26/%/32/%/41/%/54/%/65/%/52/%/34/%/56/%
					%%/24/%/91/%/36/%/29/%/34/%/53/%/85/%/53/%/12/%/40/%
					%%/25/%/26/%/12/%/25/%/53/%/35/%/59/%/54/%/17/%/03/%
					%%/34/%/28/%/12/%/01/%/90/%/35/%/16/%/54/%/15/%/02/%
					%%/37/%/55/%/16/%/01/%/98/%/55/%/44/%/09/%/17/%/49/%
					%%/31/%/62/%/09/%/46/%/32/%/45/%/15/%/53/%/16/%/90/%
					%%/97/%/65/%/24/%/53/%/65/%/48/%/79/%/03/%/59/%/53/%
					%%/35/%/24/%/53/%/39/%/12/%/02/%/55/%/88/%/40/%/54/%
					%%/39/%/71/%/36/%/02/%/17/%/62/%/99/%/24/%/82/%/56/%
					%%/09/%/01/%/31/%/54/%/20/%/49/%/90/%/29/%/49/%/09/%
					%%/36/%/61/%/88/%/03/%/45/%/34/%/38/%/82/%/31/%/39/%
					%%/50/%/02/%/35/%/17/%/17/%/49/%/63/%/81/%/58/%/53/%
					%%/14/%/25/%/14/%/18/%/23/%/04/%/15/%/17/"
		end

	waiting_time: INTEGER is
			-- Number of seconds to wait before executing a command in the Trial edition.
		do
			Result := ((25 / Max_days) * number_of_days + 5).rounded
		end

	number_of_days: INTEGER is
			-- Number of days since the first installation
		do
			Result := ((time - installation_date) // 3600) // 24
		end

	installation_date: INTEGER is
			-- Give in seconds the installation date.
		do
			Result := expiration_date - Max_days_in_seconds
		end

feature {NONE} -- Constants

	Max_days_in_seconds: INTEGER is
			-- Max days + Max_waiting_time seconds translated in seconds.
		once
			Result := Max_days * 3600 * 24 + Max_waiting_time
		end

	Beta_limit: INTEGER is 1000012454
			-- Hard coded time which corresponds to a time in September 2001.

	Max_days: INTEGER is 60
			-- Numbers of days of evaluation
		
	Min_waiting_time: INTEGER is 5
	Max_waiting_time: INTEGER is 30
			-- Time to wait before being able to use environment.

	Default_waiting_time: INTEGER is 15
			-- Number of seconds to wait before using $EiffelGraphicalCompiler$ for the first time.

	Is_beta: BOOLEAN is False
			-- Is it a beta evaluation?

feature {NONE} -- Externals

	time: INTEGER is
		do
			Result := c_time ($Result)
		ensure
			valid_result: Result /= -1
		end

	c_time (t: POINTER): INTEGER is
		external
			"C signature (time_t *): EIF_INTEGER use <time.h>"
		alias
			"time"
		end

end -- class BENCH_LICENSE
