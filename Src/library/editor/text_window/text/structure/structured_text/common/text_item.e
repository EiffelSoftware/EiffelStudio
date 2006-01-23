indexing

	description: 
		"Abstract notion of text item."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TEXT_ITEM
