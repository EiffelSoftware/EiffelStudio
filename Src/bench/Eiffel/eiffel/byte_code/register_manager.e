-- Manages register allocation for a given C type

class REGISTER_MANAGER

create

	make

feature

	make (b: BOOLEAN) is
			-- `b' is false if creation comes from `duplicate'
		do
			if b then
				init;
			end;
		end;

	init is
			-- Initialize array
		do
			create registers.make (1, 10);
		end;

	registers: ARRAY [BOOLEAN];
			-- Registers already used for a given C type (corresponding
			-- item is true if register is currently used, false otherwise).


	set_registers (r: like registers) is
			-- Assign `r' to `registers'
		do
			registers := r;
		end;

	needed_registers: INTEGER;
			-- Maximum register number used


	set_needed_registers (n: INTEGER) is
			-- Assign `n' to `needed_registers'
		do
			needed_registers := n;
		end;

	duplicate: like Current is
			-- Duplicate of current instance
		do
			create Result.make (false);
			Result.set_registers (clone (registers))
			Result.set_needed_registers (needed_registers);
		end;

	clear_all is
			-- Reset data structure
		do
			registers.clear_all;
			needed_registers := 0;
		end;

	get_register: INTEGER is
			-- First available register number
		local
			count: INTEGER;
		do
			from
				Result := 1;
				count := registers.count;
			until
				Result > count or not registers.item (Result)
			loop
				Result := Result + 1;
			end;
				-- May not have been found yet, hence the use of `force'
			registers.force (true, Result);
			if Result > needed_registers then
				needed_registers := Result;
			end;
		ensure
			register_used: registers.item (Result);
			max_updated: Result <= needed_registers;
		end;

	free_register (n: INTEGER) is
			-- Free register number `n'
		require
			register_used: registers.item (n);
		do
			registers.put (false, n);
		end;

end
