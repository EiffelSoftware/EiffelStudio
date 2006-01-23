indexing

	description: 
		"Text that has an image."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class BASIC_TEXT

inherit

	TEXT_ITEM

create

	make

feature -- Initialization

	make (text: like image) is
			-- Initialize Current basic text with image `text'.
		require
			valid_text: text /= Void
		do
			image := text;
		end;

feature -- Properties

	image: STRING;
			-- Text representation of Current

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current basic text to `text'.
		do
			text.process_basic_text (Current)
		end

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




end -- class BASIC_TEXT
