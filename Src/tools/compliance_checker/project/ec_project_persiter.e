indexing
	description: "[
		General purpose persistance and retrieval for a loaded compliance project.
	]"
	author     : "$Author$"
	date       : "$Date$"
	revision   : "$Revision$"

class
	EC_PROJECT_PERSITER

inherit
	EC_SHARED_PROJECT
		export
			{NONE} all
		end

feature -- Basic Operations

	load_project (a_path: STRING) is
			-- Loads project from `a_path'
		local
			l_file: RAW_FILE
			l_project: like project
			l_reader: SED_MEDIUM_READER_WRITER
		do
			create l_file.make_open_read (a_path)
			create l_reader.make (l_file)
			l_reader.set_for_reading
 			l_project ?= sed_utilities.retrieved (l_reader, False)
 			if l_project /= Void then
 				internal_project_settings.put (l_project)
 			end
 			l_file.close			
		end
		
	save_project (a_path: STRING) is
			-- Saves project to `a_path'
		local
			l_file: RAW_FILE
			l_writer: SED_MEDIUM_READER_WRITER
		do
			create l_file.make_open_write (a_path)
			create l_writer.make (l_file)
			l_writer.set_for_writing
 			sed_utilities.session_store (project, l_writer, False)
 			l_file.flush
 			l_file.close
		end
		
feature {NONE} -- Implementation

	sed_utilities: SED_STORABLE_FACILITIES is
			-- Storable utilities
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end		

end -- class EC_PROJECT_PERSITER
