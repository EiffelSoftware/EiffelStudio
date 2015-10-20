note
	description: "Abstraction of roc command."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROC_COMMAND

inherit
	SHARED_EXECUTION_ENVIRONMENT
		rename
			print as ascii_print
		end
		
	LOCALIZED_PRINTER
		rename
			print as ascii_print,
			localized_print as print
		end

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_8)
		do
			create name.make_from_string (a_name)
		end

feature -- Access	

	name: IMMUTABLE_STRING_8

	help: STRING_32
		deferred
		end

feature -- Status report

	is_valid (args:	ARRAY [READABLE_STRING_32]): BOOLEAN
		deferred
		end

feature -- Execution

	execute (args: ARRAY [READABLE_STRING_32])
		require
			args.lower = 0 -- Prog name at index 0, args at index 1, ...
		deferred
		end

note
	copyright: "2011-2015, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
