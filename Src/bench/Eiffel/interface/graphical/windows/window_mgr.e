
class WINDOW_MGR 

creation

	make
	
feature {NONE}

	routine_win_mgr: ROUTINE_WIN_MGR;
		-- Manager for routine windows 

	class_win_mgr: CLASS_WIN_MGR;
		-- Manager for class windows

	object_win_mgr: OBJECT_WIN_MGR;
		-- Manager for object windows

	explain_win_mgr: EXPLAIN_WIN_MGR;
		-- Manager for explain windows
	
feature 

	make (a_screen: SCREEN; i: INTEGER) is
			-- Make a window manager. All editors will be create 
			-- using `a_screen' as the parent. Allow `i' amount for
			-- the free list.
		do
			!!routine_win_mgr.make (a_screen, i);
			!!class_win_mgr.make (a_screen, i);
			!!object_win_mgr.make (a_screen, i);
			!!explain_win_mgr.make (a_screen, i);
		end;

	routine_window: ROUTINE_W is
			-- Make a routine window 
		do
			Result := routine_win_mgr.editor
		end;

	class_window: CLASS_W is
			-- Make a class window 
		do
			Result := class_win_mgr.editor
		end;

	object_window: OBJECT_W is
			-- Make an object window
		do
			Result := object_win_mgr.editor
		end;

	explain_window: EXPLAIN_W is
			-- Create a context editor
		do
			Result := explain_win_mgr.editor
		end;

	display (ed: TOOL_W) is
			-- Display `ed' (or raise `ed' if already
			-- displayed).
		do
			if
				ed.realized
			then
				if
					not ed.shown
				then
					ed.show
				else
					ed.raise
				end
			else
				ed.realize
			end		
		end;

	close (ed: TOOL_W) is
			-- Close `ed'. 
		local
			r_w: ROUTINE_W;
			c_w: CLASS_W;
			o_w: OBJECT_W;
			e_w: EXPLAIN_W
		do
			r_w ?= ed;
			c_w ?= ed;
			o_w ?= ed;
			e_w ?= ed;
			if r_w /= Void then
				routine_win_mgr.remove (r_w)
			elseif c_w /= Void then
				class_win_mgr.remove (c_w)
			elseif o_w /= Void then
				object_win_mgr.remove (o_w)
			elseif e_w /= Void then
				explain_win_mgr.remove (e_w)
			end
		end;

	hide_all_editors is
		do
			routine_win_mgr.hide_editors;
			class_win_mgr.hide_editors;
			object_win_mgr.hide_editors;
			explain_win_mgr.hide_editors;
		end;

	show_all_editors is
		do
			routine_win_mgr.show_editors;
			class_win_mgr.show_editors;
			object_win_mgr.show_editors;
			explain_win_mgr.show_editors;
		end

end 
