indexing
	description: "Summary description for {ITP_VARIABLE_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ITP_VARIABLE_CONSTANTS

feature -- Access

	variable_name_prefix: STRING is "v_"
			-- Prefix for variables

	variable_index (a_name: STRING; a_prefix: STRING): INTEGER is
			-- Variable index from `a_name', assuming that `a_name' has the following format:
			-- `a_prefix'index. For example, if `a_prefix' is "v_", then "v_1" will be a valid name,
			-- and "1" will be the returned index.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_prefix_attached: a_prefix /= Void
			not_a_prefix_is_empty: not a_prefix.is_empty
			a_prefix_valid: a_name.count > a_prefix.count
			a_name_valid: a_name.substring (a_prefix.count + 1, a_name.count).is_integer
		do
			Result := a_name.substring (a_prefix.count + 1, a_name.count).to_integer
		ensure
			result_positive: Result > 0
		end

end
