class LACE_PARSER

inherit

	SHARED_ERROR_HANDLER;
	MEMORY;
	SHARED_RESCUE_STATUS;
	SHARED_WORKBENCH;
	COMPILER_EXPORTER

feature

	ast: AST_LACE;
			-- Last AS description

	open_file (file: RAW_FILE): BOOLEAN is
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

	build_ast (file_name: STRING) is
			-- Parse file named `file_name' and make built ast node
			-- (void if failure) available through `ast'.
		local
			file, copy_file: RAW_FILE;
			f_name: FILE_NAME;
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
						-- Save the source in a Backup directory
					if Workbench.automatic_backup then
						!! f_name.make_from_string (Workbench.backup_subdirectory);
						f_name.set_file_name ("Ace");
						!! copy_file.make_open_write (f_name);
						file.readstream (file.count);
						file.start;
						copy_file.putstring (file.laststring);
						copy_file.close;
					end

					ptr := file.file_pointer;

						-- Disable garbage collector before parsing
						-- Enable garbage collector after parsing
					collection_off;
					ast := lp_file (ptr, $file_name);
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

	parse_file (file_name: STRING) is
			-- Parse file named `file_name' and make built ast node
			-- (void if failure) available through `ast'.
		local
			retried: BOOLEAN
			syntax_error: SYNTAX_ERROR
		do
			if not retried then
				build_ast (file_name)
			else
				syntax_error ?= Error_handler.error_list.first;
				check
					syntax_error_not_void: syntax_error /= Void
				end;
				set_last_syntax_error (syntax_error);
				retried := False
			end
		rescue
			if Rescue_status.is_error_exception then
				Rescue_status.set_is_error_exception (False);
				retried := True;
				retry
			end
		end	

feature -- Shared once

	last_syntax_error: SYNTAX_ERROR is
			-- Last syntax error generated after calling
			-- routine `parse_ast'
		do
			Result := last_syntax_cell.item
		end;

	set_last_syntax_error (s: SYNTAX_ERROR) is
			-- Put the last syntax error in last_syntax_error
		do
			last_syntax_cell.put (s)
		end

feature -- Removal

	clear_syntax_error is
			-- Clear the syntax error information.
		do
			Error_handler.error_list.wipe_out;
			last_syntax_cell.put (Void)
		end;

feature {NONE} -- Implementation

	last_syntax_cell: CELL [SYNTAX_ERROR] is
			-- Stored value of last generated syntax error generated calling
			-- routine `parse_ast'
		once
			!! Result.put (Void)
		end;

feature {NONE} -- Externals

	lp_file (file: POINTER; fn: POINTER): ACE_SD is
			-- Call lace parser with a source file.
		external
			"C"
		end;

end
