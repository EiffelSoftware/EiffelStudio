note

	description:

		"Represents rules from the config file"

	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_CONFIG_RULE

create

	make

feature {NONE}

	make (a_matching_clause: EWG_CONFIG_MATCHING_CLAUSE; a_wrapper_clause: EWG_CONFIG_WRAPPER_CLAUSE) 
		require
			a_matching_clause_not_void: a_matching_clause /= Void
			a_wrapper_clause_not_void: a_wrapper_clause /= Void
		do
			matching_clause := a_matching_clause
			wrapper_clause := a_wrapper_clause
		ensure
			matching_clause_set: matching_clause = a_matching_clause
			wrapper_clause_set: wrapper_clause = a_wrapper_clause
		end

feature

	matching_clause: EWG_CONFIG_MATCHING_CLAUSE

	wrapper_clause: EWG_CONFIG_WRAPPER_CLAUSE

invariant

	matching_clause_not_void: matching_clause /= Void

	wrapper_clause_not_void: wrapper_clause /= Void

end




