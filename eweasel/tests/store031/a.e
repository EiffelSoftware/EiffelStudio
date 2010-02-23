note
	$VERSION

class A

inherit
	MISMATCH_CORRECTOR
		redefine
			correct_mismatch
		end

create
	make

feature {NONE} -- Creation

	make
		do
			s := "NON_VOLATILE"
			i := 123123
		end

feature -- Mismatch

	correct_mismatch
		do
			if mismatch_information.is_version_mismatched then
				io.put_string ("Original version: ")
				io.put_string (mismatch_information.stored_version)
				io.put_new_line
				io.put_string ("Current version: ")
				io.put_string (mismatch_information.current_version)
				io.put_new_line
			end
			Precursor
		end

feature -- Access

	s: STRING
	i: INTEGER


end
