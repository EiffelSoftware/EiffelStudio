
class ISE_LICENCE

inherit

	LIMAN_R;

creation

	make

feature {NONE}

	licence_host: STRING;		-- name of host where daemon is running
	
	application_name: STRING;	

	version: INTEGER;

	licence_file: STRING;		--file which tells the application where the license deamon is.

feature 

	make (file_name: STRING) is
		require
			valid_file_name: file_name /= Void and then not file_name.empty;
		do
			licence_file := clone (file_name);
			licence_file.append ("/install/limand");
		end;

	get_registration_info is
			--get the host name where the daemon is running
			--file can also contain application name, version and
			--overide number.  if more than one eiffel product then
			--application name and version need to be set from the
			--application
		local
			info_file: UNIX_FILE;
			filename: STRING;
			over_ride_time: INTEGER;
		do
			!!filename.make (0);
			filename.append (licence_file);
			filename.append ("/dhost");
			!!info_file.make (filename);
			if info_file.exists and then info_file.is_readable then
				info_file.open_read;
				info_file.readline;
				licence_host := clone (info_file.laststring);
				info_file.readline;
				if not info_file.end_of_file then
					info_file.readline;
					if not info_file.end_of_file then
						info_file.readline;
						if not info_file.end_of_file then
							info_file.readline;
							if not info_file.end_of_file then
								over_ride_time := clone (info_file.laststring).to_integer;
							end;
						end; 
					end;
				end;
			else
				io.putstring ("License host file: ");
				io.putstring (filename);
				io.putstring (" does not exist or is not readable.%N");
			end;
            if over_ride_time = Void then
                override := false;
            elseif 
                (over_ride_time = time_out) or else
                (over_ride_time = time_out2) or else
                (over_ride_time = time_out3) or else
                (over_ride_time = time_out4) or else
                (over_ride_time = time_out5) or else
                (over_ride_time = time_out6)
            then
                override := (over_ride_time > current_time)
            else
                override := False;
            end;

		end;

	time_out: INTEGER is 757411607;	--override key in seconds. this is a hard coded time
					--after which the licence will not be overriden
					-- 1/1/94

    time_out2: INTEGER is 762514412;
            -- 3/1/94 

    time_out3: INTEGER is 770492011;
            -- 6/1/94

    time_out4: INTEGER is 778444409
            -- 9/1/94

    time_out5: INTEGER is 788985217;
            -- 1/1/95 

    time_out6: INTEGER is 798999999;
            

	current_time: INTEGER is
			--get the current time from the machine
		do
			Result := l_time;
		end;

	set_version (v: INTEGER) is
		do
			version := v;
		end;

	set_application_name (a: STRING) is
		do
			application_name := clone (a);
		end;

	override: BOOLEAN;	--flag to say whether to override the licence manager or not

	licenced: BOOLEAN;	--flag to say whether the application has acquired a licence or not

	registered: BOOLEAN;	--flag to check whether the application has registered itself with the
				--licence daemon

	is_valid: BOOLEAN;	--flag to say whether the licemce is still valid, ie the aplication
				--is still registered, licenced and can still communicat with the
				--licence daemon

	setup_correct: BOOLEAN is
			--this checks that all the relevant information has been provide from either
			--a file or from the application
		do
			Result := (licence_host /= Void and then not licence_host.empty) and
				version /= 0 and
				(application_name /= Void and then not application_name.empty);
		end;
		
	is_alive: BOOLEAN;	--the licence is still alive
	
	daemon_alive: BOOLEAN;	--the daemon is still alive

	register is
			--register an application with the licence daemon
		local
			chost, capplication: ANY;
			answer: INTEGER;
		do
			if not setup_correct then
				get_registration_info;
			end;
			if override then
				registered := True;
				daemon_alive := True;
			elseif setup_correct then
				chost := licence_host.to_c;
				capplication := application_name.to_c;
				answer := liminit ($capplication, version, $chost);
				if answer = -1 then
					handle_error ("Unable to Register");
					registered := false;
					daemon_alive := False;
				else
					registered := True;
					daemon_alive := True;
				end;
			else
				registered := False;
			end;
		end;

	unregister is
			--unregister the application with the licence daemon
		local
			i: INTEGER
		do
			if not override then
				limbye;
				registered := False;
				licenced := False;
			end;
		end;

	open_licence is
			--get a licence to run the application
		local
			answer: INTEGER;
		do
			
			if override then
				licenced := True;
				is_valid := True;
			elseif daemon_alive and registered then
				answer := limget(l_feature,0,0,0);
				if answer = -1 then
					handle_error ("Unable to get Full license for");
					licenced := False;
					is_valid := False;
				else
					is_valid := True;
					licenced := True;
				end;
			else
				licenced := False;
				is_valid := False;
			end;
		end;

			
	alive is
			--check that daemon is still alive and we still have a licence
		local
			answer: INTEGER;
		do
			if override then
				is_alive := True;
			elseif registered and licenced then
				answer := limalive;
				if answer = -1 then
					is_alive := false;
					daemon_alive := True;
					unregister;
				elseif answer = 1 then
					is_alive := False;
					daemon_alive := False;
				else
					is_alive := True;
					daemon_alive := True;
				end;
			else
				is_alive := false;
			end;
		end;
			
	free_licence is
			--release licence
		local 
			answer: INTEGER;
		do
			if override then
				licenced := True;
			else
				answer := limfree (l_feature, 0, 0);
				licenced := False;
			end;
		end;	

	handle_error (s: STRING) is
		local
			error_str: STRING;
		do
			io.putstring (s);
			io.putstring (" application ");
			io.putstring (application_name);
			io.putstring ("%N Version: ");
			io.putint (version);
			io.putstring ("%Nwith license host ");
			io.putstring (licence_host);
			io.putstring ("%NError: ");
			!!error_str.make(0);
			error_str.from_c (l_strerror);
			io.putstring(error_str);
			io.new_line;
		end;
			
feature {NONE}
	
	error_number: INTEGER is
		external
			"C"
		end;

	liminit (name: ANY; vers: INTEGER; host: ANY): INTEGER is
		external
			"C"
		end;

	limget (flag: INTEGER; feat: INTEGER; amount: INTEGER; hold: INTEGER): INTEGER is
		external
			"C"
		end;

	limalive: INTEGER is
		external
			"C"
		end;

	limfree (flag, feat, amount: INTEGER): INTEGER is
		external
			"C"
		end;


	limbye is
		external
			"C"
		end;

	l_strname: ANY is
		external
			"C"
		end;

	l_strerror: ANY is
		external
			"C"
		end;
	
	l_feature: INTEGER is
		external
			"C"
		end;

	l_hold: INTEGER is
		external
			"C"
		end;

	l_meter: INTEGER is
		external
			"C"
		end;

	l_full: INTEGER is
		external
			"C"
		end;

	l_time: INTEGER is
		external
			"C"
		end;

end

