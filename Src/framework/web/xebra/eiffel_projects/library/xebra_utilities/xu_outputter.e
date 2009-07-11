note
	description: "[
		Provides logging features that gradually format the message.
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_OUTPUTTER

inherit
	ANY


create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create i_name.make_empty
			create i_debug_level.make_empty
		ensure
			i_name_attached: i_name /= Void
			i_debug_level_attached: i_debug_level /= Void
		end


feature -- Access

	configured: BOOLEAN
			-- Checks if the outputter has been configured and all neccesary attributes have been set
		do
			Result := (i_name /= Void and then i_name.is_set) and (i_debug_level /= Void and then i_debug_level.is_set)
		end

	add_input_line: BOOLEAN assign set_add_input_line

	name: STRING
			-- The name of the application
		do
			if i_name.is_set then
				Result := i_name.value
			else
				Result := "NO NAME SET"
			end
		end

	debug_level: INTEGER
			-- The current debug level
		do
			if i_debug_level.is_set then
				Result := i_debug_level.value
			else
				Result := 0
			end
		end

feature {NONE} -- Internal Access

	i_name: SETTABLE_STRING
		-- The name of the application

	i_debug_level: SETTABLE_INTEGER
		-- The current debug level


feature -- Status Change

	set_name (a_name: STRING)
			-- Sets name.
		require
			a_name_attached: a_name /= Void
		do
			i_name := a_name
		ensure
			name_set: equal (i_name.value, a_name)
		end

	set_add_input_line (a_add_input_line: BOOLEAN)
			-- Sets add_input_line.
		do
			add_input_line := a_add_input_line
		ensure
			add_input_line_set: equal (add_input_line, a_add_input_line)
		end

	set_debug_level (a_debug_level: INTEGER)
			-- Sets name.
		do
			i_debug_level := a_debug_level
		ensure
			debug_level_set: equal (i_debug_level.value, a_debug_level)
		end

feature -- Print

--	dprint (a_msg: STRING; a_debug_level: INTEGER)
--			-- Prints a debug message only if debug level is >= a_debug_level
--		require
--			name_set: name.is_set
--			debug_level_set: debug_level.is_set
--			a_msg_attached: a_msg /= Void
--		do
--			dprintn (a_msg +  , a_debug_level)
--		end

	dprintn (a_msg: STRING; a_debug_level: INTEGER)
			--Prints a debug message  only if debug level is >= a_debug_level without formatting
		require
--			name_set: name.is_set
--			debug_level_set: debug_level.is_set
			a_msg_attached: a_msg /= Void
			outputter_configured: configured
		do
			if a_debug_level <= debug_level then
				print_with_cmdnl (a_msg)
			end
		end


	dprint (a_msg: STRING; a_debug_level: INTEGER)
			-- Prints a debug message  only if debug level is >= a_debug_level
		require
--			name_set: name.is_set
--			debug_level_set: debug_level.is_set
			a_msg_attached: a_msg /= Void
			outputter_configured: configured
		do
			if a_debug_level <= debug_level then
				print_with_name ("[DEBUG" + a_debug_level.out + "] " + a_msg)
			end
		end

	eprint (a_msg: STRING; a_generating_type: ANY)
			-- Prints an error message
		require
			outputter_configured: configured
--			name_set: name.is_set
--			a_msg_attached: a_msg /= Void
			a_generating_type_attached: a_generating_type /= Void
		do
			print_with_name ("[ERROR in " + a_generating_type.out + "] " + a_msg)
		end

	iprint (a_msg: STRING)
			-- Prints an info message
		require
			outputter_configured: configured
--			name_set: name.is_set
			a_msg_attached: a_msg /= Void
		do
			print_with_name ("[INFO] " + a_msg )
		end

feature {NONE}  -- Impl

	print_with_name (a_msg: STRING)
			-- Adds the name
		require
			outputter_configured: configured
			a_msg_attached: a_msg /= Void
		do
			print_with_cmdnl ("[" + name.out + "]" + a_msg)
		end

	print_with_cmdnl (a_msg: STRING)
			-- Adds a new line at the start and the end and the command symbol(s)
		require
			outputter_configured: configured
			a_msg_attached: a_msg /= Void
 		local
			l_f_utils: XU_FILE_UTILITIES
		do
			create l_f_utils.make

			if attached {PLAIN_TEXT_FILE}l_f_utils.plain_text_file_append_create (name + ".log") as l_file then
				l_file.put_string ("%N" + a_msg)
				l_f_utils.close
			end

			if add_input_line then
				print ("%N" + a_msg + "%N$> ")

			else
				print ("%N" + a_msg)
			end
		end



invariant
		i_name_attached: i_name /= Void
		i_debug_level_attached: i_debug_level /= Void
		name_attached: name /= Void
		debug_level_attached: debug_level /= Void
end
