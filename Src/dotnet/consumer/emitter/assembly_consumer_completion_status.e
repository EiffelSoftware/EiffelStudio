indexing
	description: "[
		Persistant completion status for a consumed assembly between sessions.
		Serves as a recovery mechanism for assemblies that we not fully consumed
		in a prior session.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_CONSUMER_COMPLETION_STATUS
	
create
	make,
	make_from_consumed_path

feature {NONE} -- Iniitialization

	make (a_consumer: ASSEMBLY_CONSUMER) is
			-- create instance using a initalized ASSEMLBY_CONSUMER instance
		require
			non_void_consumer: a_consumer /= Void
			non_void_consumer_destination_path: a_consumer.destination_path /= Void
			valid_path: not a_consumer.destination_path.is_empty
		do
			make_from_consumed_path (a_consumer.destination_path)
		end
		
	make_from_consumed_path (a_path: STRING) is
			-- create instance using a path where assembly is consumed to
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_op_env: OPERATING_ENVIRONMENT
		do
			full_uncomplete_file_name := a_path.twin 
			create l_op_env
			if full_uncomplete_file_name.item (full_uncomplete_file_name.count) /= l_op_env.directory_separator then
				full_uncomplete_file_name.append_character (l_op_env.directory_separator)
			end
			full_uncomplete_file_name.append (uncomplete_file_name)
		end
		

feature -- Basic Operations

	started_consumption is
			-- notify that consumption has started
		require
			already_started: not is_completed
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_open_write (full_uncomplete_file_name)
			if uncomplete_file_contents /= Void then
				l_file.put_string (uncomplete_file_contents)	
			end
		ensure
			non_completed: not is_completed
		end
	
	finished_consumption (a_successful: BOOLEAN) is
			-- notify that consumption has completed.
			-- successful consumption is indicated by `a_successful'.
		require
			not_already_completed: not is_completed
		do
			if a_successful then
				(create {PLAIN_TEXT_FILE}.make (full_uncomplete_file_name)).delete
			end
		ensure
			correctly_completed: a_successful implies is_completed
		end		

feature -- Access

	is_completed: BOOLEAN is
			-- is or has assembly consumption been completed?
		do
			Result := not (create {RAW_FILE}.make (full_uncomplete_file_name)).exists
		end

feature {NONE} -- Implementation

	full_uncomplete_file_name: STRING
			-- full path to file indicating status of assembly consumption

	uncomplete_file_name: STRING is "partial"
			-- uncompleted consumption file name
			
	uncomplete_file_contents: STRING is "This assembly is being cosumed or failed to be consume in a previous session."
			-- contents of uncompleted file
		
		
invariant
	non_void_uncomplete_file_name: uncomplete_file_name /= Void
	valid_uncomplete_file_name: not uncomplete_file_name.is_empty
	non_void_full_uncomplete_file_name: full_uncomplete_file_name /= Void
	valid_full_uncomplete_file_name: not full_uncomplete_file_name.is_empty
	
end -- class ASSEMBLY_CONSUMER_COMPLETION_STATUS
