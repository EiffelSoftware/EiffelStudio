
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
		local
			bt: BAR_AND_TEXT
		do
			if
				ed.realized
			then
				bt ?= ed;
				if
					not ed.shown
				then
--					if bt /= Void then
--						bt.set_default_size;
--						bt.show;
--						bt.set_default_position;
--					else
						ed.show;
--					end;
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

	raise_class_windows is
		do
			class_win_mgr.raise_editors
		end;

	raise_explain_windows is
		do
			explain_win_mgr.raise_editors
		end;

	raise_object_windows is
		do
			object_win_mgr.raise_editors
		end;

	raise_routine_windows is
		do
			routine_win_mgr.raise_editors
		end;

	class_windows_count: INTEGER is
		do
			Result := class_win_mgr.count
		end;	

	routine_windows_count: INTEGER is
		do
			Result := routine_win_mgr.count
		end;	

	object_windows_count: INTEGER is
		do
			Result := object_win_mgr.count
		end;	

	explain_windows_count: INTEGER is
		do
			Result := explain_win_mgr.count
		end;	

end 
