note
	description: "Summary description for {EIFFEL_SCRIPT_PARAMETERS}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SCRIPT_PARAMETERS

create
	make

feature {NONE} -- Creation

	make (arr: ARRAY [READABLE_STRING_GENERAL])
		local
			i,n: INTEGER
			v: READABLE_STRING_GENERAL
			cl: CELL [INTEGER]
		do
			initialize
			from
				i := arr.lower
				n := arr.upper
				create cl.put (0)
			until
				i > n
			loop
				cl.replace (i)
				process_next_arg (arr, cl)
				if i = cl.item then
					ignore_argument (arr [i])
					cl.replace (i + 1)
				else
						-- cl.item is already incremented.
				end
				i := cl.item
			end
		end

	initialize
		do
				--
		end

	process_next_arg (arr: ARRAY [READABLE_STRING_GENERAL]; cl_index: CELL [INTEGER])
		local
			v: READABLE_STRING_GENERAL
		do
			v := arr [cl_index.item]
			if v.same_string ("-v") or v.same_string ("--verbose") then
				is_verbose := True
				cl_index.replace (cl_index.item + 1)
			elseif v.same_string ("-h") or v.same_string ("--help") then
				is_help := True
				cl_index.replace (cl_index.item + 1)
			end
		end

feature -- Access

	is_verbose: BOOLEAN

	is_help: BOOLEAN

	has_error: BOOLEAN

feature -- Element change

	ignore_argument (v: READABLE_STRING_GENERAL)
		do

		end

	report_error (m: detachable READABLE_STRING_GENERAL)
		do
			has_error := True
		end

	set_is_verbose (b: BOOLEAN)
		do
			is_verbose := b
		end

end
