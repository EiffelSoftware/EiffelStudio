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

feature -- Debugging (stop points)

	show_stoppoint (routine: E_FEATURE; index: INTEGER) is
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
					rout_text.root_stone.e_feature /= Void and then
					equal (rout_text.root_stone.e_feature.body_id, routine.body_id)
				then
					if rout_text.in_debug_format then
						rout_text.redisplay_breakable_mark (index)
					elseif 
						rout_text.last_format = rout_window.showtext_frmt_holder 
					then
							-- Update the title bar of the feature tool.
							-- "(stop)" if the routine has a stop point set.
						rout_window.showtext_frmt_holder.associated_command.display_header 
													(rout_text.root_stone)
					end
				end;
				active_editors.forth
			end
		end;

feature {NONE} -- Properties

	editor_type: ROUTINE_W;

end -- class ROUTINE_WIN_MGR
