indexing

	description:
		"Displays warnings and errors specifically for bench";
	date: "$Date$";
	revision: "$Revision $"

class BENCH_ERROR_DISPLAYER

inherit

	SHARED_EIFFEL_PROJECT;
	DEFAULT_ERROR_DISPLAYER
		redefine 
			display_additional_info 
		end

creation
	make

feature -- Output

	display_additional_info (st: STRUCTURED_TEXT) is
			-- Add additional information to `st'.
		local
			degree_nbr: INTEGER;
			to_go: INTEGER
		do
			degree_nbr := Degree_output.current_degree;
			if degree_nbr > 0 then
					-- Case has degree_number equal to 0
				st.add_string ("Degree: ");
				st.add_string (degree_nbr.out);
			end;
			st.add_string (" Processed: ")
			st.add_string (Degree_output.processed.out);
			st.add_string (" To go: ")
			to_go := Degree_output.total_number - Degree_output.processed;
			st.add_string (to_go.out);
			st.add_string (" Total: ")
			st.add_string (Degree_output.total_number.out);
			st.add_new_line;
		end

end -- class BENCH_ERROR_DISPLAYER
