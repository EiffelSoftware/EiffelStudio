class POPUP_COMMAND

inherit

	COMMAND

feature

	execute (argument: MSG_WINDOW) is
		do
			argument.popup
		end

end
