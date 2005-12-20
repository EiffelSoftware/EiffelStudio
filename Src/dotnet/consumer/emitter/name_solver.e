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
			Result := formatted_feature_name (name)
			if not ub_operator_names.has (name) then
					-- If execution ends up here then we are not dealing with
					-- infix/prefix operators. Infix and prefixes need not be solved, unless an
					-- infix/prefix is overloaded. In that case, execution will end up here.
				from
				until
					not l_names.has (Result)
				loop
					trim_end_digits (Result)
					Result.append (count.out)
					count := count + 1
				end
			end
			l_names.put (Result, Result)
		end

	reserved_names: HASH_TABLE [STRING, STRING]
			-- Reserved names for overload solving

	ub_operator_names: HASH_TABLE [STRING, STRING] is
			-- Operator names for mapping prefixes and infixes.
			-- Information in this table should also correspond
		local
			l_unary: HASH_TABLE [STRING, STRING]
			l_binary: HASH_TABLE [STRING, STRING]
		once
			create Result.make (13)
			l_unary := unary_operators
			l_binary := binary_operators

			from
				l_unary.start
			until
				l_unary.after
			loop
				from
					l_binary.start
				until
					l_binary.after
				loop
					if l_unary.item_for_iteration.is_equal (l_binary.item_for_iteration) then
						Result.put (l_unary.key_for_iteration, l_binary.key_for_iteration)
						Result.put (l_binary.key_for_iteration, l_unary.key_for_iteration)
					end
					l_binary.forth
				end
				l_unary.forth
			end
		ensure
			result_attached: Result /= Void
		end

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
