note
	description: "Runs all the test units"
	author: "JSO"
	date: "Jan 4, 2005"
	revision: "1.0"

class
	DICTIONARY_ALL_TESTS
inherit
	ES_SUITE

create
	make

feature {NONE} -- Initialization

	make
			-- Run unit tests
		do
			add_test (create{DICTIONARY_TESTS_BASIC}.make)
			add_test (create{DICTIONARY_TESTS_QUANTIFIERS}.make)
			add_test (create{DICTIONARY_TESTS_YOURS}.make)
			add_test (create{DICTIONARY_TESTS_EXTRA}.make)
			show_browser
			show_errors
			run_espec

		end

end -- class DICTIONARY_ALL_TESTS
