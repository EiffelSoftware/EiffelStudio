indexing
	description: "Generate unique names"
	date: "$Date$"
	revision: "$Revision$"

class
	NAME_SOLVER

inherit
	NAME_FORMATTER

feature -- Access

	unique_feature_name (name: STRING): STRING is
			-- Unique feature name for .NET method `name'
		require
			non_void_name: name /= Void
			valid_name: not name.is_empty
		local
			count: INTEGER
			l_names: like reserved_names
		do
			count := 2
			l_names := reserved_names
			from
				Result := formatted_feature_name (name)
			until
				not l_names.has (Result)
			loop
				trim_end_digits (Result)
				Result.append (count.out)
				count := count + 1
			end
			l_names.put (Result, Result)
		end

	reserved_names: HASH_TABLE [STRING, STRING]
			-- Reserved names for overload solving

feature {TYPE_CONSUMER} -- Element Settings

	set_reserved_names (names: like reserved_names) is
			-- Set `reserved_names' with `names' .
		require
			non_void_names: names /= Void
			not_set_yet: reserved_names = Void
		do
			reserved_names := names
		ensure
			set: reserved_names = names
		end

end -- class NAME_SOLVER
