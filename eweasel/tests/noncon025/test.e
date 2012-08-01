
class TEST
		
inherit
	ANY

inherit {NONE}

	TEST2
		export
			{NONE} all
		end
create
	make

feature {NONE}

	make
		do
			match
		end

	match
		do
			match_internal
		end

	match_internal
		local
			b: BOOLEAN
		do
			b := is_valid (1)
		end

end
