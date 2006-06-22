indexing
	description: "Some common utility functions used by the consumer and the compiler."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CONSUMER_UTILITIES

feature -- Formatting

	format_path (a_path: STRING): STRING is
			-- Formats `a_path' to produce a comparable path.
		require
			a_path_not_void: a_path /= Void
			not_path_is_empty: not a_path.is_empty
		local
			l_unc_path: BOOLEAN
		do
			l_unc_path := a_path.count > 2 and then a_path.substring (1, 2).is_equal ("\\")
			Result := a_path.as_lower
			Result.replace_substring_all ("\\", "\")
			if l_unc_path then
				Result.prepend_character ('\')
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_still_unc_path: a_path.count > 2 implies (a_path.substring (1, 2).is_equal ("\\") implies Result.substring (1, 2).is_equal ("\\"))
		end
end
