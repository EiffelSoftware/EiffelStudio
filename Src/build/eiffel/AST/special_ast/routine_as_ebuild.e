class ROUTINE_AS_EBUILD

inherit

	ROUTINE_AS
		rename
			is_body_equiv as routine_is_body_equiv
		redefine
			simple_format--, set_comment, comment
		end;
	ROUTINE_AS
		redefine
			simple_format, is_body_equiv--, set_comment, comment
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
            ctxt.indent

			if comment /= Void then
				ctxt.indent
				ctxt.new_line
				ctxt.put_comments (comment)
				ctxt.exdent
			end

            if obsolete_message /= Void then
                ctxt.new_line
                ctxt.put_text_item (ti_Obsolete_keyword)
                ctxt.indent
                ctxt.new_line
                obsolete_message.simple_format (ctxt)
                ctxt.exdent
            end

            if precondition /= Void then
                precondition.simple_format (ctxt)
            end

            if locals /= Void then
                ctxt.new_line
                ctxt.put_text_item (ti_Local_keyword)
                ctxt.indent
                ctxt.set_new_line_between_tokens
                ctxt.new_line
                locals.simple_format (ctxt)
                ctxt.exdent
            end

            if routine_body /= Void then
                ctxt.new_line
                routine_body.simple_format (ctxt)
            end

            if postcondition /= Void then
                postcondition.simple_format (ctxt)
            end

            if rescue_clause /= Void then
                ctxt.new_line
                ctxt.put_text_item (ti_Rescue_keyword)
                ctxt.indent
                ctxt.new_line
                rescue_clause.simple_format (ctxt)
                ctxt.exdent
            end

            ctxt.new_line
            ctxt.put_text_item (ti_End_keyword)
            ctxt.exdent
        end;

end -- class ROUTINE_AS_EBUILD
