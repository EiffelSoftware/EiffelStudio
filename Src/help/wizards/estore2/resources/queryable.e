indexing
	description: "Element which can return its feature's string values."
	author: "davids"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	QUERYABLE

feature -- creation

feature -- Implementation

feature -- Access

	get_feature_value (s: STRING):STRING is
			-- Get string value of feature whose name is 's'.
		require
			not_void: s /= Void
		deferred
		end

	get_feature_values (l: ARRAY [STRING]): ARRAY [STRING] is
			-- Get the values of features, whose name are the item of list
			-- 'l' and return an array with their corresponding string values.
		require
			not_void: l /= Void
		local
			i: INTEGER
		do
			create Result.make (1,l.count)
			from
				i := 1
			until
				i > l.count
			loop
				Result.put (get_feature_value (l.entry(i)), i)
				i := i+1
			end
		ensure
			not_void: Result /= Void
		end

	set_feature_value (attr, value: STRING) is
			-- Set to 'value' the value of the attribute 'attr' if it exists.
		require
			not_void: attr /= Void and then value /= Void
		deferred
		end

end -- class QUERYABLE 
