indexing
	description: 
		"project.eif or precompile.eif file for an eiffel project.";
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

	ace_file_path: STRING
			-- Path for the ace file corresponding to this project. Void
			-- if none.

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
			-- Did an error occurred during the retrieval?
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
		end;

feature -- Update

	check_version_number (precomp_id: INTEGER) is
			-- Check the version number of the project.txt file.
			-- If `precomp_id' is 0 then do not check precompilation_id.
			-- If error ok set the error state.
		do
			error_value := ok_value;

				--| If the project header part is missing, we will set
				--| error value to incompatible_value
			parse_project_header

			if error_value = ok_value then
				if not project_version_number.is_equal (version_number) then
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

	retrieved_object: ANY is
			-- Retrieve project
		local
			retried: BOOLEAN
		do
			if not retried then
				open_read
				check_version_number (0);
				if not error then
						--| To add the storable part after the project header
						--| we need to set the position in the file
						--| otherwise the retrieving won't work correctly
					go (position)
					full_collect
					full_coalesce
					collection_off
					Result := ise_compiler_retrieved (descriptor);
					collection_on
					full_collect
					full_coalesce
					if Result = Void then
						error_value := corrupt_value
					end
				end
					-- Close the Eiffel Project file.
				close;
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
			-- precompilation_id
			-- ace file path (in version 5.0.18 and above)
			--| The format is the followin:
			--| -- system name is xxx
			--| version_number_tag
			--| precompilation_id
			--| ace file path
			--| -- end of info
		require
			is_open_read: is_readable
		local
			line, string_tag, value: STRING
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
					string_tag := line.substring (1, index - 1)
					value := line.substring (index + 1, line.count)

					if version_number_tag.is_equal (string_tag) then
						project_version_number := value
					elseif precompilation_id_tag.is_equal (string_tag) then	
						precompilation_id := value.to_integer
					elseif ace_file_path_tag.is_equal (string_tag) then
						ace_file_path := clone (value)
					else
						error_value := incompatible_value
					end

					line_number := line_number + 1
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

feature {NONE} -- External

	ise_compiler_retrieved (f_desc: INTEGER) : ANY is
		external
			"C | %"pretrieve.h%""
		alias
			"parsing_retrieve"
		end

end -- class PROJECT_EIFFEL_FILE
