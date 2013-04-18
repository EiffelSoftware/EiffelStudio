note
	description: "Summary description for {IRON_REPO_CONTROLLER_TASK}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IRON_REPO_CONTROLLER_TASK

feature -- Access

	name: READABLE_STRING_8
		deferred
		end

	arguments: detachable ARRAY [IMMUTABLE_STRING_32]

feature -- Change

	set_arguments (args: like arguments)
		local
			l_arguments: like arguments
		do
			if args /= Void and then not args.is_empty then
				create l_arguments.make_from_array (args)
				l_arguments.rebase (1)
				arguments := l_arguments
			else
				arguments := Void
			end
		end

feature -- Status report

	is_available (iron: IRON_REPO): BOOLEAN
		deferred
		end

feature -- Execution

	execute (iron: IRON_REPO)
		require
			is_available: is_available (iron)
		deferred
		end

end
