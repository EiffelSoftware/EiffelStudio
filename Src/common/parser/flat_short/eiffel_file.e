class EIFFEL_FILE

creation

	make, make_for_feature_comments

feature

	lines: FIXED_LIST [EIFFEL_LINE];
			-- the content of the file, stripped of comments

	comments: FIXED_LIST [EIFFEL_COMMENTS];
			-- extracted comments

	between_lines: BOOLEAN;
			-- is the current position between two lines

	make_for_feature_comments (f: UNIX_FILE; start_pos, end_pos:INTEGER) is
			-- Just fill in the comment structures for file between
			-- `start_pos' and `end_pos'.
		require
			good_argument: f /= void;
			file_not_open: f.is_closed
		local
			p_line,comment_line: EIFFEL_LINE;
			comment: EIFFEL_COMMENTS;	-- a comment
			p: INTEGER;
			l_list: LINKED_LIST [EIFFEL_LINE];
			c_list: LINKED_LIST [EIFFEL_COMMENTS];	
		do
			from
				f.open_read;
				!!l_list.make;
				!!c_list.make;
			until
				f.end_of_file or else p > end_pos
			loop
				p := f.position;
				f.readline;
				if p > start_pos then
					!!p_line.make (p, f.laststring.duplicate);
					p_line.left_adjust;
					p_line.right_adjust;
					comment_line := p_line.comment;
					if comment_line /= void then
						p_line.discard_comment;
						p_line.right_adjust;
						if comment = void then
							!!comment.make (comment_line.position);
						end;
						comment.add (comment_line.text);
					else
						c_list.add (comment);
						comment := void;
					end;
				end;
			end;
			from
				c_list.start
			until
				c_list.after
			loop
				if 
					c_list.item = void
					or else c_list.item.text.empty  
				then
					c_list.remove
				else
					c_list.forth;
				end;
			end;
			create_lists (l_list, c_list);
			l_list.start;
			c_list.start;
			position_in_line := 1;
			f.close;
		end;
	
	make (f: UNIX_FILE) is
			-- analyse file f, retrieve comments
			-- the file should not be open before the call
		require
			good_argument: f /= void;
			file_not_open: f.is_closed
		local
			p_line,comment_line: EIFFEL_LINE;
			comment: EIFFEL_COMMENTS;	-- a comment
			p: INTEGER;
			l_list: LINKED_LIST [EIFFEL_LINE];
			c_list: LINKED_LIST [EIFFEL_COMMENTS];	
		do
			from
				f.open_read;
				!! l_list.make;
				!! c_list.make;
			until
				f.end_of_file
			loop
				p := f.position;
				f.readline;
				!!p_line.make (p, f.laststring.duplicate);
				p_line.left_adjust;
				p_line.right_adjust;
				comment_line := p_line.comment;
				if comment_line /= void then
					p_line.discard_comment;
					p_line.right_adjust;
					if comment = void then
						!!comment.make (comment_line.position);
					end;
					comment.add (comment_line.text);
				else
					c_list.add (comment);
					comment := void;
				end;
				if not p_line.empty then
					l_list.add (p_line);
				end;
			end;
			from
				l_list.start
			until
				l_list.after
			loop
				if 
					l_list.item = void
					or else l_list.item.empty
				then
					l_list.remove
				else
					l_list.forth;
				end;
			end;
			from
				c_list.start
			until
				c_list.after
			loop
				if 
					c_list.item = void
					or else c_list.item.text.empty  
				then
					c_list.remove
				else
					c_list.forth;
				end;
			end;
				
			create_lists (l_list, c_list);
			lines.start;
			comments.start;
			position_in_line := 1;
			f.close;
debug ("FS_COMMENT")
	trace;
end;
		ensure
			file_closed: f.is_closed
		end;
			
	go_after (pos: INTEGER) is
			-- Make current position greater than or equal to pos
		local
			item: EIFFEL_LINE
		do
debug ("FS_COMMENT")
	io.error.putstring ("in go after for pos: ");
	io.error.putint (pos);
	io.error.new_line;
end;
			from
				lines.start;
				position_in_line := 1;
				between_lines := true;
			until
				lines.after
					or else lines.item.position + position_in_line - 1 >= pos
			loop
				item := lines.item;
				if item.text.count + item.position - 1 >= pos then
					position_in_line := pos - item.position + 1;
					between_lines := false;
				else
					lines.forth;
				end;
			end;
debug ("FS_COMMENT")
	io.error.putstring ("position: ");
	io.error.putint (position);
	io.error.new_line;
end
		end;

	go_before (pos: INTEGER) is
			-- make current position less than or equal to pos
		do
debug ("FS_COMMENT")
	io.error.putstring ("in go before for pos: ");
	io.error.putint (pos);
	io.error.new_line;
