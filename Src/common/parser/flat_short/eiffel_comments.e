class EIFFEL_COMMENTS
	
inherit

	COMPARABLE
		redefine
			is_equal
		end

creation
	make, make_from

feature {NONE}
	
	make (p: INTEGER) is
			-- set position to p
		do
			position := p;
			count := 0;
			!!text.make (1, 1);
		end;

	make_from (other: like Current) is
		require
			valid_other: other /= Void
		do
			!! text.make (1, other.text.count);
			position := other.position;
			merge (other);
		end;

feature
	

	infix "<" (other: like Current): BOOLEAN is
		local
			different: BOOLEAN;
			i: INTEGER;
			other_text: like text
		do
			other_text := other.text;
			from
				i := 1
			until 
				different 
				or i > count
				or i >  other.count
			loop
				if other /= void then
					Result := (text.item(i)) < (other_text.item(i));
					different := not (text.item(i)).is_equal 
												(other_text.item(i));
					i := i + 1
				end;
				if not different then
					Result := count < other.count
				end;
			end;
		end;

	is_equal (other: like Current): BOOLEAN is
		require else
			other = Void	
		local
			i : INTEGER;
			other_text: like text
		do
			if other /= void then
				if other.count = count then
					other_text := other.text;
					Result := true;
					from
						i := 1
					until
						not Result 
						or i > count
					loop
						Result := (text.item (i)).is_equal (other_text.item (i));
						i := i + 1
					end;
				end;
			end;
		end;

	count: INTEGER;
	
	position: INTEGER;

	add (s: STRING) is
			-- add a line to the comment
		do
			count := count + 1;
			text.force (s, count);
		end;

	merge (other: like Current) is
		require
			valid_other: other /= Void
		local
			other_count, i: INTEGER
		do
			other_count := other.count;
			from
				i := 1;
			until
				i > other_count
			loop
				add (other.text.item (i))
				i := i + 1;
			end;
		end;

	diff (old_templ: like Current): like Current is
			-- Differences between Current and `old_templ';
        require
            valid_old_templ: old_templ /= Void
        local
            c, i: INTEGER
			s: STRING;
			other_text: like text
        do
			!! Result.make (0);
            c := count;
			other_text := old_templ.text;
			other_text.compare_objects;
			
            from
                i := 1;
            until
                i > count
            loop
				s := text.item (i);
				if not other_text.has (s) then
                	Result.add (text.item (i))
				end;
                i := i + 1;
            end;
			text.compare_references;
		ensure
			valid_result: Result /= Void
        end;

	same_as (other: like Current): BOOLEAN is
			-- are the two comments the same. Useful for merging
			-- categories
		local
			i : INTEGER;	
			other_text: like text
		do
			Result := count = other.count;
			other_text := other.text;
			from
				i := 1;
			until
				not Result or i > count
			loop
				if text.item (i).is_equal (other_text.item (i)) then
					i := i + 1;
				else
					Result := false;
				end;
			end;
		end;
		
	text: ARRAY [STRING];

	trace is
		local
			i: INTEGER
		do
			io.error.putstring ("position: ");
			io.error.putint (position);
			io.error.new_line;
			from
				i := 1
			until
				i > count
			loop
				io.error.putstring (text.item(i));
				i := i + 1;
			end
			io.error.new_line;
		end


end
		
		
