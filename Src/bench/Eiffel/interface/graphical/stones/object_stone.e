class OBJECT_STONE 

inherit

	UNFILED_STONE
		redefine
			is_valid, synchronized_stone, is_equal
		end;

	SHARED_DEBUG
		redefine
			is_equal
		end;

	OBJECT_ADDR
		redefine
			is_equal
		end
	
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
 
feature -- Access

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

feature -- Status report

	is_equal (other: like Current): BOOLEAN is
			-- Do `Current' and `other' reference the same object?
		do
			Result := object_address.is_equal (other.object_address)
		end;

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			Result := Run_info.is_running and then
					Run_info.is_stopped and then
					is_hector_addr (object_address)
		end;

	synchronized_stone: OBJECT_STONE is
			-- Clone of `Current' after an execution step
			-- (May be Void if not valid anymore)
		do
			if is_valid then
				Result := clone (Current)
			end
		end;

invariant

	address_exists: object_address /= Void;
	dynamic_class_exists: dynamic_class /= Void

end -- class OBJECT_STONE
