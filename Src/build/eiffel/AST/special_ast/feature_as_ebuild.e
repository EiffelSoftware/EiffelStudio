class FEATURE_AS_EBUILD

inherit

	FEATURE_AS
	--	redefine
--			set_comment, format_comment
--		end;

feature

	comment: EIFFEL_COMMENTS

	set_comment (c: EIFFEL_COMMENTS) is
		local
			routine_as: ROUTINE_AS_EBUILD
		do
			if c /= Void then
				routine_as ?= body.content;
				if routine_as = Void then
					comment := c
				else
					routine_as.set_comment (c)
				end;
			end;
		end;

	format_comment (ctxt: FORMAT_CONTEXT) is
		local
			routine_as: ROUTINE_AS_EBUILD
		do
			routine_as ?= body.content;
			if routine_as = Void then
				if comment /= Void then
					ctxt.indent
					ctxt.indent
					ctxt.new_line;
					ctxt.put_comments (comment)
					ctxt.exdent
					ctxt.exdent
				end 
			end
		end;

end -- class FEATURE_AS_EBUILD
