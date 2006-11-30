
-- To reproduce:
-- 1. Compile with classes as is, using "ec -config test.ecf".
-- 2. Change `TEST1 [DOUBLE]' to just `TEST1' in this class.
--    Remove formal generic from TEST1 and comment out `value', `val'
--    and `precursor' call in TEST1.
-- 3. Compile with "ec -config test.ecf".  Dies while freezing system.

class TEST
 
create
	make
 
feature
 
	make (args: ARRAY [STRING]) is
		local
			y: TEST1
		do
			y := (agent x).item ([])
		end

	x: TEST1
end
