class FEATURE_CLAUSE_AS_EBUILD 

inherit

	FEATURE_CLAUSE_AS
		redefine
			set_comments--samik, format_comment, set_comment
		end;

feature -- Attributes

comment: EIFFEL_COMMENTS;

feature -- Formatting
	set_comments (c: EIFFEL_FILE) is
		do

		--samik	c.go_before (position + 1)
	--samik		comment := c.trailing_comment 

    --samik        if features /= Void and then c/= Void then
        --samik        from
        --samik            features.start
        --samik        until
        --samik            features.after
        --samik        loop
       --samik             c.go_after (features.item.start_position)
        --samik            features.item.set_comment (c.trailing_comment)
        --samik            features.forth
        --samik        end
        --samik    end
        end;

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
