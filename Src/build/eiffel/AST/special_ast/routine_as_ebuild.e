class ROUTINE_AS_EBUILD

inherit

	ROUTINE_AS
		rename
			is_body_equiv as routine_is_body_equiv
		redefine
			simple_format, set_comment, comment
		end;
	ROUTINE_AS
		redefine
			simple_format, set_comment, is_body_equiv, comment
		select
			is_body_equiv
		end;

feature -- Body equiv

	is_body_equiv (other: like Current): BOOLEAN is
		do
			Result := routine_is_body_equiv (other);
			if Result then
				Result := equal (comment, other.comment)
			end
		end;

feature

	comment: EIFFEL_COMMENTS

	set_comment (com: EIFFEL_COMMENTS) is
		local
			routine_as: ROUTINE_AS_EBUILD
		do
			if com /= Void then
				comment := com
			end;
		end;

	simple_format (ctxt: FORMAT_CONTEXT) is
        do
            ctxt.put_space
            ctxt.put_text_item (ti_Is_keyword)
            ctxt.indent_one_more

			if comment /= Void then
				ctxt.indent_one_more
				ctxt.next_line
				ctxt.put_comment (comment)
				ctxt.indent_one_less
			end

            if obsolete_message /= Void then
                ctxt.next_line
                ctxt.put_text_item (ti_Obsolete_keyword)
                ctxt.indent_one_more
                ctxt.next_line
                obsolete_message.simple_format (ctxt)
                ctxt.indent_one_less
            end

            if precondition /= Void then
                precondition.simple_format (ctxt)
            end

            if locals /= Void then
                ctxt.next_line
                ctxt.put_text_item (ti_Local_keyword)
                ctxt.indent_one_more
                ctxt.new_line_between_tokens
                ctxt.next_line
                locals.simple_format (ctxt)
                ctxt.indent_one_less
            end

            if routine_body /= Void then
                ctxt.next_line
                routine_body.simple_format (ctxt)
            end

            if postcondition /= Void then
                postcondition.simple_format (ctxt)
            end

            if rescue_clause /= Void then
                ctxt.next_line
                ctxt.put_text_item (ti_Rescue_keyword)
                ctxt.indent_one_more
                ctxt.next_line
                rescue_clause.simple_format (ctxt)
                ctxt.indent_one_less
            end

            ctxt.next_line
            ctxt.put_text_item (ti_End_keyword)
            ctxt.indent_one_less
        end;

end -- class ROUTINE_AS_EBUILD
