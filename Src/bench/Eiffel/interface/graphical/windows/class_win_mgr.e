
class CLASS_WIN_MGR 

inherit

	EDITOR_MGR
		redefine
			editor_type
		end

creation

	make

feature {NONE}

	editor_type: CLASS_W;

feature

	raise_shell_popup is
			-- Raise the shell command popup window if it is popped up.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.raise_shell_popup;
				active_editors.forth
			end
		end;

end 
