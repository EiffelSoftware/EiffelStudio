class FEATURE_CLAUSE_AS_EBUILD 

inherit

	EXT_FEATURE_CLAUSE_AS

feature -- Attributes

comment: EIFFEL_COMMENTS;

feature -- Formatting
	
	set_comment (c: EIFFEL_COMMENTS) is
		do
			if c /= Void then
				comment := c
			end
		end;

	format_comment (ctxt: FORMAT_CONTEXT) is
		do
			if comment /= Void then
				if comment.count > 1 then
					ctxt.indent
					ctxt.indent
					ctxt.new_line
					ctxt.put_comments (comment)
					ctxt.exdent
					ctxt.exdent
				else
					ctxt.put_space;
					ctxt.put_comments (comment)
				end
			end
		end;
		
end -- class FEATURE_CLAUSE_AS_EBUILD
