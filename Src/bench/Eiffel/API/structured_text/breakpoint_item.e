indexing

	description: 
		"Item to denote a breakpoint.";
	date: "$Date$";
	revision: "$Revision $"

class BREAKPOINT_ITEM

inherit

	TEXT_ITEM

creation
	make 

feature {NONE} -- Initialization

	make (a_feature: like e_feature; i: like index) is
			-- Create a breakpoint node for feature `e_feature'
			-- with break point index `i'.
		require
			valid_index: i >= 1;
			valid_feature: a_feature /= Void
		do
			e_feature := a_feature;
			index := i
		end;

feature -- Property

	image: STRING is "";

	index: INTEGER;
			-- Breakpoint index

	e_feature: E_FEATURE;
			-- Feature which breakpoint is in

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current debug new line text to `text'.
		do
			text.process_breakpoint (Current);
		end

end -- class BREAKPOINT_ITEM
