deferred class LACE_PARSER_ROUTINES

inherit

	SHARED_ERROR_HANDLER;
	SHARED_RESCUE_STATUS;
	SHARED_WORKBENCH;
	COMPILER_EXPORTER

feature

	ast: AST_LACE;
			-- Last AS description

	is_in_use_file: BOOLEAN
			-- Are we parsing `use' specification of Lace or Lace itself?

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
			file, copy_file: RAW_FILE
			f_name: FILE_NAME
			f_count: INTEGER
			vd21: VD21
			vd22: VD22
		do
			create file.make (file_name)
			if not file.is_readable then
				create vd21
				vd21.set_file_name (file_name)
				Error_handler.insert_error (vd21)
				Error_handler.raise_error
			else
				if not open_file (file) then
						-- Error when opening file
					create vd22
					vd22.set_file_name (file_name)
					Error_handler.insert_error (vd22)
					Error_handler.raise_error
				else
						-- Save the source in a Backup directory
					if Workbench.automatic_backup then
						create f_name.make_from_string (Workbench.backup_subdirectory);
						f_name.set_file_name ("Ace.ace")
						create copy_file.make (f_name)
						if copy_file.is_creatable then
							copy_file.open_write
							f_count := file.count
							if f_count > 0 then
								file.readstream (f_count)
								file.start
								copy_file.putstring (file.laststring)
							end
							copy_file.close
						end
					end

					parse_lace (file)

					file.close
				end
			end
		rescue
			if Rescue_status.is_error_exception then
					-- Close file in case of syntax error in lace file
				if file /= Void then
					file.close
				end
			end
		end;

	parse_file (file_name: STRING; in_use_file: BOOLEAN) is
			-- Parse file named `file_name' and make built ast node
			-- (void if failure) available through `ast'.
		local
			retried: BOOLEAN
			syntax_error: SYNTAX_ERROR
		do
			is_in_use_file := in_use_file
			if not retried then
				set_last_syntax_error (Void);
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

	parse_lace (a_file: FILE) is
			-- Call lace parser with a source file.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		deferred
		end

end
