class MESSAGE_OK_COMMAND

inherit

	COMMAND

creation

	make

feature

	make is
		do
		end

	execute (arg: MESSAGE_D) is
		do
			arg.popdown
		end

end -- class MESSAGE_OK_COMMAND
