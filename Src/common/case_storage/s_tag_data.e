class S_TAG_DATA

inherit

	S_ELEMENT_DATA

creation

	make

feature

	tag: STRING;
			-- Tag of Current 

    text: STRING
            -- Expression

feature {NONE}

    make (tg, txt: STRING) is
            -- Make invariant with tag `tg' with expression `exp'.
        require
            valid_txt: txt /= Void
        do
            tag := tg;
            text := txt;
        ensure
            tag_set: tag = tg;
            text_set: text = txt
        end;

end
