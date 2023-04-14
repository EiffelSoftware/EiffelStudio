class STRING_UTF_8_TEMPLATE [T -> READABLE_STRING_GENERAL]

inherit

    TEMPLATE [T]

feature -- Templates

    to_utf_8: STRING_8
            -- STRING_8 string from `target'.
        note
        	title: "To UTF-8 STRING"
            tags: "Unicode, String, STRING"
        do{UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (target)end


end
