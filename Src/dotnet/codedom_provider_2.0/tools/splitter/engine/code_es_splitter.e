 indexing
	description: "Splitter, will generate Eiffel class files from Eiffel multi-class files."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ES_SPLITTER

inherit
	CODE_ES_SHARED_DIRECTORY_SEPARATOR

	CODE_SHARED_CLASS_SEPARATOR
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_folder, a_regexp, a_destination_folder: STRING; a_process_subfolders: BOOLEAN) is
			-- Initialize instance.
		require
			non_void_folder: a_folder /= Void
			valid_folder: a_folder.item (a_folder.count) /= Directory_separator
			non_void_regexp: a_regexp /= Void
			valid_destination_folder: a_destination_folder /= Void implies a_destination_folder.item (a_destination_folder.count) /= Directory_separator
		do
			folder := a_folder
			regexp := a_regexp
			destination_folder := a_destination_folder
			process_subfolders := a_process_subfolders
			create parser.make
			parser.set_il_parser
			create generated_files.make (20)
		ensure
			folder_set: folder = a_folder
			regexp_set: regexp = a_regexp
			destination_folder_set: destination_folder = a_destination_folder
			process_subfolders_set: process_subfolders = a_process_subfolders
		end

feature -- Access

	folder: STRING
			-- Folder containing Eiffel multi-class files
	
	regexp: STRING
			-- Regular expression that Eiffel multi-class files must match to be processed
	
	destination_folder: STRING
			-- Folder where Eiffel class files should be generated
	
	process_subfolders: BOOLEAN
			-- Should subfolders of `folder' be scanned for Eiffel multi-class files?

	event_handler: ROUTINE [ANY, TUPLE [EV_THREAD_EVENT]]
			-- Event handler

	file_count: INTEGER is
			-- Number of created files
		do
			Result := generated_files.count
		end

feature -- Basic Operation

	split_files (a_event_handler: like event_handler) is
			-- Scan `folder' and its subfolders if `process_subfolders' for files
			-- matching `regexp' and generate corresponding Eiffel class files in
			-- `destination_folder' if not Void or in current folder otherwise.
			-- Generate events and call `event_handler' if not void to handle
			-- them.
		local
			l_dir: DIRECTORY
			l_message: STRING
			l_severity: INTEGER
		do
			event_handler := a_event_handler
			generated_files.clear_all
			create l_dir.make (folder)
			if l_dir.exists then
				split_files_in_folder (folder)
				if file_count > 1 then
					l_message := "%N--%NTotal number of files created: " + file_count.out + "."
					l_severity := {EV_THREAD_SEVERITY_CONSTANTS}.Information
				elseif file_count > 0 then
					l_message := "%N--%NCreated one file."
					l_severity := {EV_THREAD_SEVERITY_CONSTANTS}.Information
				else
					l_message := "%N--%NCouldn't find a file in '" + folder
					if process_subfolders then
						l_message.append ("' and subfolders ")
					else
						l_message.append ("' ")
					end
					l_message.append ("that matched regular expression '" + regexp + "'")
					l_severity := {EV_THREAD_SEVERITY_CONSTANTS}.Error
				end
				raise_event (create {CODE_ES_EVENT}.make (l_message, "Scan Finished", l_severity))
			else
				raise_event (create {CODE_ES_EVENT}.make ("Folder '" + folder + "' does not exist!", "Missing Specified Folder", {EV_THREAD_SEVERITY_CONSTANTS}.Error))
			end
			raise_event (create {CODE_ES_EVENT}.make ("", "", {EV_THREAD_SEVERITY_CONSTANTS}.Stop))
		end

feature {NONE} -- Implementation

	split_files_in_folder (a_folder: STRING) is
			-- Split files in folder `a_folder' and subfolder if `process_subfolders'.
		require
			non_void_folder: a_folder /= Void
			valid_folder: a_folder.item (a_folder.count) /= Directory_separator
		local
			l_dir: DIRECTORY
			l_files: LIST [STRING]
			l_retried: BOOLEAN
			l_file, l_full_path: STRING
			l_regexp: RX_PCRE_REGULAR_EXPRESSION
		do
			if not l_retried then
				create l_regexp.make
				l_regexp.compile (regexp)
				if l_regexp.is_compiled then
					raise_event (create  {CODE_ES_EVENT}.make ("Scanning '" + a_folder + "'...",
																"Folder Scan",
																{EV_THREAD_SEVERITY_CONSTANTS}.Information))
					create l_dir.make (a_folder)
					l_files := l_dir.linear_representation
					from
						l_files.start
					until
						l_files.after
					loop
						l_file := l_files.item
						if not l_file.is_equal (".") and not l_file.is_equal ("..") then
							create l_full_path.make (l_file.count + a_folder.count + 1)
							l_full_path.append (a_folder)
							l_full_path.append_character (Directory_separator)
							l_full_path.append (l_file)
							create l_dir.make (l_full_path)
							if l_dir.exists then
								if process_subfolders then
									split_files_in_folder (l_full_path)
								end	
							elseif l_regexp.matches (l_file) then
								split_file (l_full_path)
							end
						end
						l_files.forth
					end
				else
					raise_event (create  {CODE_ES_EVENT}.make ("Could not compile regular expression '" + regexp + "'",
																"Invalid Regular Expression",
																{EV_THREAD_SEVERITY_CONSTANTS}.Error))
				end
			end
		rescue
			l_retried := True
			raise_event (create {CODE_ES_EVENT}.make ("The following exception was raised: " + {ISE_RUNTIME}.last_exception.to_string,
														"Exception Raised",
														{EV_THREAD_SEVERITY_CONSTANTS}.Error))
			retry
		end
	
	split_file (a_file_path: STRING) is
			-- Split file at path `a_file'.
		require
			non_void_path: a_file_path /= Void
		local
			l_retried: BOOLEAN
			l_file: PLAIN_TEXT_FILE
			l_content, l_dir: STRING
			l_index, l_old_index: INTEGER
			l_res: SYSTEM_OBJECT
		do
			if not l_retried then
				if destination_folder = Void then
					l_index := a_file_path.last_index_of (Directory_separator, a_file_path.count)
					if l_index > 0 then
						l_dir := a_file_path.substring (1, l_index)
					else
						l_dir := (create {EXECUTION_ENVIRONMENT}).Current_working_directory
						l_dir.append_character (Directory_separator)
					end
				else
					l_dir := destination_folder.twin
					if not {SYSTEM_DIRECTORY}.exists (l_dir) then
						l_res := {SYSTEM_DIRECTORY}.create_directory (l_dir)
					end
					l_dir.append_character (Directory_separator)
				end
				check
					non_void_destination_folder: l_dir /= Void
					valid_destination_folder: l_dir.item (l_dir.count) = Directory_separator
				end
				create l_file.make (a_file_path)
				if l_file.exists then
					l_file.open_read
					l_file.read_stream (l_file.count)
					l_content := l_file.last_string
					l_file.close
					raise_event (create {CODE_ES_EVENT}.make ("Parsing file '" + a_file_path + "'",
																"Parsing File",
																{EV_THREAD_SEVERITY_CONSTANTS}.Information))
					from
						l_old_index := 1
						l_index := l_content.substring_index (Class_separator, l_old_index)
					until
						l_index = 0
					loop
						write_class (l_content.substring (l_old_index, l_index - 1), l_dir)
						l_old_index := l_index + Class_separator.count
						l_index := l_content.substring_index (Class_separator, l_old_index)
					end
					if l_old_index < l_content.count then
						write_class (l_content.substring (l_old_index,  l_content.count), l_dir)
					end
				else
					raise_event (create {CODE_ES_EVENT}.make ("File '" + a_file_path + "' does not exist!",
																"Missing specified folder",
																{EV_THREAD_SEVERITY_CONSTANTS}.Error))
				end
			end
		rescue
			l_retried := True
			raise_event (create {CODE_ES_EVENT}.make ("The following exception was raised: " + {ISE_RUNTIME}.last_exception.to_string,
														"Exception Raised",
														{EV_THREAD_SEVERITY_CONSTANTS}.Error))
			retry
		end
	
	write_class (a_class_text, a_directory: STRING) is
			-- Write Eiffel class with content `a_class_text'.
		require
			non_void_class_text: a_class_text /= Void
			non_void_directory: a_directory /= Void
			valid_directory: a_directory.item (a_directory.count) = Directory_separator
		local
			l_retried: BOOLEAN
			l_file: PLAIN_TEXT_FILE
			l_name, l_class_name: STRING
		do
			if not l_retried then
				parser.parse_from_string (a_class_text)
				if parser.root_node /= Void and then parser.root_node.class_name /= Void then
					l_class_name := parser.root_node.class_name.as_lower
					create l_name.make (a_directory.count + l_class_name.count + 2)
					l_name.append (a_directory)
					l_name.append (l_class_name)
					l_name.append (".e")
					create l_file.make (l_name)
					if l_file.exists then
						l_file.delete
						raise_event (create {CODE_ES_EVENT}.make ("A file with path '" + l_file.name + "' already existed and has been overwritten.",
																	"File Overwritten",
																	{EV_THREAD_SEVERITY_CONSTANTS}.Warning))
					end
					l_file.open_write
					l_file.put_string (a_class_text)
					l_file.close
					generated_files.force (l_name, l_name)
					raise_event (create {CODE_ES_EVENT}.make ("Created file '" + l_file.name + "'",
																"File Created",
																{EV_THREAD_SEVERITY_CONSTANTS}.Information))
				else
					raise_event (create {CODE_ES_EVENT}.make ("Could not parse class text",
																"Parse Error",
																{EV_THREAD_SEVERITY_CONSTANTS}.Error))
				end
			end
		rescue
			l_retried := True
			raise_event (create {CODE_ES_EVENT}.make ("The following exception was raised: " + {ISE_RUNTIME}.last_exception.to_string,
														"Exception Raised",
														{EV_THREAD_SEVERITY_CONSTANTS}.Error))
			retry
		end
		
	raise_event (a_event: EV_THREAD_EVENT) is
			-- Call event handler.
		require
			non_void_event: a_event /= Void
		do
			event_handler.call ([a_event])
		end
	
	parser: EIFFEL_PARSER
			-- Eiffel parser

	generated_files: HASH_TABLE [STRING, STRING]
			-- Generated file names
			--| We have to keep file names as simply incrementing a counter wouldn't work
			--| because the same file can be generated twice.

invariant
	non_void_folder: folder /= Void
	valid_folder: folder.item (folder.count) /= Directory_separator
	non_void_regexp: regexp /= Void
	non_void_parser: parser /= Void

end -- class CODE_ES_SPLITTER

--+--------------------------------------------------------------------
--| eSplitter
--| Copyright (C) Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------