class REALIZE_COMMAND

inherit

	COMMAND

feature

	execute (argument: WINDOW2) is
		do
			argument.realize
		end

end
