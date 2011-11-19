note
	description: "Run all tests for TRIE"
	author: "JSO"
	date: "$Jan 25, 2003$"
	revision: "$1.0.0$"

class
	ROOT_CLASS
inherit
	ES_SUITE

create
	make

feature {NONE} -- Initialization

	make
			-- Run unit tests
		do
			add_test (create{JSO_TEST}.make)
			add_test (create{VT_TEST}.make)
			show_browser
			run_espec
		end



end
