note
	description: "[
		The current transaction isolation settings.
		
		ABEL doesn't let you set a transaction level yourself.
		This is because the only official standard for transaction
		isolation levels is the SQL standard - however many databases
		don't support it, some introduce additional levels, and 
		some support snapshot isolation which maps poorly to the
		SQL standard.
		 
		Instead of defining an SQL isolation level you can describe
		which anomalies are acceptable. ABEL will then choose a 
		suitable transaction isolation level for you.
		
		Note: Individual backends may prevent certain anomalies
		which are declared as allowed (i.e. choose  a stronger 
		isolation level), but not the other way round.
		]"
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

frozen class
	PS_TRANSACTION_SETTINGS

feature -- Status report

	is_dirty_read_allowed: BOOLEAN
			-- Is a dirty read allowed?
			-- Dirty Read:

			--	write (x, 42)	|
			--					| read (x) -> 42
			--	abort			|
			--					| commit


	is_lost_update_allowed: BOOLEAN
			-- Is a lost update allowed?
			-- Lost Update:

			--	read (x) -> a	|
			--					| read (x) -> b
			--	a := a + 3		|
			--					| b := b + 5
			--  write (x, a)	|
			-- 	commit			|
			--					| write (x, b)
			--					| commit


	is_fuzzy_read_allowed: BOOLEAN
			-- Is a fuzzy (non-repeatable) read allowed?
			-- Fuzzy Read:

			--	read (x) -> 42	|
			-- 					| write (x, 43)
			--					| commit
			--	read (x) -> 43	|
			--	commit			|


	is_phantom_allowed: BOOLEAN
			-- Is a phantom read allowed?
			-- Phantom Read:

			--	read_if (P > 0) -> count = 10	|
			--									| write (x)
			--									| commit
			--	read_if (P > 0) -> count = 11	|
			--	commit							|


	is_read_skew_allowed: BOOLEAN
			-- Is a read skew allowed?
			-- Read skew:
			-- Assume invariant x = y

			--	read (x) -> 42	|
			--					| write (x, 43)
			--					| write (y, 43)
			--					| commit
			--	read (y) -> 43	|
			--	commit			|


	is_write_skew_allowed: BOOLEAN
			-- Is a write skew allowed?
			-- Write skew:
			-- Assume invariant x + y > 0

			--	read (x) -> 20	|
			--	read (y) -> 20	|
			--					| read (x) -> 20
			--					| read (x) -> 20
			--	write (x, 0)	|
			--					| write (y, 0)
			--	commit			|
			--					| commit

feature {PS_ABEL_EXPORT} -- Element change

	set_is_dirty_read_allowed (value: BOOLEAN)
			-- Set `is_dirty_read_allowed' to `value'.
		do
			is_dirty_read_allowed := value
		ensure
			correct: is_dirty_read_allowed = value
		end


	set_is_lost_update_allowed (value: BOOLEAN)
			-- Set `is_lost_update_allowed' to `value'.
		do
			is_lost_update_allowed := value
		ensure
			correct: is_lost_update_allowed = value
		end


	set_is_fuzzy_read_allowed (value: BOOLEAN)
			-- Set `is_fuzzy_read_allowed' to `value'.
		do
			is_fuzzy_read_allowed := value
		ensure
			correct: is_fuzzy_read_allowed = value
		end

	set_is_phantom_allowed (value: BOOLEAN)
			-- Set `is_phantom_allowed' to `value'.
		do
			is_phantom_allowed := value
		ensure
			correct: is_phantom_allowed = value
		end

	set_is_read_skew_allowed (value: BOOLEAN)
			-- Set `is_read_skew_allowed' to `value'.
		do
			is_read_skew_allowed := value
		ensure
			correct: is_read_skew_allowed = value
		end

	set_is_write_skew_allowed (value: BOOLEAN)
			-- Set `is_write_skew_allowed' to `value'.
		do
			is_write_skew_allowed := value
		ensure
			correct: is_write_skew_allowed = value
		end

end
