class LACE_PARSER

inherit

	SHARED_ERROR_HANDLER;
	MEMORY;
	SHARED_RESCUE_STATUS

feature

	ast: AST_LACE;
			-- Last AS description

	open_file (file: PLAIN_TEXT_FILE): BOOLEAN is
			-- Open file `file' and catch possible exception
		require
			good_argument: file /= Void
		local
			error_happened: BOOLEAN;
		do
			if not error_happened then
				file.open_read;
				Result := True;
			end;
		rescue
			if Rescue_status.is_unexpected_exception then
				error_happened := True;
				retry;
			end
		end;

	parse_file (file_name: STRING) is
			-- Parse file named `file_name' and make built ast node
			-- (void if failure) available through `ast'.
		local
			file: PLAIN_TEXT_FILE;
			vd21: VD21;
			vd22: VD22;
			ptr: POINTER;
		do
			!!file.make (file_name);
			if not file.is_readable then
				!!vd21;
				vd21.set_file_name (file_name);
				Error_handler.insert_error (vd21);
				Error_handler.raise_error
			else
				if not open_file (file) then
						-- Error when opening file
					!!vd22;
					vd22.set_file_name (file_name);
					Error_handler.insert_error (vd22);
					Error_handler.raise_error
				else
						-- Disable garbage collector before parsing
					collection_off;

					ptr := file.file_pointer;
					ast := lp_file (ptr, $file_name);

						-- Enable garbage collector after parsing
					collection_on;

					file.close;
				end;
			end;
		rescue
			if Rescue_status.is_error_exception then
				collection_on;
					-- Close file in case of syntax error in lace file
				if file /= Void then
					file.close;
				end;
			end;
		end;

feature {NONE} -- Externals

	lp_file (file: POINTER; fn: POINTER): ACE_SD is
			-- Call lace parser with a source file.
		external
			"C"
		end;

end
