class SHARED_STATUS

feature -- Access

	server_mode: BOOLEAN is
			-- Is the compiler in server mode?
		do
			Result := server_mode_ref.item
		end

	enable_server_mode is
			-- Set `server_mode' to True.
		do
			server_mode_ref.set_item (True)
		ensure
			server_mode: server_mode
		end;

feature {NONE} -- Implementation

	server_mode_ref: BOOLEAN_REF is
		once
			create Result
		end

end -- class SHARED_STATUS
