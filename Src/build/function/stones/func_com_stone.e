
class FUNC_COM_STONE 

inherit

	COM_INST_IS
		rename
			set_original_stone as old_set_original_stone
		end;

	COM_INST_IS
		redefine
			set_original_stone
		select
			set_original_stone
		end;

	FUNC_DROPPED_STONE
		
creation

	make

	
feature {NONE}

	associated_editor: BEHAVIOR_EDITOR;

	
feature 

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
			original_stone := Void
		end;

	
feature 

	set_original_stone (s: like original_stone) is
		do
			update_stone (s)
		end;

end
