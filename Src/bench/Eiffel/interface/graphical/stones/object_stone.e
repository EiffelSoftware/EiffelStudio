class OBJECT_STONE 

inherit

	UNFILED_STONE

creation

	make
	
feature -- making

	make (addr: STRING) is
		do
			object_address := addr;
		end;
 
	object_address: STRING;

feature -- dragging

	origin_text: STRING is
		local
			tout_req: TOUT_REQUEST;
			i, j, sp: INTEGER;
			os: OBJECT_STONE;
			cs: CLICK_STONE;
			ll: LINKED_LIST [CLICK_STONE]
		do
			!! tout_req.make (object_address);
			!! ll.make;
			tout_req.send;
			Result := tout_req.tout_value;
				-- Compute click list
			from
				i := 1;
			until
				i > Result.count
			loop
				if Result.item (i) = '[' then
					sp := i
				elseif Result.item (i) = ']' then
					!! os.make (Result.substring (sp+1,i-1));
					!! cs.make (os, sp, i);
					j := j + 1;
					ll.add (cs);
					sp := 0
				end;	
				i := i + 1;
			end;
			from
				ll.start;
				!! click_list.make (1, ll.count);
				i := 1
			until
				ll.after
			loop
				click_list.put (ll.item, i);
				i := i + 1;
				ll.forth
			end;
		end;

	stone_type: INTEGER is do Result := Object_type end;
 
	stone_name: STRING is do Result := l_Object end;

	signature: STRING is
		do
			Result := "Object at ";
			Result.append (object_address)
		end;
 
	click_list: ARRAY [CLICK_STONE];
 
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
		do
			Result := True
		end

end
