class RENAME_COMMAND

inherit

	COMMAND
	WINDOWS
	
feature 

	execute (arg: ANY) is
		local
			stone: STONE;
			namable: NAMABLE
		do
			stone ?= arg;
			if stone /= Void then
				namable ?= stone.data;
				if namable /= Void and then namable.is_able_to_be_named then
					namer_window.popup_with (namable)
				end
			end
		end

end 
