
deferred class FUNC_DROPPED_STONE 

inherit

	REMOVABLE
	
feature {NONE}

	associated_editor: FUNC_EDITOR is
		deferred
		end;

	hide is
		deferred
		end;

	show is
		deferred
		end;

	realized: BOOLEAN is
		deferred
		end;

	shown: BOOLEAN is
		deferred
		end;

	dropped_stone: ICON_STONE is
		deferred
		end;
	
	unmanage is
		deferred
		end;

	manage is
		deferred
		end;

feature 

	reset is
		do
			if realized and then shown then
				hide
			end;
			if not (dropped_stone = Void) then
				associated_editor.reset_stone (dropped_stone);
				forget_stone
			end
		end;

	remove_yourself is
		do
			reset
		end;

	
feature {NONE}

	forget_stone is
		deferred
		end;

	original_stone: STONE is
		deferred
		end;

	update_stone (s: like original_stone) is
		do
			old_set_original_stone (s);
			if realized then
				show;
			end;
		end;

	old_set_original_stone (s: like original_stone) is
		deferred
		end

end
