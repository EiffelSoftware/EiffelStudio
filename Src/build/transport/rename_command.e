class RENAME_COMMAND

inherit

	COMMAND

	WINDOWS
	
	SHARED_MODE
		rename
			current_mode as editing_or_executing_mode
		end

	MODE_CONSTANTS

feature 

	execute (arg: ANY) is
		local
			stone: STONE;
			namable: NAMABLE
		do
			if editing_or_executing_mode = Editing_mode then
				stone ?= arg;
				if stone /= Void then
					namable ?= stone.data;
					if namable /= Void and then namable.is_able_to_be_named then
						namer_window.popup_with (namable)
					end
				end
			end
		end

end 
