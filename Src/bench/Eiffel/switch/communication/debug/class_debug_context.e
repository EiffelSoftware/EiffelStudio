indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_DEBUG_CONTEXT

inherit
	FORMAT_CONTEXT
		redefine
			put_breakable, 
			emit_tabs,
			init_feature_context,
			init_uncompiled_feature_context
		end

creation
	make, make_for_case

feature

	init_uncompiled_feature_context (source_class: CLASS_C; feature_as: FEATURE_AS) is
			-- Initialize Current context to analyze
			-- uncompiled feature ast `feature_as'.
			-- This ast is not in the feature table (ie has
			-- not been compiled) but has been entered by
			-- the user.
		do
			Precursor {FORMAT_CONTEXT} (source_class, feature_as)
			current_e_feature := Void
			breakpoint_index := 1
		end

	init_feature_context (source, target: FEATURE_I; 
				feature_as: FEATURE_AS) is
			-- Initialize Current context to analyze
			-- `source' and `target' features.
			-- Use `feature_as' to set up locals.
		do
			Precursor {FORMAT_CONTEXT} (source, target, feature_as)
			current_e_feature := source.api_feature (source.written_in)
			breakpoint_index := 1
		end

feature {NONE}

	current_e_feature: E_FEATURE
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
			create bp.make (current_e_feature, breakpoint_index)
			added_breakpoint := True
			text.add (bp)
			breakpoint_index := breakpoint_index + 1
		end

	emit_tabs is
			-- Add the good number of tabulations to the text.
		do
			if added_breakpoint then
				added_breakpoint := false
			else
				text.add (ti_padded_debug_mark)
			end
			{FORMAT_CONTEXT} Precursor
		end

end -- class CLASS_DEBUG_CONTEXT
