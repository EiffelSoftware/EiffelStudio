indexing

	description: "License manager for EiffelBench under Windows."
	date: "$Date$"
	revision: "$Revision $"

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
		do
			!! environment
			username := clone (environment.get ("BENCH_USERNAME"))
			password := clone (environment.get ("BENCH_PASSWORD"))

			verify_current_user

			if not licensed then
					-- Display dialog information
				!! shareware_prompt.make (Current)
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

	release is 
			-- Release the license.
		do 
			licensed := False
		end

feature {NONE} -- Implementation

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

feature {NONE} -- Not applicable

	daemon_alive: BOOLEAN is True
	expiration_date: INTEGER is 0
	is_unlimited: BOOLEAN is True
	license_count: INTEGER is 0
	license_host: STRING is "WINDOWS"
	time_left: INTEGER is 0
	usage_info: STRING is ""
	valid_expiration_date: BOOLEAN is True

end -- class BENCH_LICENSE
