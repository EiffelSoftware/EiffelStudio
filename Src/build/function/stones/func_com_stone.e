
class FUNC_COM_STONE 

inherit

	COM_INST_IS
		rename
			set_data as old_set_data
		end;

	COM_INST_IS
		redefine
			set_data
		select
			set_data
		end;

	FUNC_DROPPED_STONE
		
creation

	make

feature {NONE}

	associated_editor: BEHAVIOR_EDITOR;

	make (ed: like associated_editor) is
		do
			associated_editor := ed
		end;
	
feature {NONE}

	dropped_stone: like Current is
		do
			Result := Current
		end;

	forget_stone is
		do
			data := Void
		end;

	
feature 

	set_data (s: like data) is
		do
			update_stone (s)
		end;

end
