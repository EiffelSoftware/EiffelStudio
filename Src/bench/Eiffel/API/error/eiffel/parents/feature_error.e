indexing
	description: "Error that occurred within a feature.";
	date: "$Date$";
	revision: "$Revision $"

deferred class FEATURE_ERROR 

inherit

	EIFFEL_ERROR
		redefine
			trace, is_defined
		end;

feature -- Properties

	error_position: INTEGER;
			-- Position in file where error occurred

	e_feature: E_FEATURE;
			-- Feature involved in the error

	feature_name: STRING;
			-- If e_feature is Void then use feature name 
			-- (if this is Void then feature occurred in
			-- the invariant)

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined
		ensure then
			is_feature_defined: Result implies is_feature_defined
		end;

	is_feature_defined: BOOLEAN is
			-- Is the feature defined for error?
		do
			Result := True
		ensure
			always_true: Result
		end;

feature -- Output

	trace (st: STRUCTURED_TEXT) is
			-- Output the error message.
		local
			
		do
			print_error_message (st);
			st.add_string ("Class: ");
			class_c.append_signature (st);
			st.add_new_line;
			st.add_string ("Feature: ");
			if error_position /= 0 then
				if e_feature /= Void then
					st.add_feature_error (e_feature, e_feature.name, error_position)
				elseif feature_name /= Void then
					st.add_feature_error (e_feature, feature_name, error_position)
				else
					st.add_string ("invariant")
				end;
			elseif e_feature /= Void then
				e_feature.append_name (st);
			elseif feature_name /= Void then
				st.add_string (feature_name);
			else
				st.add_string ("invariant");
			end;
			st.add_new_line;
			build_explain (st);
			if error_position /= 0 then
				print_line_number (st)
			end;
		end;

feature {COMPILER_EXPORTER} -- Implementation

	set_feature (f: FEATURE_I) is
			-- Assign `f' to `feature'.
		require
			valid_f: f /= Void;
			non_void_class_c: class_c /= Void
		do
			e_feature := f.api_feature (class_c.class_id)
		end;

feature {ERROR_HANDLER} -- Implementation

	set_error_position (i: like error_position) is
			-- Set `error_position' to `i'.
		require
			non_negative_value: i >= 0
		do
			error_position := i
		ensure
			set: error_position = i
		end;

feature {NONE} -- Implementation

	print_line_number (st: STRUCTURED_TEXT) is
			-- Display the line number in `st'.
		require
			valid_position: error_position > 0
		local
			file: PLAIN_TEXT_FILE;
			previous_line: STRING;
			current_line: STRING;
			next_line: STRING;
			start_line_pos: INTEGER;
			line_number: INTEGER;
			file_name: STRING
		do
			file_name := class_c.file_name;
			!! file.make (file_name);
			if file.exists and then file.is_readable then
				file.open_read;
				from
				until
					file.position > error_position or else file.end_of_file
				loop
					previous_line := current_line;
					start_line_pos := file.position;
					line_number := line_number + 1;
					file.readline;
					current_line := clone (file.laststring)
				end;
				if file.position > error_position then
						-- It was found
					if not file.end_of_file then
						file.readline;
						next_line := clone (file.laststring)
					end;
				else
					line_number := 0
				end;
				file.close;
			end;
			if line_number > 0 then
				st.add_string ("Line: ");
				st.add_string (line_number.out);
			else
				st.add_string ("Character position: ");
				st.add_string (error_position.out);
			end;
			if class_c.lace_class.date_has_changed then
				st.add_string (" (source code has changed)");
				st.add_new_line
			elseif line_number > 0 then
				st.add_new_line;
				st.add_string ("  ");
				if previous_line /= Void then
					if not previous_line.is_empty then
						previous_line.replace_substring_all ("%T", "  ");
					end;
					st.add_string (previous_line);
					st.add_new_line;
				end;
				st.add_string ("->");
				if not current_line.is_empty then
					current_line.replace_substring_all ("%T", "  ");
				end;
				st.add_string (current_line);
				st.add_new_line;
				if next_line /= Void then
					st.add_string ("  ");
					if not next_line.is_empty then
						next_line.replace_substring_all ("%T", "  ");
					end;
					st.add_string (next_line);
					st.add_new_line
				end
			end
		end;

end -- class FEATURE_ERROR
