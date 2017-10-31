note
	description: "Summary description for {EIFFEL_SCRIPT_BUILD_PARAMETERS}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SCRIPT_BUILD_PARAMETERS

inherit
	EIFFEL_SCRIPT_PARAMETERS
		redefine
			process_next_arg
		end

create
	make

feature {NONE} -- Creation

	process_next_arg (arr: ARRAY [READABLE_STRING_GENERAL]; cl_index: CELL [INTEGER])
		local
			i: INTEGER
			v: READABLE_STRING_GENERAL
		do
			i := cl_index.item
			v := arr [i]
			if ecf_location /= Void then
				set_executable_path (v)
				cl_index.replace (i + 1)
			elseif v.ends_with (".ecf") then
				set_ecf_location (v)
				cl_index.replace (i + 1)
			elseif v.same_string ("--target") then
				set_ecf_target (arr [i + 1])
				cl_index.replace (i + 2)
			else
				Precursor (arr, cl_index)
			end
		end

feature -- Access

	ecf_location: detachable IMMUTABLE_STRING_32

	ecf_target: detachable IMMUTABLE_STRING_32

	executable_path: detachable PATH

feature -- Element change

	set_ecf_location (v: READABLE_STRING_GENERAL)
		do
			create ecf_location.make_from_string_general (v)
		end

	set_ecf_target (v: READABLE_STRING_GENERAL)
		do
			create ecf_target.make_from_string_general (v)
		end

	set_executable_path (v: READABLE_STRING_GENERAL)
		do
			executable_path := (create {PATH}.make_from_string (v)).absolute_path.canonical_path
		end

end
