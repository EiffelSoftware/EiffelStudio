
class TEST 
create
	default_create, make

feature

	make
		local
			t: TEST
		do
			create    t
			create{TEST}t
			create        {TEST}           t
			t := create{TEST}
			t := create{TEST}  .  default_create
			create<	NONE	>t
			create	<	NONE	>	{TEST}	t
			t := create<NONE>{TEST}
			t := create<NONE>{TEST}  .  default_create
		end

end
