class OBJECT_STONE 

inherit

	UNFILED_STONE;
	CLICK_WINDOW;
	SHARED_DEBUG;
	SHARED_WORKBENCH

creation

	make
	
feature -- making

	make (addr: STRING) is
		do
			object_address := addr;
			!! last_text.make (0);
			!! click_list.make (1, 0)
		end;
 
	object_address: STRING;
			-- Hector address (with an indirection)

feature -- dragging

	origin_text: STRING is
		local
			attr_req: ATTR_REQUEST;
			i: INTEGER;
			attributes: LIST [ATTRIBUTE];
			dynamic_type: STRING;
			obj_stone: OBJECT_STONE
		do
			if Run_info.is_running and then Run_info.is_stopped then
				!!attr_req.make (object_address);
				attr_req.send;
				!! tmp_click_list.make;
				!! last_text.make (50);
				dynamic_type := clone (attr_req.dynamic_type);
				dynamic_type.to_lower;
				put_clickable_string (Universe.class_stone (dynamic_type), 
														attr_req.dynamic_type);
				put_string (" [");
				put_clickable_string (Current, object_address);
				put_string ("]");
				new_line;
				attributes := attr_req.attributes;
				from
					attributes.start
				until
					attributes.after
				loop
					attributes.item.append_attribute (current, 1);
					attributes.forth
				end;
				from
					!! click_list.make (1, tmp_click_list.count);
					tmp_click_list.start;
					i := 1
				until
					tmp_click_list.after
				loop
					click_list.put (tmp_click_list.item, i);
					tmp_click_list.forth;
					i := i + 1
				end;
				tmp_click_list := Void;
				Result := last_text
			else
				from
					!! tmp_click_list.make;
					i := 1
				until
					i > click_list.count
				loop
					obj_stone ?= click_list.item (i).node;
					if obj_stone = Void then
						tmp_click_list.add (click_list.item (i))
					end;
					i := i + 1
				end;
				from
					!! click_list.make (1, tmp_click_list.count);
					tmp_click_list.start;
					i := 1
				until
					tmp_click_list.after
				loop
					click_list.put (tmp_click_list.item, i);
					tmp_click_list.forth;
					i := i + 1
				end;
				tmp_click_list := Void;
				Result := last_text
			end
		end;

	stone_type: INTEGER is do Result := Object_type end;
 
	stone_name: STRING is do Result := l_Object end;

	signature: STRING is
		do
			Result := "Object at ";
			Result.append (object_address)
		end;
 
	icon_name: STRING is
		do
			Result := signature
		end;
 
feature -- Clickable
	
	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
		do
			Result := True
		end;

	click_list: ARRAY [CLICK_STONE];

	last_text: STRING;

	put_string (s: STRING) is
			-- Append `s' to `last_string'.
		do
			last_text.append (s)
		end;

	put_char (c: CHARACTER) is
		do
			last_text.append_character (c)
		end;

	put_clickable_string (stone: STONE; s: STRING) is
			-- Append `s' to `last_string' and `stone' to `tmp_click_list'.
		local
			start_pos, end_pos: INTEGER;
			cs: CLICK_STONE
		do
			start_pos := last_text.count;
			end_pos := start_pos + s.count;
			!! cs.make (stone, start_pos, end_pos);
			tmp_click_list.add (cs);
			last_text.append (s)
		end;

	new_line is
		do
			last_text.append ("%N")
		end;

feature {NONE} -- Clickable

	tmp_click_list: LINKED_LIST [CLICK_STONE];

end -- class OBJECT_STONE
