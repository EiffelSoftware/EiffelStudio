indexing
	description: "Summary description for {EWB_AUTO_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_AUTO_TEST

inherit
	EWB_CMD

feature -- Properties

	name: STRING is
		do
			Result := "AutoTest"
		end

	help_message: STRING_GENERAL is
		do
			Result := "AutoTest"
		end

	abbreviation: CHARACTER is
		do
			Result := 'e'
		end

feature -- Execution

	execute is
			-- Action performed when invoked from the
			-- command line.
		do
			io.put_string ("AutoTest is only available in graphical version of EiffelStudio.%N%N")
		end

end
