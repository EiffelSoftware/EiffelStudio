note
	description: "Summary description for {EIFFEL_SCRIPT_LAUNCH_PARAMETERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SCRIPT_LAUNCH_PARAMETERS

inherit
	EIFFEL_SCRIPT_PARAMETERS
		redefine
			initialize,
			process_next_arg
		end

create
	make

feature {NONE} -- Creation

	initialize
		do
			Precursor
			create args.make (0)
		end

	process_next_arg (arr: ARRAY [READABLE_STRING_GENERAL]; cl_index: CELL [INTEGER])
		local
			i: INTEGER
			v: READABLE_STRING_GENERAL
		do
			i := cl_index.item
			if ecf_path /= Void then
				add_argument (arr[i])
			else
				v := arr [i]
				if v.same_string ("-b") or v.same_string ("--build") then
					is_build_forced := True
					cl_index.replace (i + 1)
				elseif v.ends_with (".ecf") then
					set_ecf_path (v)
					cl_index.replace (i + 1)
				else
					Precursor (arr, cl_index)
				end
			end
		end

feature -- Access

	is_build_forced: BOOLEAN

	ecf_path: detachable PATH

	args: ARRAYED_LIST [READABLE_STRING_GENERAL]

feature -- Element change

	set_ecf_path (v: READABLE_STRING_GENERAL)
		do
			ecf_path := (create {PATH}.make_from_string (v)).absolute_path.canonical_path
		end

	add_argument (arg: READABLE_STRING_GENERAL)
		do
			args.force (arg)
		end

end
