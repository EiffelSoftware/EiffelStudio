
class TRAN_NAME 

inherit

	STRING
		rename 
			make as string_create
		end

creation

	make
	
feature -- Creation

	make (n: INTEGER) is
			-- Create a label_name allocating for at least n charactres.
		do
			string_create (n)
		end;

feature

	label_name: STRING; 
			-- label name of Current

	destination_name: STRING; 
			-- destination name of Current

	set_label_name (s: STRING) is
			-- Set label_name to `s'
		require
			not (s = Void)
		do
			label_name := s;
		end;

	set_destination_name (s: STRING) is
			-- Set destination_name to `s'
		require
			not (s = Void)
		do
			destination_name := s;
		end;

	update is
			-- Update the name of the transition
		do
			clear;	
			append (label_name);
			append (" -> ");
			append (destination_name);
		end;

end
