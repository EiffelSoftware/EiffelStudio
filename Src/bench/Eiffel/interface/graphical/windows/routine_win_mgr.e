indexing
	description: "Window manager for routine tools."
	date: "$Date$"
	revision: "$Revision$"

class ROUTINE_WIN_MGR 

inherit
	EDITOR_MGR
		redefine
			editor_type, make
		end

creation
	make

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Initialize Current.
		do
			{EDITOR_MGR} precursor (a_screen)
			Feature_resources.add_user (Current)
		end

feature -- Update

	resynchronize_debugger (feat: E_FEATURE) is
			-- Resynchronize debugged routine window with feature `feat'.
			-- If `feat' is void resynchronize debugged routine window
			-- regardless.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.resynchronize_debugger (feat)
				active_editors.forth
			end
		end

	show_stoppoint (routine: E_FEATURE index: INTEGER) is
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
					active_editors.item.show_stoppoint (routine, index)
					active_editors.forth
				end
			end
		end

feature {NONE} -- Properties

	editor_type: ROUTINE_W

	create_editor: ROUTINE_W is
			-- Create an object tool
		do
			!! Result.make (screen)
		end

end -- class ROUTINE_WIN_MGR
