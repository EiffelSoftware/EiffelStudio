note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_DINIMER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make ("/usr/local/home/fabisssoz/test.fg")
			if not l_file.exists then
				print ("not exist!")
			end

			if not l_file.path_exists then
					print ("not path exists ")
			end

			if not l_file.is_creatable then
					print ("not is_creatable ")
			end

				l_file.create_read_write
				l_file.put_double (5)
				l_file.close
		end

feature -- Access

feature -- Status report

feature -- Status setting

feature {NONE} -- Implementation

end

