indexing
	description: 
		"Content of an eiffel file made up of a list of eiffel_lines. %
		%Store the next feature_clause_as and feature_as structures%
		%in order to extract comments of the analyzed feature%
		%or feature clause.";
	date: "$Date$";
	revision: "$Revision $"

class EIFFEL_FILE

inherit
	ARRAYED_LIST [EIFFEL_LINE]
		rename
			make as list_make
		end

creation
	make, make_with_positions

feature -- Initialization

	make (a_file_name: STRING; end_f_pos: INTEGER) is
			-- Initialize eiffel file with file name `a_file_name'
			-- with file_end_position of `end_pos'.
		require
			valid_file_name: a_file_name /= Void
			positive_end_f_pos: end_f_pos > 0
		local
			file: RAW_FILE	-- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
			line: EIFFEL_LINE
			start_pos: INTEGER
			end_pos: INTEGER
		do
			list_make (100)
			create file.make (a_file_name)
			if file.exists and then file.is_readable and then not file.is_empty then
				from
					file.open_read
				until
					file.end_of_file
				loop
					file.readline
					end_pos := file.position
					if start_pos < end_pos then
						create line.make (start_pos, end_pos - 1, clone (file.laststring))
						extend (line)
					end
					start_pos := end_pos
				end
				file_end_position := end_f_pos
				file.close
debug ("COMMENTS")
	trace
end
			end
			start
		end

	make_with_positions (a_file_name: STRING; start_feat_pos, end_feat_pos: INTEGER) is
			-- Initialize eiffel file with file name `a_file_name'
			-- with file_end_position of `end_pos' between
			-- `start_feat_pos' and `end_feat_pos'.
		require
			valid_file_name: a_file_name /= Void
			positive_positions: start_feat_pos > 0 and then	
						end_feat_pos > 0
		local
			file: PLAIN_TEXT_FILE
			line: EIFFEL_LINE
			start_pos, end_pos: INTEGER
		do
			list_make (30)
			create file.make (a_file_name)
			if file.exists and then file.is_readable and then not file.is_empty then
				from
					file.open_read
				until
					file.end_of_file or else start_pos > end_feat_pos
				loop
					file.readline
					end_pos := file.position
					if start_feat_pos <= end_pos then
						create line.make (start_pos, end_pos - 1, clone (file.laststring))
						extend (line)
					end
					start_pos := end_pos
				end
				file_end_position := file.count
				file.close
debug ("COMMENTS")
	trace
end
			end
			start
		end

feature -- Properties
	
	current_feature: FEATURE_AS
			-- Currently analyzed feature

	current_feature_clause: FEATURE_CLAUSE_AS
			-- Currently analyzed feature clause

	file_end_position: INTEGER
			-- End position of file 
			-- (after last end keyword in order to ignore
			-- comments at the end of the class).

	next_feature_clause: FEATURE_CLAUSE_AS
			-- Next feature clause after currently analyzed feature

	next_feature: FEATURE_AS
			-- Next feature after currently analyzed feature

feature -- Setting for comments

	set_current_feature (feat: like current_feature) is
			-- Set current_feature to `feat'.
		do
			current_feature := feat
		ensure
			current_feature = feat
		end

	set_current_feature_clause (fc: like current_feature_clause) is
			-- Set current_feature_clause to `fc'.
		do
			current_feature_clause := fc
		ensure
			current_feature_clause = fc
		end

	set_next_feature_clause (fc: like next_feature_clause) is
			-- Set next_feature_clause to `fc'.
		do
			next_feature_clause := fc
		ensure
			next_feature_clause  = fc
		end

	set_next_feature (feat: like next_feature) is
			-- Set next_feature to `feat'.
		do
			next_feature := feat
		ensure
			next_feature = feat
		end;

feature -- Output

	current_feature_clause_comments: EIFFEL_COMMENTS is
			-- Comments for `current_feature_clause' 
		require
			valid_current_feature_clause: current_feature_clause /= Void
		local
			start_pos: INTEGER
		do
			if not is_empty then
				start_pos := current_feature_clause.position;
				Result := extract_comments_from (start_pos, end_position);
			end
		end

	current_feature_comments: EIFFEL_COMMENTS is
			-- Comments for `current_feature' 
		require
			valid_current_feature: current_feature /= Void
		local
			rout_as: ROUTINE_AS;
			start_pos, end_pos: INTEGER;
		do
			if not is_empty then
				start_pos := current_feature.start_position;
				rout_as ?= current_feature.body.content;
				if rout_as = Void then
					end_pos := end_position
				else
					end_pos := rout_as.body_start_position
				end;
				Result := extract_comments_from (start_pos, end_pos);
			end
		end

feature {NONE} -- Implementation

	extract_comments_from (start_pos, end_pos: INTEGER): EIFFEL_COMMENTS is
			-- Extract comments from `start_pos' to `end_pos'
		require
			not_empty: not is_empty;
			positive_positions: start_pos > 0 and then end_pos > 0;
			valid_positions: end_pos >= start_pos;
			within_end_file: end_pos <= file_end_position and then	
						start_pos >= i_th (1).start_position
		local 
			e_line: EIFFEL_LINE
			finished: BOOLEAN
			comment: CELL2 [STRING, INTEGER]
		do
debug ("COMMENTS")
	io.error.putstring ("Extracting from start_pos: ")
	io.error.putint (start_pos)
	io.error.putstring (" end position: ")
	io.error.putint (end_pos)
	io.error.new_line
end
			if not item.is_within (start_pos) then
				if item.start_position > start_pos then
					from
					until
						item.is_within (start_pos)
					loop
						back
					end
				else
					from
					until
						item.is_within (start_pos)
					loop
						forth
					end
				end
			end

			from
				create Result.make
			until
				after or finished
			loop
				e_line := item;
				if e_line.end_position >= end_pos then
					finished := True
				else
					comment := e_line.comment;	
					if comment /= Void then
						if comment.item2 >= end_pos then
							finished := True
						else
							Result.extend (comment.item1)
						end
					end;
					forth
				end;
			end;

			if Result.is_empty then
				Result := Void
			end
		end

	end_position: INTEGER is
			-- End position for Current analyzed feature
		do
			if next_feature /= Void then
				Result := next_feature.start_position
			elseif next_feature_clause /= Void then
				Result := next_feature_clause.position
			else
				Result := file_end_position
			end
		ensure
			check_next_feature: next_feature /= Void implies 
						Result = next_feature.start_position
			check_next_feature_clause: next_feature = Void and then
							next_feature_clause /= Void implies 
						Result = next_feature_clause.position
			check_file_end_position: next_feature = Void and then next_feature_clause = Void
							implies Result = file_end_position
			positive_result: Result >= 0 and then Result <= file_end_position
		end

feature -- Debug

	trace is
		do
			io.error.putstring ("Final position: ")
			io.error.putint (file_end_position)
			io.error.new_line
			from
				start
			until
				after
			loop
				item.trace
				forth
			end
		end

invariant
	not_before: not off 

end -- class EIFFEL_FILE
