indexing
	description : "Shared access to executing CLR version"
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	SHARED_CLR_VERSION

feature -- Access

	clr_version: STRING is
			-- Executing version of CLR, for use with consumer folder.
		local
			l_ver: VERSION
		once	
			l_ver := {ENVIRONMENT}.version
			create Result.make (10)
			Result.append_character ('v')
			Result.append_integer (l_ver.major)
			Result.append_character ('.')
			Result.append_integer (l_ver.minor)
			Result.append_character ('.')
			Result.append_integer (l_ver.build)
		ensure
			result_not_void: Result /= Void
			not_reuslt_is_empty: not Result.is_empty
			result_has_initial_v: Result.item (1) = 'v' -- This holds true for al f/w to date
		end

end -- class SHARED_CLR_VERSION
