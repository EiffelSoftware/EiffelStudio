indexing

	description:	
		"Window manager for routine tools.";
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_WIN_MGR 

inherit

	EDITOR_MGR
		redefine
			editor_type
		end

creation

	make

feature -- Update

	resynchronize_debugger (feat: E_FEATURE) is
			-- Resynchronize debugged routine window with feature `feat'.
		require
			feat_non_void: feat /= Void
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.resynchronize_debugger (feat);
				active_editors.forth
			end
		end;

	show_stoppoint (routine: E_FEATURE; index: INTEGER) is
			-- Show the `index'-th breakable point of `routine' in
			-- routine tools containing the related routine and
			-- set with the `show_breakpoints' format.
		require
			routine_exists: routine /= Void
		local
			rout_window: ROUTINE_W
		do
			if index > 0 then
				from
					active_editors.start
				until
					active_editors.after
				loop
					active_editors.item.show_stoppoint (routine, index);
					active_editors.forth
				end
			end
		end;

feature {NONE} -- Properties

	editor_type: ROUTINE_W;

end -- class ROUTINE_WIN_MGR
