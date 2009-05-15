note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XU_OUTPUTTER

inherit
	ANY rename print as any_print end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create print_mutex.make
		ensure
			print_mutex_attached: print_mutex /= Void
		end


feature -- Access

	name: SETTABLE_STRING
		-- The name of the application

	debug_level: SETTABLE_INTEGER
		-- The current debug level

	print_mutex: MUTEX

feature -- Status Change

	set_name (a_name: STRING)
			-- Setts name.
		require
			a_name_attached: a_name /= Void
		do
			name := a_name
		ensure
			name_set: equal (name, a_name)
		end

	set_debug_level (a_debug_level: INTEGER)
			-- Setts name.
		do
			debug_level := a_debug_level
		ensure
			debug_level_set: equal (debug_level, a_debug_level)
		end

feature -- Print

	dprint (a_msg: STRING; a_debug_level: INTEGER)
			-- Prints a debug message only if debug level is >= a_debug_level
		require
			name_set: name.is_set
			debug_level_set: debug_level.is_set
			a_msg_attached: a_msg /= Void
		do
			dprintn (a_msg + "%N", a_debug_level)
		end

	dprintn (a_msg: STRING; a_debug_level: INTEGER)
			-- Prints a debug message (with no %N)  only if debug level is >= a_debug_level
		require
			name_set: name.is_set
			debug_level_set: debug_level.is_set
			a_msg_attached: a_msg /= Void
		do
			if a_debug_level <= debug_level then
				print ("[" + name.out + "][DEBUG] " + a_msg )
			end
		end

	eprint (a_msg: STRING; a_generating_type: ANY)
			-- Prints an error message
		require
			name_set: name.is_set
			a_msg_attached: a_msg /= Void
			a_generating_type_attached: a_generating_type /= Void
		do
			print ("[" + name.out + "][ERROR in " + a_generating_type.out + "] " + a_msg + "%N")
		end

	iprint (a_msg: STRING)
			-- Prints an info message
		require
			name_set: name.is_set
			a_msg_attached: a_msg /= Void
		do
			print ("[" + name.out + "][INFO] " + a_msg + "%N")
		end

feature {NONE}  -- Impl

	print (a_msg: STRING)
			-- Engulfs print with mutex
		require
			a_msg_attached: a_msg /= Void
		do
			print_mutex.lock
			any_print (a_msg)
			print_mutex.unlock
		end

invariant
	print_mutex_attached: print_mutex /= Void
end
