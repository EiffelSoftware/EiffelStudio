
class POPUPER 
	
feature 

	Messages: MESSAGE_CONSTANTS is
		do
			!! Result;
		end;

	continue_after_popdown (box: MESSAGE_D; ok: BOOLEAN) is
			-- Perform necessary action after `box' has popdown
			-- according to `ok' (indicates whether ok button
			-- was pressed). (By default do nothing). 
		do
		end; 

end
