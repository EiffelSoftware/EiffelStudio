indexing

	description: 
		"Error that interrupts a compilation.";
	date: "$Date$";
	revision: "$Revision $"

class INTERRUPT_ERROR

inherit

	ERROR
		redefine
			help_file_name
		end

feature -- Status report

	is_during_compilation: BOOLEAN;
			-- Was the interrupt called during an eiffel compilation?
			-- (False implies that it was interrupted during Reverse
			-- engineering)

feature -- Status setting

	set_during_compilation is
			-- Set `is_during_compilation' to `True'.
		do
			is_during_compilation := True
		ensure
			is_during_compilation: is_during_compilation
		end

feature -- Output

	code: STRING is 
			-- Interrupt code
		do
			Result := "INTERRUPT"
		end;

	help_file_name: STRING is 
			-- File name for the interrupt message
		do
			if is_during_compilation then
				Result := "COMP_INT"
			else
				Result := "RE_INT"
			end
		end
		
	file_name: STRING is
			-- No associated file name
		do
			
		end
		
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			st.add_string ("Interrupt was invoked");
			st.add_new_line
		end;

end -- class INTERRUPT_ERROR
