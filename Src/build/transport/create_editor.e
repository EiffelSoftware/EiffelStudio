
class CREATE_EDITOR 

inherit

	COMMAND;

feature {NONE}

	execute (argument: ANY) is
		local
			ds: DRAG_SOURCE;
			ed: EDITABLE
		do
			ds ?= argument;
			ed ?= ds.stone.data;
			if ed /= Void then
				ed.create_editor
			end;
		end;

end
