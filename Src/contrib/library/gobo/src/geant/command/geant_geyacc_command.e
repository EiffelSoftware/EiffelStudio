note

	description:

		"Geyacc commands"

	library: "Gobo Eiffel Ant"
	copyright: "Copyright (c) 2001-2013, Sven Ehrke and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class GEANT_GEYACC_COMMAND

inherit

	GEANT_COMMAND
		redefine
			make
		end

create

	make

feature {NONE} -- Initialization

	make (a_project: GEANT_PROJECT)
			-- Create a new 'geyacc' command.
		do
			precursor (a_project)
			output_filename := ""
			input_filename := ""
		end

feature -- Status report

	is_executable: BOOLEAN
			-- Can command be executed?
		do
			Result := input_filename /= Void and then input_filename.count > 0
		ensure then
			input_filename_not_void: Result implies input_filename /= Void
			input_filename_not_empty: Result implies input_filename.count > 0
		end

feature -- Access

	verbose_filename: STRING
			-- -v option

	rescue_on_abort: BOOLEAN
			-- --rescue-on-abort option, default: false
			
	separate_actions: BOOLEAN
			-- -x option, default: false

	tokens_classname: STRING
			-- -t option

	tokens_filename: STRING
			-- -k option

	output_filename: STRING
			-- -o option

	input_filename: STRING
			-- Input filename

feature -- Setting

	set_verbose_filename (a_filename: like verbose_filename)
			-- Set `verbose_filename' to `a_filename'.
		require
			a_filename_not_void: a_filename /= Void
			a_filename_not_empty: a_filename.count > 0
		do
			verbose_filename := a_filename
		ensure
			verbose_filename_set: verbose_filename = a_filename
		end

	set_rescue_on_abort (b: BOOLEAN)
			-- Set  `rescue_on_abort' to `b'.
		do
			rescue_on_abort := b
		ensure
			rescue_on_abort_set: rescue_on_abort = b
		end
		
	set_separate_actions (b: BOOLEAN)
			-- Set  `separate_actions' to `b'.
		do
			separate_actions := b
		ensure
			separate_actions_set: separate_actions = b
		end

	set_tokens_classname (a_classname: like tokens_classname)
			-- Set `tokens_classname' to `a_classname'.
		require
			a_classname_not_void: a_classname /= Void
			a_classname_not_empty: a_classname.count > 0
		do
			tokens_classname := a_classname
		ensure
			tokens_classname_set: tokens_classname = a_classname
		end

	set_tokens_filename (a_filename: like tokens_filename)
			-- Set `tokens_filename' to `a_filename'.
		require
			a_filename_not_void: a_filename /= Void
			a_filename_not_empty: a_filename.count > 0
		do
			tokens_filename := a_filename
		ensure
			tokens_filename_set: tokens_filename = a_filename
		end

	set_output_filename (a_filename: like output_filename)
			-- Set `output_filename' to `a_filename'.
		require
			a_filename_not_void: a_filename /= Void
			a_filename_not_empty: a_filename.count > 0
		do
			output_filename := a_filename
		ensure
			output_filename_set: output_filename = a_filename
		end

	set_input_filename (a_filename: like input_filename)
			-- Set `input_filename' to `a_filename'.
		require
			a_filename_not_void: a_filename /= Void
			a_filename_not_empty: a_filename.count > 0
		do
			input_filename := a_filename
		ensure
			input_filename_set: input_filename = a_filename
		end

feature -- Execution

	execute
			-- Execute command.
		local
			cmd: STRING
			a_filename: STRING
		do
			create cmd.make (128)
			cmd.append_string ("geyacc ")
				-- Option -v
			if verbose_filename /= Void and then verbose_filename.count > 0 then
				a_filename := file_system.pathname_from_file_system (verbose_filename, unix_file_system)
				cmd.append_string ("-v ")
				cmd := STRING_.appended_string (cmd, a_filename)
				cmd.append_string (" ")
			end
				-- Option -x
			if separate_actions then
				cmd.append_string ("-x ")
			end
				-- Option --rescue-on-abort
			if rescue_on_abort then
				cmd.append_string ("--rescue-on-abort ")
			end
				-- Option -t
			if tokens_classname /= Void and then tokens_classname.count > 0 then
				cmd.append_string ("-t ")
				cmd := STRING_.appended_string (cmd, tokens_classname)
				cmd.append_string (" ")
			end
				-- Option -k
			if tokens_filename /= Void and then tokens_filename.count > 0 then
				cmd.append_string ("-k ")
				cmd := STRING_.appended_string (cmd, tokens_filename)
				cmd.append_string (" ")
			end
				-- Option -o
			if output_filename /= Void and then output_filename.count > 0 then
				a_filename := file_system.pathname_from_file_system (output_filename, unix_file_system)
				cmd.append_string ("-o ")
				cmd := STRING_.appended_string (cmd, a_filename)
				cmd.append_string (" ")
			end
			a_filename := file_system.pathname_from_file_system (input_filename, unix_file_system)
			cmd := STRING_.appended_string (cmd, a_filename)

			project.trace (<<"  [geyacc] ", cmd>>)
			execute_shell (cmd)
		end

end
