class ITER_COMMAND

inherit

	COMMAND
		export
			{NONE} all
		end;

	WINDOWS
		export
			{NONE} all
		end;

feature

	execute (argument: ANY) is
		do
			iterate;
		end;

end
