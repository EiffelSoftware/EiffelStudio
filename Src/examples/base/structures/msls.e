-- Demo class for sets implemented as sorted lists
-- Only one routine to display the set is added

class MSLS 

inherit
	SORTED_SET [INTEGER] 

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
				io.putint (item.item);
				forth
			end;
		end

end -- class MSLS
