indexing

	description: 
		"Abstract notion of text item.";
	date: "$Date$";
	revision: "$Revision $"

deferred class TEXT_ITEM

feature

	image: STRING is
			-- Text representation of Current
		deferred
		end;

feature {TEXT_FORMATTER} -- Implementation

    append_to (text: TEXT_FORMATTER) is
            -- Append Current basic text to `text'.
        require
            valid_text: text /= Void
        deferred
        end

feature {NONE} -- Implementation

	Empty_string: STRING is
			-- Empty string value
		once
			Result := ""
		end

invariant

	valid_image: image /= Void

end -- class TEXT_ITEM
