class SHARED_CODE_FILES

inherit

	PROJECT_CONTEXT
	
feature {NONE}

	size_file (final_mode: BOOLEAN): UNIX_FILE is
			-- File where the type sizes are generated
			--! This is not a once function since
			--! we want different postfix for the
			--! file name
		local
			file_name: STRING;
		do
			!!file_name.make (generation_path.count + 8);
			file_name.append (generation_path);
			file_name.append ("/Esize.");
			if final_mode then
				file_name.append ("x")
			else
				file_name.append ("c")
			end;
			!!Result.make (file_name);
		end;

	History_file: UNIX_FILE is
			-- File containing history tables
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 10);
			file_name.append (generation_path);
			file_name.append ("/Ehisto.c");
			!!Result.make (file_name);
		end;

	Reference_file: UNIX_FILE is
			-- File where the table of number of redeferences is generated
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 7);
			file_name.append (generation_path);
			file_name.append ("/Eref.c");
			!!Result.make (file_name);
		end;

	Skeleton_file: UNIX_FILE is
			-- File where the skeletons correponding to the
			-- Eiffel class types are generated
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 10);
			file_name.append (generation_path);
			file_name.append ("/Eskelet.c");
			!!Result.make (file_name);
		end;

	Cecil_file: UNIX_FILE is
			-- File where the datas for visible classes are generated
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 10);
			file_name.append (generation_path);
			file_name.append ("/Evisib.c");
			!!Result.make (file_name);
		end;

	Conformance_file: UNIX_FILE is
			-- File where the conformance tables are generated.
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 12);
			file_name.append (generation_path);
			file_name.append ("/Econform.c");
			!!Result.make (file_name);
		end;

	Plug_file: UNIX_FILE is
			-- File miscellenaeous datas are generated for the run-time
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 12);
			file_name.append (generation_path);
			file_name.append ("/Eplug.c");
			!!Result.make (file_name);
		end;

	Pattern_file: UNIX_FILE is
			-- File where all the pattern for the workbench mode
			-- are generated
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 12);
			file_name.append (generation_path);
			file_name.append ("/Epattern.c");
			!!Result.make (file_name);
		end;

	Option_file: UNIX_FILE is
			-- File where the compilation option are generated
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 12);
			file_name.append (generation_path);
			file_name.append ("/Eoption.c");
			!!Result.make (file_name);
		end;

	Rout_info_file: UNIX_FILE is
			-- File where the compilation option are generated
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 12);
			file_name.append (generation_path);
			file_name.append ("/Ecall.c");
			!!Result.make (file_name);
		end;

	Initialization_file: UNIX_FILE is
			-- File where the C routine `c_main' is generated
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 12);
			file_name.append (generation_path);
			file_name.append ("/Einit.c");
			!!Result.make (file_name);
		end;

	Main_file: UNIX_FILE is
			-- File where the C routine `c_main' is generated
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 12);
			file_name.append (generation_path);
			file_name.append ("/Emain.c");
			!!Result.make (file_name);
		end;

	Dispatch_file: UNIX_FILE is
			-- File where the dispatch table `dispatch' is generated
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 14);
			file_name.append (generation_path);
			file_name.append ("/Edispatch.c");
			!!Result.make (file_name);
		end;

	Frozen_file: UNIX_FILE is
			-- File where the frozen routines array `frozen' is generated
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 14);
			file_name.append (generation_path);
			file_name.append ("/Efrozen.c");
			!!Result.make (file_name);
		end;

	Make_file: UNIX_FILE is
			-- Makefile for C compilation
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 14);
			file_name.append (generation_path);
			file_name.append ("/Makefile.SH");
			!!Result.make (file_name);
		end;

	Update_file: UNIX_FILE is
			-- File containing all the byte code to update
		local
			file_name: STRING;
		once
			!!file_name.make (generation_path.count + 6);
			file_name.append (generation_path);
			file_name.append ("/.UPDT");
			!!Result.make (file_name);
		end

end
