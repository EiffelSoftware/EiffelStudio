class DEBUG_CONTEXT

inherit
	FORMAT_FEAT_CONTEXT
		redefine
			put_breakable, emit_tabs,
			execute
		end

creation

	make

feature -- Execution

	execute (a_target_feat: E_FEATURE) is
			-- Format feature_as and make all items
			-- clickable with class `c' as context
		do
			e_feature := a_target_feat;
			{FORMAT_FEAT_CONTEXT} Precursor (a_target_feat)
		end;

feature {NONE}

	e_feature: E_FEATURE;

	breakpoint_index: INTEGER;
			-- Breakpoint index in feature

	added_breakpoint: BOOLEAN
			-- Was a break point added?

	put_breakable is
		local
			bp: BREAKPOINT_ITEM
		do
			breakpoint_index := breakpoint_index + 1;
			!! bp.make (e_feature, breakpoint_index);
			added_breakpoint := True;
			text.add (bp)
		end;

	emit_tabs is
		do
			if added_breakpoint then
				added_breakpoint := false;
			else
				text.add (ti_padded_debug_mark)
			end;
			{FORMAT_FEAT_CONTEXT} Precursor;
		end;

end	 -- class DEBUG_CONTEXT
