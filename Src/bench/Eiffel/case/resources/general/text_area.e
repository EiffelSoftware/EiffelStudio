indexing

	description: 
		"Text area formatted for text output.";
	date: "$Date$";
	revision: "$Revision$"

deferred class TEXT_AREA

feature -- Element change

	append_space is
			-- Append space at end
		deferred
		end;

	append_string (str: STRING) is
			-- Append string at end.
		require
			valid_str: str /= Void;
			no_new_line_in_k: not str.has ('%N');
		deferred	
		end;

	append_character (c: CHARACTER) is
			-- Append `c' at end.
		require
			valid_str: c /= '%N'
		deferred	
		end;

	append_comment_string (str: STRING) is
			-- Append clickable comment string at end.
		require
			valid_str: str /= Void;
			no_new_line_in_str: not str.has ('%N');
		deferred
		end;

	append_clickable_string (st: EC_STONE; str: STRING) is
			-- Append clickable string at end.
		require
			valid_st: st /= Void
			valid_str: str /= Void
			no_new_line_in_str: not str.has ('%N');
		deferred
		end;

	append_keyword (k: STRING) is
			-- Append keywork `k' to Current.
		require
			valid_k: k /= Void;
			no_new_line_in_k: not k.has ('%N');
		deferred
		end;

	generate_class_feature_names (class_data: CLASS_DATA) is
			-- Generate names of the features of `class_data'
		require
			class_data_exists: class_data /= Void
		do
		--	class_data.feature_clause_list.generate_feature_names (Current)
		end

	generate_feature_clause (fc: FEATURE_CLAUSE_DATA; is_spec: BOOLEAN) is
			-- Generate feature clause `fc'
		require
			fc_exists: fc /= Void
		do
		--	fc.actual_generate (Current, is_spec)
		end

	generate_feature_clause_list (fcl: FEATURE_CLAUSE_LIST; is_spec: BOOLEAN) is
			-- Generate the feature clause list `fcl'
		require
			fcl_exists: fcl /= Void
		do
			fcl.generate (Current, is_spec)
		end

	generate_feature_names (fc: FEATURE_CLAUSE_DATA) is
			-- Generate names of the features in feature clause `fc'
		require
			fc_exists: fc /= Void
		do
		--	fc.actual_generate_feature_names (Current)
		end

	generate_modified_feature_names (fc: FEATURE_CLAUSE_DATA) is
			-- Generate the names of midified features of feature clause `fc'
		require
			fc_exists: fc /= Void
		do
			--fc.actual_generate_modified_feature_names (Current)
		end

	new_line is 
			-- Add new_line to Current.
		deferred 
		end;

	indent is
			-- Indent at current position.
		do
			tabs := tabs + 1;
		end;

	exdent is
			-- Exdent at current position.
		require
			valid_tabs: valid_tabs
		do
			tabs := tabs - 1
		end;
	
	start_comment is
			-- Convenience routine to mark start
			-- of comment
		do
		end;

	end_comment (a_stone: EC_STONE) is
			-- Convenience routine to mark 
			-- end of comments for a given stone
		do
		end;

	start_body is
			-- Convenience routine to mark beginning
			-- of routine body
		do
		end;

	end_body (a_stone: EC_STONE) is
			-- Convenience routine to mark 
			-- end of routine body for a given stone
		do
		end;

feature -- Properties

	output_to_disk: BOOLEAN is
			-- Is Current outputing text to disk?
			-- (Default is False)
		do
		end;

	special_string (str: STRING): STRING is
			-- Special string representation of additional symbols 
			-- contained by `str'.			
		deferred
		ensure
			Result_exists: Result /= Void
		end

	valid_tabs: BOOLEAN is
			-- Are tabs within the normal bounds?
		do
			Result := tabs > 0
		ensure
			true_implies_tab_positive: Result implies tabs > 0
		end;

feature {NONE} -- Implementation

	tabs: INTEGER;

end -- class TEXT_AREA
