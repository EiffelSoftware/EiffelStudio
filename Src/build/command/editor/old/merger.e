
class MERGER 

inherit

	UNIX_ENV
		export
			{NONE} all
		end



	
feature {NONE}

	Template_directory: STRING is
		once
			Result := Generated_directory.duplicate;
			Result.append ("/.templates");
		end;

	
feature 

	integrate (s1, s2, s3: STRING): STRING is
		
		local
			unix_command: STRING;
			temp: ANY
		do
			to_file ("cmd.doc", s1);
			to_file ("cmd.temp.old", s2);
			to_file ("cmd.temp.new", s3);	
				!!unix_command.make (0);
				unix_command.append (EiffelBuild_directory);
				unix_command.append ("/bin/merge2");
				unix_command.append (" ");
				unix_command.append (full_path ("cmd.doc"));
				unix_command.append (" ");
				unix_command.append (full_path ("cmd.temp.old"));
				unix_command.append (" ");
				unix_command.append (full_path ("cmd.temp.new"));
			temp := unix_command.to_c;
			merger_system ($temp);
			Result := from_file ("cmd.doc");
		end;

	
feature {NONE}

	full_path (fn: STRING): STRING is
		do
			!!Result.make (0);
			Result.append (Template_directory);
			Result.append ("/");
			Result.append (fn);
		end;

	from_file (fn: STRING): STRING is
		local
			temp: ANY
		do
			!!Result.make (0);
			temp := full_path ("cmd.doc").to_c;
			Result.from_c (merger_file_to_string ($temp));
		end;

	to_file (fn: STRING; s: STRING) is
		local
			f: UNIX_FILE;
		do
			!!f.make_open_write (full_path (fn));
			f.putstring (s);
			f.close
		end;

feature {NONE} -- External features

	merger_system (cmd: ANY) is
		external
			"C"
		alias
			"system"
		end; -- merger_system

	merger_file_to_string (f: ANY): ANY is
		external
			"C"
		alias
			"file_to_string"
		end; -- merger_file_to_string

end
