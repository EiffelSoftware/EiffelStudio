indexing

	description: 
		"Mark appearing before or after major syntactic constructs.";
	date: "$Date$";
	revision: "$Revision $"

class FILTER_ITEM

inherit

	TEXT_ITEM
		rename
			image as empty_string
		end

creation

	make

feature -- Initialize

	make (new_construct: like construct) is
			-- Initialize Current with `new_construct'.
		require
			new_construct_not_void: new_construct /= Void
		do
			construct := new_construct
		ensure
			construct = new_construct
		end;

feature -- Properties

	construct: STRING;
			-- Name of the syntactic construct

	is_before: BOOLEAN;
			-- Does `Current' appear before the syntactic construct?

feature -- Setting

	set_before is
			-- Set is_before to True.
		do
			is_before := True
		ensure
			is_before: is_before
		end;

	set_after is
			-- Set is_before to False.
		do
			is_before := false
		ensure
			is_after: not is_before
		end;

feature {TEXT_FILTER} -- Access

	on_before_processing (f: TEXT_FILTER) is
			-- `Current' is about to be processed.
		do
		end

	on_after_processing (f: TEXT_FILTER) is
			-- `Current' has just been processed.
		do
		end

feature {TEXT_FORMATTER} -- Implementation

    append_to (text: TEXT_FORMATTER) is
            -- Append Current fileter text to `text'.
        do
			text.process_filter_item (Current)	
        end

end -- class FILTER_ITEM
