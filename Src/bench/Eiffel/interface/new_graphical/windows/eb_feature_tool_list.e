indexing
	description: "Manager for feature tools."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_TOOL_LIST

inherit
	EB_EDIT_TOOL_LIST [EB_FEATURE_TOOL]
		redefine
			make
		end

creation
	make

feature -- Initialization

	make is
			-- Initialize Current.
		do
			Precursor
		end

feature -- Update

	resynchronize_debugger (feat: E_FEATURE) is
			-- Resynchronize debugged routine window with feature `feat'.
			-- If `feat' is void resynchronize debugged routine window
			-- regardless.
		do
			from
				start
			until
				after
			loop
				item.resynchronize_debugger (feat)
				forth
			end
		end

	show_stoppoint (routine: E_FEATURE; i: INTEGER) is
			-- Show the `i'-th breakable point of `routine' in
			-- routine tools containing the related routine and
			-- set with the `show_breakpoints' format.
		require
			routine_exists: routine /= Void
		local
			rout_window: EB_FEATURE_TOOL
		do
			if index > 0 then
				from
					start
				until
					after
				loop
					item.show_stoppoint (routine, i)
					forth
				end
			end
		end

end -- class EB_FEATURE_TOOL_LIST
