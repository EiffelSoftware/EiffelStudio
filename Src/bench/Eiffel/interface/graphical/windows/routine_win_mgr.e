
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
			rout_text: ROUTINE_TEXT;
			rout_window: ROUTINE_W
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				rout_window := active_editors.item;
				rout_text := rout_window.text_window;
				if 
					rout_text.root_stone /= Void and then
					rout_text.root_stone.feature_i /= Void and then
					rout_text.root_stone.feature_i.body_id = routine.body_id
				then
					if rout_text.in_debug_format then
						rout_text.redisplay_breakable_mark (index)
					elseif 
						rout_text.last_format = rout_window.showtext_command 
					then
							-- Update the title bar of the feature tool.
							-- "(stop)" if the routine has a stop point set.
						rout_window.showtext_command.display_header 
													(rout_text.root_stone)
					end
				end;
				active_editors.forth
			end
		end;

end 
