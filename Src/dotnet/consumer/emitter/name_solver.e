indexing
	description: "Generate unique names"

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
			sb: SYSTEM_STRING
		do
			count := 2
			from
				Result := format_feature_name (name)
			until
				not reserved_names.has (Result)
			loop
				sb := Result.to_cil.trim_end (Digits)
				create Result.make_from_cil (sb)
				Result.append ("_")
				Result.append (count.out)
				count := count + 1
			end
			reserved_names.extend (Result)
		end

	reserved_names: LIST [STRING]
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

feature {NONE} -- Implementation

	Digits: NATIVE_ARRAY [CHARACTER] is
			-- Digits
		once
			Result := (<<'0','1','2','3','4','5','6','7','8','9','_'>>).to_cil
		end

end -- class NAME_SOLVER
