class OBJECT_STONE 

inherit

	UNFILED_STONE
	
creation

	make
	
feature -- making

	make (addr: STRING; dclass: CLASS_C) is
		require
			not_addr_void: addr /= Void;
			dclass_exists: dclass /= Void
		do
			object_address := addr;
			dynamic_class := dclass
		end;
 
	object_address: STRING;
			-- Hector address (with an indirection)

	dynamic_class: CLASS_C;
			-- Class associated with dynamic type of `Current'

feature -- dragging

	origin_text: STRING is "";

	stone_type: INTEGER is do Result := Object_type end;
 
	stone_name: STRING is do Result := l_Object end;

	signature: STRING is
		do
			Result := "object at ";
			Result.append (object_address)
		end;
 
	icon_name: STRING is
		do
			Result := signature
		end;
 
feature -- Clickable
	
	clickable: BOOLEAN is True;
			-- Is Current an element with recorded structures information?

	click_list: ARRAY [CLICK_STONE];

invariant

	address_exists: object_address /= Void;
	dynamic_class_exists: dynamic_class /= Void

end -- class OBJECT_STONE
