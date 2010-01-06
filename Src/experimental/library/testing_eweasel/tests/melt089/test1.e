
class TEST1
inherit
	TEST0
		redefine
			to_test2
		end
create
	default_create
feature
	to_test2: TEST2
		require else
			valid: True
		do
		end
		
end
