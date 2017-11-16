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
			check_level := check_level_class
		end

	process_next_arg (arr: ARRAY [READABLE_STRING_GENERAL]; cl_index: CELL [INTEGER])
		local
			i: INTEGER
			v: READABLE_STRING_GENERAL
		do
			i := cl_index.item
			if ecf_location /= Void then
				add_argument (arr[i])
			else
				v := arr [i]
				if v.same_string ("-b") or v.same_string ("--build") then
					is_build_forced := True
					cl_index.replace (i + 1)
				elseif v.ends_with (".ecf") then
					set_ecf_location (v)
					cl_index.replace (i + 1)
				elseif v.same_string ("--target") then
					set_ecf_target (arr [i + 1])
					cl_index.replace (i + 2)
				elseif v.same_string ("--check") then
					set_check_level (arr [i + 1])
					cl_index.replace (i + 2)
				else
					Precursor (arr, cl_index)
				end
			end
		end

feature -- Access

	is_build_forced: BOOLEAN

	check_level: NATURAL_8

	ecf_location: detachable IMMUTABLE_STRING_32

	ecf_target: detachable IMMUTABLE_STRING_32

	args: ARRAYED_LIST [READABLE_STRING_GENERAL]

feature -- Constants/check

	check_level_class: NATURAL_8 = 1
--	check_level_library: NATURAL_8 = 2
	check_level_project: NATURAL_8 = 0

feature -- Element change

	set_ecf_location (v: READABLE_STRING_GENERAL)
		do
			create ecf_location.make_from_string_general (v)
		end

	set_ecf_target (v: READABLE_STRING_GENERAL)
		do
			create ecf_target.make_from_string_general (v)
		end

	set_check_level (lev: READABLE_STRING_GENERAL)
		local
			l_check_level: INTEGER
		do
			if lev.same_string ("class") then
						-- Check system class (this is the default)
				check_level := check_level_class
			elseif lev.same_string ("project") then
					-- Check only project ecf file timestamp.
				check_level := check_level_project
--			elseif lev.same_string ("library") then
--					-- not supported for now, may be heavy.
--					-- note: it could be done reusing the compiler itself, and keeping the EIFGENs ...
--					-- Check all classes included in system (including from libraries)
--				check_level := check_level_library
			else
					-- Keep previous value (i.e default)
			end
		end

	add_argument (arg: READABLE_STRING_GENERAL)
		do
			args.force (arg)
		end

end