end;
			from
				lines.finish;
				between_lines := true;
				if not lines.off then 
					position_in_line :=  line.text.count 
				end
			until
				lines.before
					or else (line.position + position_in_line - 1) <= pos
			loop
				if line.text.count + line.position - 1 <= pos then
					position_in_line := pos - line.position + 1;
					between_lines := false;
				else
					lines.back;
					if not lines.before then
							position_in_line := line.text.count;
					end;
				end;
			end;
debug ("FS_COMMENT")
	io.error.putstring ("position: ");
	io.error.putint (position);
	io.error.new_line;
end;
		end;
			
	find_first_match (pattern: STRING; stop: INTEGER; context: BOOLEAN) is
			-- find first occurence of pattern between current position
			-- and stop, checking pattern context if context is true.
			-- if found, position is the first character of pattern
			-- else, after or position > stop
		local
			seeker: MATCH;
			found: BOOLEAN
		do
			from
				!!seeker.make (line.text, pattern, context);
				seeker.go (position_in_line);
				found :=  false;
			until
				lines.after or position > stop or found
			loop
				seeker.find_next;
				found := not seeker.after;
				if not found then
					lines.forth;
					position_in_line := 1;
					if not lines.after and then position <= stop then
						seeker.make (line.text, pattern, context);
					end;
				else
					position_in_line := seeker.position;
				end;
		
			end;
		end;

		
								
	find_last_match (pattern: STRING; stop: INTEGER; context: BOOLEAN) is
  				  -- find last occurence of pattern between current position
  				  -- and stop, checking pattern context if context is true.
 				  -- if found, position is the last character of pattern
				  -- else, before or position < stop
		local
			seeker: MATCH;
			found: BOOLEAN;
		do
			from
				!!seeker.make (line.text, pattern, context);
			   			seeker.go (position_in_line);
			   			found :=  false;
			until
				lines.after or position > stop or found
			loop
				seeker.find_previous;
			   	found := not seeker.before;
			   	if not found then
			   		lines.back;
			   		if not lines.before and then position <= stop then
						position_in_line := line.text.count;
			   			seeker.make (line.text, pattern, context);
						seeker.go (position_in_line);
			   		end;
			   	else
			   		position_in_line := seeker.position;
			   	end;
			end;
		end;

	position: INTEGER is
			-- current position in the text
		do
			if lines.before or else lines.empty then 
				Result := 0
			elseif lines.after then
				Result := lines.last.position + lines.last.text.count;
			else
				Result := lines.item.position + position_in_line - 1;
			end;
		end;

	position_in_line: INTEGER;
		-- current position in line

	comment_position: INTEGER;

	forth is
			-- go to next character
		do
			between_lines := false;
			if position_in_line >= line.text.count then
				position_in_line := 1;
				from
					lines.forth;
				until
					not line.empty
				loop
					lines.remove;
				end;
			else
				position_in_line := position_in_line + 1;
			end;
		end;

	line: EIFFEL_LINE is
			-- current line
		do
			Result := lines.item
		end;

feature

	trailing_comment: EIFFEL_COMMENTS is
			-- return the trailing comment after current
			-- position, if any (void if none)
		local
			stop: BOOLEAN;
			pos: INTEGER
		do
			if between_lines then
				pos := position;
				from
					comments.start;
				until	
					comments.after or else
					stop
				loop	
					stop := comments.item.position >= pos;
					if not stop then
						comments.forth;
					end;
				end;
				if stop then
					comment_position := comments.item.position
				end;
				if not lines.after then
					lines.forth
				end;
				if 
					not comments.after
					and then (lines.after
						or else lines.item.position  > comment_position)
				then
					Result := comments.item;
				end;
			end;
		end;
				
	next_comment: EIFFEL_COMMENTS is
			-- must be called after trailing comment or
			-- next comment. Return the following comment while
			-- there is no text in between, and void after that.
		do
			if not comments.after then
				comments.forth;
			end;
			if 
				not comments.after
				and then (lines.off
					or else (lines.item.position
						> comments.item.position))
			then
				Result := comments.item;
				comment_position := Result.position;
			end;
		end;

feature {}

	create_lists (l_list: LINKED_LIST [EIFFEL_LINE]; 
					c_list: LINKED_LIST [EIFFEL_COMMENTS]) is
			-- Create lines and comments using `l_list' and	
			-- `c_list'.
		do
			from
				l_list.start;
				!! lines.make (l_list.count);
				lines.start;
			until
				l_list.after
			loop
				lines.replace (l_list.item);
				lines.forth;	
				l_list.forth
			end;
			from
				c_list.start;
				!! comments.make (c_list.count);
				comments.start;
			until
				c_list.after
			loop
				comments.replace (c_list.item);
				comments.forth;
				c_list.forth
			end;
		end

	trace is
		do
			io.error.putstring ("*** LINES ****%N")
			from
				lines.start;
			until
				lines.after
			loop
				lines.item.trace;
				lines.forth;	
			end;
			io.error.putstring ("*** COMMENTS ****%N")
			from
				comments.start;
			until
				comments.after
			loop
				comments.item.trace;
				comments.forth;	
			end;
		end

end

			
