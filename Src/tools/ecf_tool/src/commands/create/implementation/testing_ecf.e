note
	description: "Summary description for {TESTING_ECF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TESTING_ECF

inherit
	APPLICATION_ECF
		redefine
			make,
			process,
			set_is_console_application,
			set_executable_name,
			set_root_info
		end

create
	make

feature {NONE} -- Implementation

	make (a_name: STRING)
		do
			Precursor (a_name)
			is_console_application := False
			concurrency := "none"
			root_class := "ANY"
			root_feature := "default_create"
		end

feature -- Element change

	set_root_info (a_cluster: detachable STRING; a_class, a_feature: STRING)
		do
			--| always keep default root info for Testing
		end

	set_is_console_application (b: BOOLEAN)
		do
			is_console_application := False
		end

	set_executable_name (s: like executable_name)
		do
			-- Ignored
		end

feature -- Visitor

	process (v: ECF_VISITOR)
		do
			v.process_testing_ecf (Current)
		end

end
