indexing

	description: 
		"Text within comments that have been `quoted'.";
	date: "$Date$";
	revision: "$Revision $"

class QUOTED_TEXT

inherit

	TEXT_ITEM
		redefine
			image
		end

creation

	make

feature -- Initialization

	make (text: like image) is
			-- Initialize image_without_quotes with `text'.
		require
			valid_text: text /= Void
		do
			image_without_quotes := text;
		ensure
			image_without_quotes = text
		end;

feature -- Properties

	image_without_quotes: STRING;
			-- Image with the start and end quote

	image: STRING is
			-- Text representation of Current
		do
			!! Result.make (image_without_quotes.count + 2)
			Result.extend ('`');
			Result.append (image_without_quotes);
			Result.extend ('%'')
		ensure then
			result_has_quotes: Result.item (1) = '`' and then
					Result.item (Result.count) = '%''
		end;

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append quoted text to `text'.
		do
			text.process_quoted_text (Current)
		end

end -- class QUOTED_TEXT
