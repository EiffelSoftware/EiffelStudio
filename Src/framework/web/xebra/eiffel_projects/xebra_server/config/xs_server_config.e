note
	description: "Summary description for {XS_SERVER_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XS_SERVER_CONFIG

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create args.make_empty
			create file.make_empty
		ensure
			args_attached: args /= Void
			file_attached: file /= Void
		end

feature -- Access

	args: XS_ARG_CONFIG assign set_args

	file: XS_FILE_CONFIG assign set_file

feature {XCC_LOAD_CONFIG} -- Status setting

	set_args (a_args: like args)
			-- Sets args.
		require
			a_args_attached: a_args /= Void
		do
			args := a_args
		ensure
			args_set: args  = a_args
		end

	set_file (a_file: like file)
			-- Sets file.
		require
			a_file_attached: a_file /= Void
		do
			file := a_file
		ensure
			file_set: file  = a_file
		end

invariant
	args_attached: args /= Void
	file_attached: file /= Void

end
