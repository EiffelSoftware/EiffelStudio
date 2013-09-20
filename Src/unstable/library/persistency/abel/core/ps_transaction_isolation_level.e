note
	description: "Enumeration class for transaction isolation levels, as defined in ANSI/ISO SQL Standard (SQL92)."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	PS_TRANSACTION_ISOLATION_LEVEL

inherit

	COMPARABLE

feature -- Isolation levels

	Read_uncommitted: PS_TRANSACTION_ISOLATION_LEVEL
			-- The READ UNCOMMITED isolation level.
		once
			create Result
		end

	Read_committed: PS_TRANSACTION_ISOLATION_LEVEL
			-- The READ COMMITED isolation level.
		once
			create Result
		end

	Repeatable_read: PS_TRANSACTION_ISOLATION_LEVEL
			-- The REPEATABLE READ isolation level.
		once
			create Result
		end

	Serializable: PS_TRANSACTION_ISOLATION_LEVEL
			-- The SERIALIZABLE isolation level.
		once
			create Result
		end

feature -- Comparison operation

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is `Current' a weaker isolation level than `other'?
		local
			valid_levels: LINKED_LIST [PS_TRANSACTION_ISOLATION_LEVEL]
		do
			create valid_levels.make
			valid_levels.extend (Serializable)
			if Current = Repeatable_read and valid_levels.has (other) then
				Result := True
			else
				valid_levels.extend (Repeatable_read)
				if Current = Read_committed and valid_levels.has (other) then
					Result := True
				else
					valid_levels.extend (Read_committed)
					if Current = Read_uncommitted and valid_levels.has (other) then
						Result := True
					else
						Result := False
					end
				end
			end
		end

end
