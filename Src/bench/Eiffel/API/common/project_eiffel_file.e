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

	EXCEPTIONS

	UNIX_SIGNALS
		rename
			meaning as sig_meanging,
			ignore as sig_ignore,
			catch as sig_catch
		end

	SYSTEM_CONSTANTS

	MEMORY
		undefine
			dispose
		end

creation
	make

feature {NONE} -- Initialization

	make (a_file_name: STRING) is
		do
			error_value := ok_value;
			file_make (a_file_name);
		end;

feature -- Access

	precompilation_id: INTEGER;
			-- Precompilation id when checking for precompilation validity
			
	project_version_number: STRING;
			-- Version number of project eiffel file

	project_storable_version_number: STRING;
			-- Version number of the storable version of the compiler used
			-- to store the project file

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
				--| True because a project file has a header
			Result ?= retrieved_object (True)
		ensure
			valid_result: not error implies Result /= Void
			version_number_exists: project_version_number /= Void
		end;

	retrieved_precompile: PRECOMP_INFO is
			-- Retrieve the precompile info of project
			-- (Note: error cannot be invalid_precompilation)
		do
				--| False because a precompiled project file has no header
			Result ?= retrieved_object (False)
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
			file_precomp_id: INTEGER
		do
			error_value := ok_value;

				--| If the project header part is missing, we will set
				--| error value to incompatible_value
			parse_project_header

			if error_value = ok_value then
				if not project_storable_version_number.is_equal (storable_version_number) then
					error_value := incompatible_value;
				elseif precomp_id /= 0 and then precomp_id /= precompilation_id then
					error_value := invalid_precompilation_value;
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

	retrieved_object (has_header: BOOLEAN): ANY is
			-- Retrieve project
		local
			retried: BOOLEAN
		do
			if not retried then
				open_read
				if has_header then
					check_version_number (0);
				end
				if not error then
						--| To add the storable part after the project header
						--| we need to set the position in the file
						--| otherwise the retrieving won't work correctly
					go (position)
					full_coalesce
					full_collect
					collection_off
					Result := retrieved;
					collection_on
					full_coalesce
					full_collect
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
				--| Re-initialize the storing for the SERVERs
			retried := True
			retry
		end;

	parse_project_header is
			-- Parse the project header file to get the following information:
			-- version_number_tag
			-- storable_version_number_tag
			-- precompilation_id
			--| The format is the followin:
			--| -- system name is xxx
			--| version_number_tag
			--| storable_version_number_tag
			--| precompilation_id
			--| -- end of info
		require
			is_open_read: is_readable
		local
			line, tag, value: STRING
			index, line_number: INTEGER
			retried: BOOLEAN
		do
			if not retried then
				from
					read_line
					read_line
					line := clone (last_string)
				until
					line_number > 4 or else line.is_equal (info_flag_end)
				loop
						-- Read the version number tag
					index := line.index_of (':', 1)
					tag := line.substring (1, index - 1)
					value := line.substring (index + 1, line.count)

					if version_number_tag.is_equal (tag) then
						project_version_number := value
					elseif storable_version_number_tag.is_equal (tag) then
						project_storable_version_number := value
					elseif precompilation_id_tag.is_equal (tag) then	
						precompilation_id := value.to_integer
					else
						error_value := incompatible_value
					end

					read_line
					line := clone (last_string)
				end
			else
				error_value := incompatible_value
			end
		rescue
			retried := True
			retry
		end

end -- class PROJECT_EIFFEL_FILE
