class QUIT_SYSTEM 

inherit

	QUIT_FILE
		redefine 
			work, make
		end

creation

	make
	
feature 

	make (c: COMPOSITE; a_text_window: TEXT_WINDOW) is
		do
			init (c, a_text_window)
		end;


    set_quit_command (c: COMMAND; arg: ANY) is
        do
            quit_command := c;
            quit_argument := arg;
        end;


feature {NONE}

	work (argument: ANY) is
			-- Quit cautiously an ace file. Don't actually destroy the window.
		local
			com: COMMAND;
			arg: ANY;
		do
			com := quit_command;
			arg := quit_argument;
			if argument = warner then
				-- The user has been warned that he will lose his stuff
				text_window.tool.hide;
                if quit_command /= void then
					quit_command := void;
                    com.execute (arg);
                end;
			else
				-- First click on open
				if text_window.changed then
					warner.call (Current, l_File_changed)
				else
					text_window.clean;
					text_window.tool.hide;
               		if quit_command /= void then
						quit_command := void;
						com.execute (arg);
					end;
				end
			end
		end;


    quit_command: COMMAND;

    quit_argument: ANY;


end
