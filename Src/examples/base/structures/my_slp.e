-- Demo class for SLP_QUEUE
-- Only one feature added: display

class MY_SLP 

inherit
	LINKED_PRIORITY_QUEUE [INTEGER]
		rename
			make as lpq_make
		end

creation
	make

feature

	make is
		do
			io.set_error_default;
			lpq_make;
		end;

	display is
		do
			from
				start
			until
				offright
			loop
				io.putint (sorted_list_item.item);
				io.putstring (" ");
				forth
			end;
		end;

end -- class MY_SLP
