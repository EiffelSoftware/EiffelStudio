class EIFFEL_FILE

creation
	make

feature
	
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
		do
			from
				f.open_read;
				!!lines.make;
				!!comments.make;
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
					comments.add (comment);
					comment := void;
				end;
				if not p_line.empty then
					lines.add (p_line);
				end;
			end;
			from
				lines.start;
			until
				lines.offright
			loop
				if  line.empty then
					lines.remove;
				else
					lines.forth;	
				end;
			end;
			lines.start;
			comments.start;
			position_in_line := 1;
			f.close;
			clean
		ensure
			file_closed: f.is_closed
		end;
			

	lines: LINKED_LIST [EIFFEL_LINE];
			-- the content of the file, stripped of comments

	comments: LINKED_LIST [EIFFEL_COMMENTS];
			-- extracted comments

	between_lines: BOOLEAN;
			-- is the current position between two lines



	go_after (pos: INTEGER) is
			-- make current position greater than or equal to pos
		do
			from
				lines.start;
				position_in_line := 1;
				between_lines := true;
			until
				lines.offright 
					or else line.position + position_in_line - 1 >= pos
			loop
				if line.text.count + line.position - 1 >= pos then
					position_in_line := pos - line.position + 1;
					between_lines := false;
				else
					lines.forth;
				end;
			end;
		ensure
			lines.offright or else position >= pos;
			between_lines or position = pos	
		end;

	go_before (pos: INTEGER) is
			-- make current position less than or equal to pos
		do
			from
				lines.finish;
				between_lines := true;
				if not lines.off then position_in_line :=  line.text.count end
			until
				lines.offleft
					or else line.position + position_in_line - 1 <= pos
			loop
				if line.text.count + line.position - 1 <= pos then
					position_in_line := pos - line.position + 1;
					between_lines := false;
				else
					lines.back;
					if not lines.offleft then
							position_in_line := line.text.count;
					end;
				end;
			end;
		ensure
			lines.offleft or else position <= pos;
			between_lines or position = pos
		end;
			
	find_first_match (pattern: STRING; stop: INTEGER; context: BOOLEAN) is
			-- find first occurence of pattern between current position
			-- and stop, checking pattern context if context is true.
			-- if found, position is the first character of pattern
			-- else, offright or position > stop
		local
			seeker: MATCH;
			found: BOOLEAN
		do
			from
				!!seeker.make (line.text, pattern, context);
				seeker.go (position_in_line);
				found :=  false;
			until
				lines.offright or position > stop or found
			loop
				seeker.find_next;
				found := not seeker.offright;
				if not found then
					lines.forth;
					position_in_line := 1;
					if not lines.offright and then position <= stop then
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
		          -- else, offleft or position < stop
		local
			seeker: MATCH;
			found: BOOLEAN;
		do
			from
               				 !!seeker.make (line.text, pattern, context);
                				seeker.go (position_in_line);
                				found :=  false;
            			until
                				lines.offright or position > stop or found
            			loop
                				seeker.find_previous;
                				found := not seeker.offleft;
                				if not found then
                    				lines.back;
                    				if not lines.offleft and then position <= stop then
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
			if lines.offleft then 
				Result := 0
			elseif lines.offright then
				Result := lines.last.position + lines.last.text.count;
			else
				Result := line.position + position_in_line - 1;
			end;
		end;




feature
	

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
		do
			if between_lines then
				from
					comments.start;
				until	
					comments.off or else
					comments.item.position >=  position
				loop	
					comments.forth;
				end;
				if not comments.off then
					comment_position := comments.item.position
				end;
				if not lines.offright then
					lines.forth
				end;
				if 
					not comments.off
					and then (lines.off
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
			if not comments.off then
				comments.forth;
			end;
			if 
				not comments.off
				and then lines.off
					or else (lines.item.position
						> comments.item.position)
			then
				Result := comments.item;
				comment_position := Result.position;
			end;
		end;

feature {}

	clean is
			-- remove void or empty lines and comments
		do
			from
				lines.start
			until
				lines.off
			loop
				if 
					lines.item = void
					or else lines.item.empty
				then
					lines.remove
				else
					lines.forth;
				end;
			end;
			from
				comments.start
			until
				comments.off
			loop
				if 
					comments.item = void
					or else comments.item.text.empty  
				then
					comments.remove
				else
					comments.forth;
				end;
			end;
		end;
				
				
end

			
