class DEBUG_CONTEXT

inherit

	FORMAT_FEAT_CONTEXT
		rename
			emit_tabs as old_emit_tabs
		redefine
			put_breakable
		end
	FORMAT_FEAT_CONTEXT
		redefine
			put_breakable, emit_tabs
		select
			emit_tabs
		end

creation

	make

feature {NONE}

	added_breakpoint: BOOLEAN
			-- Was a break point added?

	put_breakable is
		do
			added_breakpoint := True;
			text.add (ti_Breakpoint)
		end;

	emit_tabs is
		do
			if added_breakpoint then
				added_breakpoint := false;
			else
				text.add (ti_padded_debug_mark)
			end;
			old_emit_tabs;
		end;

end	 -- class DEBUG_CONTEXT
