class FEATURE_CLAUSE_AS_EBUILD 

inherit

	FEATURE_CLAUSE_AS
		redefine
			set_comments, format_comment, set_comment
		end;

feature

	set_comments (c: EIFFEL_FILE) is
		do

			c.go_before (position + 1)
			comment := c.trailing_comment 

            if features /= Void and then c/= Void then
                from
                    features.start
                until
                    features.after
                loop
                    c.go_after (features.item.start_position)
                    features.item.set_comment (c.trailing_comment)
                    features.forth
                end
            end
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
					ctxt.indent_one_more
					ctxt.indent_one_more
					ctxt.next_line
					ctxt.put_comment (comment)
					ctxt.indent_one_less
					ctxt.indent_one_less
				else
					ctxt.put_space;
					ctxt.put_comment (comment)
				end
			end
		end;
		
end -- class FEATURE_CLAUSE_AS_EBUILD
