indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DBG_EXCEPTION_HANDLER
	
inherit
	ANY
		redefine
			default_create
		end
		
feature -- Init

	default_create is
		do
			create exceptions_handling.make (3)
			exceptions_handling.extend ("-")
			exceptions_handling.extend ("+EiffelSoftware.Runtime.")
		end
		
feature -- Access

	ignoring_external_exception: BOOLEAN
	
	ignore_external_exceptions (v: BOOLEAN) is
			-- 
		do
			ignoring_external_exception := v
		end

	exceptions_handling: ARRAYED_LIST [STRING]
	
	ignore_exception (s: STRING) is
		local
			ls: STRING
		do
			exceptions_handling.prune_all ("+" + s)
			ls := "-" + s
			exceptions_handling.prune_all (ls)
			exceptions_handling.extend (ls)
		end

	catch_exception (s: STRING) is
		local
			ls: STRING
		do
			exceptions_handling.prune_all ("-" + s)
			ls := "+" + s
			exceptions_handling.prune_all (ls)
			exceptions_handling.extend (ls)
		end

feature {NONE} -- Implementation

	
	
end
