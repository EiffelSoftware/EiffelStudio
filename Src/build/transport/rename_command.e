class RENAME_COMMAND

inherit

	COMMAND
	WINDOWS
	
feature 

	namer_window: NAMER_WINDOW is
		once
			!! Result.make (Eb_screen)
		end;

	execute (arg: ANY) is
		local
			stone: STONE;
			namable: NAMABLE
		do
			stone ?= arg;
			if stone /= Void then
				namable ?= stone.data;
				if namable /= Void then
					namer_window.popup_with (namable)
				end
			end
		end

end 
