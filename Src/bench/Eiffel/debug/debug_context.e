class DEBUG_CONTEXT

inherit

	FORMAT_FEAT_CONTEXT
		redefine
			put_breakable, next_line
		end

creation

	make

feature {NONE}

	next_line is
			-- Go to next line and indent as necessary.
		local
			item: DEBUG_NEW_LINE
		do
			!!item.make (format.indent_depth);
			if has_breakable then
				item.set_breakable;
				has_breakable := false
			end;
			text.add (item)
		end;

	put_breakable is
		local
			new_line: DEBUG_NEW_LINE
		do
			if not text.empty then
				new_line ?= text.last;
				if new_line /= Void then
					new_line.set_breakable
				else
					has_breakable := true
				end
			else
				has_breakable := true
			end
		end;

	has_breakable: BOOLEAN;
			-- Should a breakable point be integrated 
			-- at the beginning of the next line?

end	 -- class DEBUG_CONTEXT
