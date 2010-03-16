note
	description: "[
					Run the Eiffel compiler in the test directory $TEST with the
					Ecf file specified by the last `ace' instruction.  Since the
					Ecf file is always assumed to be in the test directory, it
					must have previously been copied into this directory.

					Compile_melted does not request freezing of the system

					The optional <output-file-name> specifies
					the name of the file in the output directory $OUTPUT into
					which output from this compilation will be written, so that it
					can potentially be compared with a known correct output file.
					If <output-file-name> is omitted, compilation results are
					written to a file with an unadvertised but obvious name (which
					could possibly change) in the output directory.

					For old version, pleaase check {EW_COMPILE_MELTED_INST}
																					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"
	date: "$Date$"
	revision: "$Revision$"

class
	EQA_EW_COMPILE_MELTED_INST

inherit
	EQA_EW_START_COMPILE_INST

create
	make

feature {NONE} -- Implementation

	compilation_options: LIST [STRING]
			-- <Precursor>
		once
			create {ARRAYED_LIST [STRING]} Result.make (1)
			Result.extend ("-verbose")
			Result.extend ("-melt")
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
