
class ROUTINE_WIN_MGR 

inherit

	SHARED_DEBUG;
	EDITOR_MGR
		redefine
			editor_type
		end

creation

	make

feature {NONE}

	editor_type: ROUTINE_W;

feature -- Debugging (stop points)

	show_stoppoint (routine: FEATURE_I; index: INTEGER) is
			-- Show the `index'-th breakable point of `routine' in
			-- routine tools containing the related routine and
			-- set with the `show_breakpoints' format.
		require
			routine_exists: routine /= Void
		local
			rout_text: ROUTINE_TEXT
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				rout_text := active_editors.item.text_window;
				if 
					rout_text.in_debug_format and then
					rout_text.root_stone /= Void and then
					rout_text.root_stone.feature_i /= Void and then
					rout_text.root_stone.feature_i.body_id = routine.body_id
				then
					rout_text.redisplay_breakable_mark (index)
				end;
				active_editors.forth
			end
		end;

end 
