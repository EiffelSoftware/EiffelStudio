
class TRAN_NAME 

inherit

	STRING_SCROLLABLE_ELEMENT
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

	cmd_label: CMD_LABEL; 
			-- Command label 

	destination_name: STRING; 
			-- destination name of Current

	set_cmd_label (l: like cmd_label) is
			-- Set label_name to `s'
		require
			valid_l: l /= Void
		do
			cmd_label := l;
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
			wipe_out;	
			append (cmd_label.label);
			append (" -> ");
			append (destination_name);
		end;

end
