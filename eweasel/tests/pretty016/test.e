class
	TEST

create
	make

feature

	make
		local
			b: BOOLEAN
		do
			check
				b
			then
				do_nothing
			end
			check a: b then do_nothing end
			check b b then do_nothing end
			check b -- New line is required.
			then do_nothing end
			check
			-- New line is required.
			b then do_nothing end
			check then do_nothing end
			check a: then do_nothing end
			check a: -- New line is required.
			then do_nothing end
		end

end
