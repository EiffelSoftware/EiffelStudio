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

create
	make

feature -- Initialization

	make (a_screen: SCREEN) is
			-- Initialize Current.
		do
			precursor {EDITOR_MGR} (a_screen)
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

	show_stoppoint (body_index: INTEGER; index: INTEGER) is
			-- Resynchronize debugged routine window with feature `feat'.
			-- If `feat' is void resynchronize debugged routine window
			-- regardless.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.show_stoppoint(body_index,index)
				active_editors.forth
			end
		end

	synchronize_with_callstack is
			-- Display/Hide the arrow for all feature present in
			-- the callstack.
		do
			from
				active_editors.start
			until
				active_editors.after
			loop
				active_editors.item.synchronize_with_callstack
				active_editors.forth
			end
		end

feature {NONE} -- Properties

	editor_type: ROUTINE_W

	create_editor: ROUTINE_W is
			-- Create an object tool
		do
			create Result.make (screen)
		end

end -- class ROUTINE_WIN_MGR
