class SHARED_STATUS

feature

	server_mode: BOOLEAN is
			-- Is the compiler in server mode?
		do
			Result := server_cell.item
		end;

	enable_server_mode is
			-- Set `server_mode' to True.
		do
			server_cell.put (True)
		ensure
			server_mode: server_mode
		end;

feature {NONE} -- Implementation

	server_cell: CELL [BOOLEAN] is
		once
			!! Result.put (False)
		end;

end -- class SHARED_STATUS
