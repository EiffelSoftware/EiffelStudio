indexing

	description: 
		"project.eif or precompile.eif file for an eiffelbench project.";
	date: "$Date$";
	revision: "$Revision $"

class PROJECT_EIFFEL_FILE

inherit

	RAW_FILE
		rename
			make as file_make
		end;
	STORABLE;
	EXCEPTIONS;
	UNIX_SIGNALS
		rename
			meaning as sig_meanging,
			ignore as sig_ignore,
			catch as sig_catch
		end;
	SYSTEM_CONSTANTS

creation
	make

feature {NONE} -- Initialization

	make (a_file_name, prj_txt_name: FILE_NAME) is
		do
			error_value := ok_value;
			file_make (a_file_name);
			project_txt_name := prj_txt_name;
		end;

feature -- Access

	precompilation_id: INTEGER;
			-- Precompilation id when checking for precompilation validity
			
	project_version_number: STRING;
			-- Version number of project eiffel file
			-- found in `project.txt' file
			-- (Empty version implies there was no version file)

	project_txt_name: FILE_NAME;
			-- Project.txt file associated with current eiffel file

	is_interrupted: BOOLEAN is
			-- Was the retrieve of the project interrupted?
		do
			Result := error_value = interrupt_value
		end

	is_invalid_precompilation: BOOLEAN is
			-- Is the precompilation invalid?
		do
			Result := error_value = invalid_precompilation_value
		end

	is_corrupted: BOOLEAN is
			-- Is the project corrupted?
		do
			Result := error_value = corrupt_value
		end

	is_incompatible: BOOLEAN is
			-- Is the project incompatible with the current version ?
		do
			Result := error_value = incompatible_value
		end;

	error: BOOLEAN is
			-- Did an error occured during the retrieval?
		do
			Result := error_value /= ok_value
		end;

	retrieved_project: E_PROJECT is
			-- Retrieve project
			-- (Note: error cannot be invalid_precompilation)
		do
			Result ?= retrieved_object
		ensure
			valid_result: not error implies Result /= Void
			version_number_exists: project_version_number /= Void
		end;

	retrieved_precompile: PRECOMP_INFO is
			-- Retrieve the precompile info of project
			-- (Note: error cannot be invalid_precompilation)
		do
			Result ?= retrieved_object
		ensure
			valid_result: not error implies Result /= Void
			version_number_exists: project_version_number /= Void
		end;

feature -- Update

	check_version_number (precomp_id: INTEGER) is
			-- Check the version number of the project.txt file.
			-- If `precomp_id' is 0 then do not check precompilation_id.
			-- If error ok set the error state.
		local
			f_parser: RESOURCE_PARSER;
			project_txt_file: PLAIN_TEXT_FILE;
			rt: RESOURCE_TABLE;
			stored_project_version_number: STRING;
			file_precomp_id: INTEGER
		do
			error_value := ok_value;
			!! project_version_number.make (0);
			!! project_txt_file.make (project_txt_name);	
			if not project_txt_file.exists or else
				not project_txt_file.is_readable or else
				project_txt_file.empty or else
				not project_txt_file.is_plain
			then
				error_value := incompatible_value;
			else
				!! rt.make (1);
				!! f_parser;
				f_parser.parse_file (project_txt_name, rt);
				project_version_number := rt.get_string 
					(version_number_tag, "");
				stored_project_version_number := rt.get_string 
					(storable_version_number_tag, "");
				if 
					project_version_number.empty or else 
					stored_project_version_number.empty or else 
					not stored_project_version_number.is_equal (storable_version_number)
				then
					error_value := incompatible_value;
					if project_version_number.empty then
						project_version_number.append ("unknown")
					end
				elseif precomp_id /= 0 then
					precompilation_id := rt.get_integer (precompilation_id_tag, 0);
					if precomp_id /= precompilation_id then
						error_value := invalid_precompilation_value;
					end
				end
			end
		ensure
			error_means_incompatible: error implies is_incompatible;
			valid_version_number: project_version_number /= Void
		end;

feature {NONE} -- Implementation

	error_value: INTEGER;
			-- Error value

	ok_value, corrupt_value, invalid_precompilation_value,
	incompatible_value, interrupt_value: INTEGER is unique
			-- Error values

	retrieved_object: ANY is
			-- Retrieve project
		local
			retried: BOOLEAN
		do
			if not retried then
				check_version_number (0);
				if not error then
					open_read;
					Result := retrieved (Current);
					close;
					if Result = Void then
						error_value := corrupt_value
					end
				end
			end
		ensure
			valid_result: not error implies Result /= Void
		rescue
			if not is_closed then
				close;
			end;
			if is_signal and then signal = Sigint then
				error_value := interrupt_value
			else
				error_value := corrupt_value
			end;
			retried := True
			retry
		end;

end -- class PROJECT_EIFFEL_FILE
