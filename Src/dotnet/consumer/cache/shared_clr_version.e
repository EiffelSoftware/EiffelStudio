indexing
	description : "Shared access to executing CLR version"
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	SHARED_CLR_VERSION

feature -- Access

	clr_version: STRING is
			-- Executing version of CLR
		local
			l_type: SYSTEM_TYPE
			l_loc: STRING
			l_sep: INTEGER
		once
			l_type := {SYSTEM_OBJECT}
			check
				("mscorlib").is_equal (l_type.assembly.get_name.name)
			end
			
				-- Get framework folder name
			l_loc := l_type.assembly.location
			l_loc.keep_head (l_loc.count - 13)
			l_sep := l_loc.last_index_of ((create {OPERATING_ENVIRONMENT}).directory_separator, l_loc.count)
			l_loc.keep_tail (l_loc.count - l_sep)
			
			Result := l_loc
		ensure
			result_not_void: Result /= Void
			not_reuslt_is_empty: not Result.is_empty
			result_has_initial_v: Result.item (1) = 'v' -- This holds true for al f/w to date
		end

end -- class SHARED_CLR_VERSION
