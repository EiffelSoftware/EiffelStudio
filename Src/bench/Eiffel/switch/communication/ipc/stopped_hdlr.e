class STOPPED_HDLR

inherit

	RQST_HANDLER;
	SHARED_DEBUG;
	OBJECT_ADDR;
	SHARED_CONFIGURE_RESOURCES

creation
	
	make

feature

	make is
			-- Create Current and pass addresses to C
		do
			request_type := Rep_stopped;
			pass_addresses
		end;

	execute is
			-- Register that the application is stopped
			-- and parse the string passed from C.
			-- The format of the passed string is:
			--    feature name
			--    object address
			--    origin of feature
			--    type of object
			--    offset in byte code
			--    reason for stopping
			--    exception code (undefined if irrelevant)
			--    assertion tag (undefined if irrelevant)
		local
			name: STRING;
			org_type: INTEGER;
			dyn_type: INTEGER;
			offset: INTEGER;
			address: STRING;
			reason: INTEGER;
			status: APPLICATION_STATUS;	
			e_cmd: E_CMD
			retry_clause: BOOLEAN
			
		do
			if not retry_clause then
				e_cmd := Application.before_stopped_command;
				if e_cmd /= Void then
					e_cmd.execute
				end;

				debug ("DEBUGGER_TRACE")
					io.error.putstring ("STOPPED_HDLR: Application is stopped - reading information from application%N")
				end
					-- Physical address of objects held in object tools
					-- may have been change...
				update_addresses;
	
				position := 1;

					-- Read feature name.
				read_string;
				name := last_string;

					-- Read object address and convert it to hector address.
				read_string;

				address := hector_addr (last_string);
	
					-- Read origin of feature
				read_int;
				org_type := last_int + 1;

					-- Read type of current object.
					--| Note: the type id on the C side must be 
					--| incremented by one.
				read_int;
				dyn_type := last_int + 1;

					-- Read offset in byte code.
				read_int;
				offset := last_int;

					-- Read reason for stopping.
				read_int;
				reason := last_int;

					-- Read exception code.
				read_int;

					-- Read assertion tag.
				read_string;

				debug ("DEBUGGER_TRACE")
					io.error.putstring ("STOPPED_HDLR: Application is stopped - finished reading%N")
					io.error.putstring ("              Setting app status for routine: ")
					io.error.putstring (name)
					io.error.new_line
				end
				status := Application.status;
				check
					application_launched: status /= Void
				end
				status.set_is_stopped (true)
				status.set (name, address, org_type, dyn_type, offset, reason)
				status.set_exception (last_int, last_string)

				debug ("DEBUGGER_TRACE")
					io.error.putstring ("STOPPED_HDLR: Finished setting status (Now calling after cmd)%N")
				end

				if reason /= Pg_new_breakpoint then
					e_cmd := Application.after_stopped_command
					if e_cmd /= Void then
						e_cmd.execute
					end
				
					debug ("DEBUGGER_TRACE")
						io.error.putstring ("STOPPED_HDLR: Finished calling after_cmd%N")
					end
				else
						-- If the reason is Pg_new_breakpoint, the application sends the
						-- new breakpoints and then automatically resume its execution.
					debug ("DEBUGGER_TRACE")
						io.error.putstring ("STOPPED_HDLR: New breakpoint added, do nothing%N")
					end
				end
			else -- retry_clause
				if Application.is_running then
					Application.process_termination;
				end
			end
--		rescue
-- FIXME ARNAUD
-- toTo: write a beautiful message box instead of this crappy message
--			io.putstring("Error while getting Application status. Application will be terminated%N")
-- END FIXME
--			retry_clause := True
--			retry
		end

feature {} -- parsing features

	position: INTEGER;
			-- Position in parsed string

	last_string: STRING;
			-- Last parsed string token

	last_int: INTEGER;
			-- Last parsed integer token

	read_string is
			-- Parse string token.
		require
			-- position < detail.count and
			-- detail.substring (position, count).has ('%U')	
		local
			i: INTEGER;
		do
			i := index_of ('%U', position);
			if i = 0 then i := detail.count + 1 end;
			if i <= position then
				last_string := ""
			else
				last_string := detail.substring (position, i - 1);
			end;
			position := i + 1;
		end;

	index_of (c: CHARACTER; pos: INTEGER): INTEGER is
			-- position of first occurence of c
			-- after pos (included). 0 if none
			--| should be in string
		local
			i: INTEGER	
		do
			from
				i := pos
			until
				i > detail.count or Result > 0
			loop
				if detail.item (i) = c then
					Result := i
				else
					i := i + 1
				end
			end
		end;

	read_int is
			-- Parse integer token.
		do
			read_string;
			last_int := last_string.to_integer;
		end;

end
