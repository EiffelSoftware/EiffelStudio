indexing

	description: 
		"Object that calls the warning window. Then the warning windows%
		%calls Current to perform actions related to which button is pushed.";
	date: "$Date$";
	revision: "$Revision $"

deferred class WARNING_CALLER

feature {WARNING_WINDOW} -- Implementation

	ok_action is
			-- Action executed when control is satisfying
		deferred
		end; -- ok_action

	cancel_action is
			-- Action executed when control isn't satisfying
		deferred
		end -- cancel_action

	help_action is
			-- Action execute when help button is pressed
		do
		end;

end -- class WARNING_CALLER
