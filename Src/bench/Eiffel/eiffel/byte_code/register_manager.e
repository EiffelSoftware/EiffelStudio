indexing
	description: "Manages register allocation for a given C type"
	date: "$Date$"
	revision: "$Revision$"

class REGISTER_MANAGER

create
	make,
	make_from_existing

feature {NONE} -- Initialization

	make is
			-- Initialize array
		do
			create registers.make (1, 10)
		end

	make_from_existing (other: like Current) is
			-- Duplicate `other' in Current
		require
			other_not_void: other /= Void
		do
			registers := other.registers.twin
			needed_registers := other.needed_registers
		ensure
			registers_set: registers.is_equal (other.registers)
			needed_registers_set: needed_registers = other.needed_registers
		end
		
feature -- Access

	registers: ARRAY [BOOLEAN]
			-- Registers already used for a given C type (corresponding
			-- item is True if register is currently used, False otherwise).

	needed_registers: INTEGER
			-- Maximum register number used

	get_register: INTEGER is
			-- First available register number
		local
			count: INTEGER
		do
			from
				Result := 1
				count := registers.count
			until
				Result > count or not registers.item (Result)
			loop
				Result := Result + 1
			end
				-- May not have been found yet, hence the use of `force'
			registers.force (True, Result)
			if Result > needed_registers then
				needed_registers := Result
			end
		ensure
			register_used: registers.item (Result)
			max_updated: Result <= needed_registers
		end

feature -- Duplication

	duplicate: like Current is
			-- Duplicate of current instance
		do
			create Result.make_from_existing (Current)
		end

feature -- Element change

	clear_all is
			-- Reset data structure
		do
			registers.clear_all
			needed_registers := 0
		end

	free_register (n: INTEGER) is
			-- Free register number `n'
		require
			register_used: registers.item (n)
		do
			registers.put (False, n)
		end

invariant
	registers_not_void: registers /= Void

end
