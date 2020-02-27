class
	TEST

create
	make

feature {NONE} -- Creation

	make
		local
			b: BOOLEAN
                do
			create values.make (19)
			values ["test"] := 3
			action := agent values.item
			b := g
                end

feature {NONE} -- Access

        action: FUNCTION [STRING, INTEGER]

        values: HASH_TABLE [INTEGER, STRING]

        g: BOOLEAN
                do
			Result := action ("test") /= 0
                end

end
