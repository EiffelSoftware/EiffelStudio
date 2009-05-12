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

	name: STRING
			-- The name of the outputter
		do
			if attached internal_name then
				Result := internal_name
			else
				Result := "XEB"
			end
		end

	internal_name: detachable STRING

	set_name (a_name: STRING)
		require
			a_name_attached: a_name /= Void
		do
			internal_name := a_name
		ensure
			name_set: equal (internal_name, a_name)
		end

	debug_level: INTEGER = 10
			-- Set the current debug level

	print_mutex: MUTEX


feature -- Print

	dprint (a_msg: STRING; a_debug_level: INTEGER)
			-- Prints a debug message only if debug level is >= a_debug_level
		require
			name_attached: name /= Void
			a_msg_attached: a_msg /= Void
		do
			dprintn (a_msg + "%N", a_debug_level)
		end

	dprintn (a_msg: STRING; a_debug_level: INTEGER)
			-- Prints a debug message (with no %N)  only if debug level is >= a_debug_level
		require
			name_attached: name /= Void
			a_msg_attached: a_msg /= Void
		do
			if a_debug_level <= debug_level then
				print ("[" + name + "][DEBUG] " + a_msg )
			end
		end

	eprint (a_msg: STRING; a_generating_type: ANY)
			-- Prints an error message
		require
			name_attached: name /= Void
			a_msg_attached: a_msg /= Void
		do
			print ("[" + name + "][ERROR in " + a_generating_type.out + "] " + a_msg + "%N")
		end

	iprint (a_msg: STRING)
			-- Prints an info message
		require
			name_attached: name /= Void
			a_msg_attached: a_msg /= Void
		do
			print ("[" + name + "][INFO] " + a_msg + "%N")
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
