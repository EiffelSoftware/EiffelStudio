class MERGER

inherit
	MEMORY
	SHARED_ERROR_HANDLER
	SHARED_RESCUE_STATUS
	CONSTANTS;
	ERROR_POPUPER
			redefine
				continue_after_error_popdown
			end
	WINDOWS
	COMPILER_EXPORTER

feature -- Result of merging the three files

	merge_result: STRING;

	error: BOOLEAN

feature {NONE}

	init is
		local
			yacc_eiffel: EXT_YACC_EIFFEL
			feature_as: FEATURE_AS;
			invariant_as: INVARIANT_AS;
		once
			!! yacc_eiffel.init

				-- Record dynamic types for instances of FEATURE_AS and
				-- INVARIANT_AS (See routine `make_index' of class
				-- TMP_AST_SERVER).
			!!feature_as;
			set_dtype1 ($feature_as);
			!!invariant_as;
			set_dtype2 ($invariant_as);

			lace_parser_init
			eiffel_parser_init
			
			-- Error handler initialization
			Error_handler.send_yacc_information
			Error_handler.set_error_displayer (error_displayer)		
		end;

	retried: BOOLEAN;

	ignore_optimization: BOOLEAN;
			-- Discard optimization for new and old template
			-- Always perform diff

feature 

	old_temp_ast, user_ast, new_temp_ast: EXT_CLASS_AS

	require_merge: BOOLEAN;
			-- Does Current require a merge based on
			-- the new_template and old_template files

	parse_files (old_template, user, new_template: STRING) is
		require
			valid_args: old_template /= Void and then
						user /= Void and then	
						new_template /= Void
		local
			file: RAW_FILE
		do
			init;
			if not retried then
				require_merge := False
				error := False;
				old_temp_ast := Void;
				user_ast := Void;
				new_temp_ast := Void;

				!! file.make (old_template);
				file.open_read;
				collection_off
				old_temp_ast := c_parse (file.file_pointer, $old_template);
				collection_on;
				file.close;

				!! file.make (new_template);
				file.open_read
				collection_off
				new_temp_ast := c_parse (file.file_pointer, $new_template);
				collection_on
				file.close

				if ignore_optimization or else
					not old_temp_ast.is_equiv (new_temp_ast) 
				then
					require_merge := True;
					!! file.make (user);
					file.open_read
					collection_off
					user_ast := c_parse (file.file_pointer, $user);
					collection_on
					file.close
				end

				debug ("MERGER") 
					if require_merge then
						io.error.putstring ("require merging%N");
					else
						io.error.putstring ("not require merging%N");
					end
				end

			else
				retried := False;
				if Rescue_status.is_error_exception then
					Rescue_status.set_is_error_exception (False);
					Error_handler.trace;
					if command_caller /= Void then
						Error_box.put_string ("Class: ");
						Error_box.put_string 
						(command_caller.current_command.eiffel_type_to_upper);
						Error_box.put_string (" (");
						Error_box.put_string 
						(command_caller.current_command.label);
						Error_box.put_string (")");
					end;
					Error_box.display_error_message (Current);
					Error_handler.wipe_out
				else
					Error_box.popup (Current, Messages.update_text_er,
							user)
				end;
			end
		rescue
			error := True;
			if Rescue_status.is_error_exception then
				collection_on;
				if not (file = Void or else file.is_closed) then
					file.close
				end;
			end;
			retried := True;
			retry
		end;

	merge_files (old_template, user, new_template: STRING) is
		require
			require_merging: require_merge;
			valid_args: old_template /= Void and then
						user /= Void and then	
						new_template /= Void
		local
			class_merger: CLASS_MERGER
			merge_as: CLASS_AS;
			file: RAW_FILE;
			comment_server: EIFFEL_FILE
		do
			if not retried then
				!! file.make (user);
				if file.exists and then 
					file.is_readable and then
					not file.empty
				then
					!! comment_server.make (file.name, file.count);
					user_ast.extract_comments (comment_server)
				end;
	
				!! file.make (old_template);
				if file.exists and then 
					file.is_readable and then
					not file.empty 
				then
					!! comment_server.make (file.name, file.count)
					old_temp_ast.extract_comments (comment_server)
				end;
	
				!! file.make (new_template)
				if file.exists and then 
					file.is_readable and then
					not file.empty
				then
					!! comment_server.make (file.name, file.count)
					new_temp_ast.extract_comments (comment_server)
				end;
	
				!! class_merger
				class_merger.merge3 (old_temp_ast, user_ast, new_temp_ast)
				merge_as := class_merger.merge_result
				merge_result := ast_to_string (merge_as, user)
			else
				retried := False;
				Error_box.popup (Current, Messages.update_text_er,
						user)
			end
		rescue
			error := True;
			retried := True;
			retry
		end;

	ast_to_string (ast: CLASS_AS; file_name: STRING): STRING is
		local
			ctxt: FORMAT_CONTEXT
		do
                       !! ctxt.make (ast, file_name)
			Result := ctxt.text.image
		end;

feature -- Integrate command

	integrate_command (user_file: FILE_NAME; old_templ, new_templ: STRING) is
		require
			valid_arg_1: user_file /= Void;
			valid_arg_2: old_templ /= Void;
			valid_arg_3: new_templ /= Void;
		local
			old_tmpl, user, new_tmpl: STRING;
		do
			to_file (Environment.command_temp_old_file_name, old_templ);
			to_file (Environment.command_temp_new_file_name, new_templ);

			old_tmpl := full_path (Environment.command_temp_old_file_name);
			new_tmpl := full_path (Environment.command_temp_new_file_name);

			ignore_optimization := True;
			parse_files (old_tmpl, user_file, new_tmpl);
			ignore_optimization := false;
			command_caller := Void;
			if not error then
				merge_files (old_tmpl, user_file, new_tmpl)
			end
		end;

	command_caller: COMMAND_EDITOR

	set_command_caller (c: like command_caller) is
		do
			command_caller := c
		end;

	popuper_parent: COMPOSITE is
		do
			if command_caller = Void then
				Result := main_panel.base
			else
				Result := command_caller
			end
		end;

	continue_after_error_popdown is
		do
			command_caller := Void
		end;
	
feature {NONE} -- Implemantation
	
	-- Displayer for errors 
	error_displayer: DEFAULT_ERROR_DISPLAYER is
		once
			!!Result.make (output_window)
		end
	
	output_window: BUILD_OUTPUT_WINDOW is
		once
			!!Result.make (Error_box)
		end
	
	
feature {NONE} -- Integrate Command

	full_path (fn: STRING): FILE_NAME is
		do
			!! Result.make_from_string (Environment.templates_directory);
			Result.set_file_name (fn);
		end;

	from_file (fn: STRING): STRING is
		local
			f: PLAIN_TEXT_FILE
			i: INTEGER
		do
			!! f.make_open_read (fn)
			f.readstream (f.count)
			Result := clone (f.laststring)
		end

	to_file (fn: STRING; s: STRING) is
		local
			f: PLAIN_TEXT_FILE;
		do
			!!f.make_open_write (full_path (fn));
			f.putstring (s);
			f.close
		end;

feature {NONE} -- Externals

	c_parse (f: POINTER; s: POINTER): EXT_CLASS_AS is
		external
			"C"
		end

	eiffel_parser_init is
		external
			"C"
		alias
			"eif_init"
		end;

	set_dtype1 (o: POINTER) is
			-- Record dynamic type of FEATURE_AS
		external
			"C"
		end;

	set_dtype2 (o: POINTER) is
			-- Record dynamic type of INVARIANT_AS
		external
			"C"
		end;

	lace_parser_init is
		external
			"C"
		alias
			"lp_ebuild_init"
		end;


end

