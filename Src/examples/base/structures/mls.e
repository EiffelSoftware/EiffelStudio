-- Demo class for linked sets.
-- Only one routine to display the set is added
-- The generic parameter is INTEGER

class MLS

inherit
	LINKED_SET [INTEGER] 

creation
	make

feature

	display is
		do
			io.set_error_default;
			from
				start
			until
				exhausted
			loop
				io.putchar (' ');
				io.putint (item);
				forth
			end;
			io.putchar ('%N');
		end

end -- class MLS
