indexing
	description	: "Facilities to handle breakpoints adding in flat/short formats"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class DEBUG_CONTEXT

inherit
	FORMAT_FEAT_CONTEXT
		redefine
			put_breakable, 
			emit_tabs,
			execute
		end

creation
	make

feature -- Execution

	execute (a_target_feat: E_FEATURE) is
			-- Format feature_as and make all items
			-- clickable with class `c' as context
		local
			retried: BOOLEAN
		do
			if not retried then
				e_feature := a_target_feat
				{FORMAT_FEAT_CONTEXT} Precursor (a_target_feat)
			else
				create text.make
				text.add_string ("No text could be generated.")
				text.add_new_line
				text.add_string ("Please make sure the system is correctly compiled.")
			end
		rescue
			retried := True
			retry
		end

feature {NONE}

	e_feature: E_FEATURE
			-- current e_feature of the context.

	breakpoint_index: INTEGER
			-- Breakpoint index in feature

	added_breakpoint: BOOLEAN
			-- Was a break point added?

	put_breakable is
			-- Create a breakable mark.
		local
			bp: BREAKPOINT_ITEM
		do
			breakpoint_index := breakpoint_index + 1
			if e_feature /= Void and then e_feature.is_debuggable then
				create bp.make (e_feature, breakpoint_index)
				added_breakpoint := True
				text.add (bp)
			end
		end

	emit_tabs is
			-- Add the good number of tabulations to the text.
		do
			if added_breakpoint then
				added_breakpoint := false
			else
				text.add (ti_padded_debug_mark)
			end
			{FORMAT_FEAT_CONTEXT} Precursor
		end

end	 -- class DEBUG_CONTEXT
