class EIFFEL_COMMENTS
	
inherit

	COMPARABLE
		redefine
			is_equal
		end

creation
	make

feature
	
	make (p: INTEGER) is
			-- set position to p
		do
			position := p;
			count := 0;
			!!text.make (0,0);
		end;


	infix "<" (other: like Current): BOOLEAN is
		local
			different: BOOLEAN;
			i: INTEGER;
		do
			from
				i := 0
			until 
				different 
				or i >= count
				or i >=  other.count
			loop
				if other /= void then
					Result := (text.item(i)) < (other.text.item(i));
					different := not (text.item(i)).is_equal 
												(other.text.item(i));
					i := i + 1
				end;
				if not different then
					Result := count < other.count
				end;
			end;
		end;

	is_equal (other: like Current): BOOLEAN is
		local
			i : INTEGER;
		do
			if other /= void then
				if  other.count = count then
					Result := true;
					from
						i := 0
					until
						not Result 
						or i >= count
					loop
						Result := (text.item (i)).is_equal (other.text.item (i));
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
			text.force (s, count);
			count := count + 1;
		end;

	same_as (other: like Current): BOOLEAN is
			-- are the two comments the same. Useful for merging
			-- categories
		local
			i : INTEGER;	
		do
			Result := count = other.count;
			from
				i := 1;
			until
				not Result or i > count
			loop
				if text.item (i).is_equal (other.text.item (i)) then
					i := i + 1;
				else
					Result := false;
				end;
			end;
		end;
		
				
			
			

	
	text: ARRAY [STRING];


end
		
		
