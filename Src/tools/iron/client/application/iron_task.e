note
	description: "Summary description for {IRON_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_TASK

inherit
	ANY
		rename
			print as print_any
		end

	LOCALIZED_PRINTER
		rename
			print as print_any,
			localized_print as print
		end

	IRON_NAMES
		rename
			print as print_any
		end

feature {NONE} -- Initialization

	make (args: ARRAY [IMMUTABLE_STRING_32])
		do
			create {ARGUMENT_STRING_SOURCE} argument_source.make_from_array (args)
		end

feature -- Access

	argument_source: ARGUMENT_SOURCE
			-- Argument source

	name: READABLE_STRING_8
			-- Iron client task
		deferred
		end

feature -- Networking

	new_client: HTTP_CLIENT
		do
			create {LIBCURL_HTTP_CLIENT} Result.make
		end

feature -- Execute

	process (a_iron: IRON)
		deferred
		end

feature -- Output

	print_new_line
		do
			io.put_new_line
		end

end
