indexing

	description: 
		"Text to indicate the start of call stack item";
	date: "$Date$";
	revision: "$Revision $"

class CALL_STACK_ITEM

inherit

	TEXT_ITEM
		redefine
			image
		end

create
	make,
	make_selected,
	do_nothing

feature -- Initialization

	make (i: INTEGER) is
            -- Initialize `displayed_callstack' to True
            -- with level number `i'.
		require
			positive_i: i > 0
        do
			level_number := i
        end;
	
	make_selected (i: INTEGER) is
			-- Initialize `displayed_callstack' to True
			-- with level number `i'.
		require
			positive_i: i > 0
		do
			displayed_callstack := True;
			level_number := i
		end;
	
feature -- Properties

	level_number: INTEGER;
			-- Level number of call stack

	displayed_callstack: BOOLEAN;
			-- Is the following callstack element going to
			-- display its locals and arguments?

	image: STRING is
			-- Image of stack element
		do
			if displayed_callstack then	
				Result := "-> "
			elseif level_number > 0 then
				Result := ":: "
			else
				Result := "   "
			end
		end;

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current basic text to `text'.
		do
			text.process_call_stack_item (Current)
		end

end -- class CALL_STACK_ITEM
