indexing
	description: 
		"Stone representing an object address."
	date: "$Date$"
	revision: "$Revision $"

class
	OBJECT_STONE 

inherit
	CLASSC_STONE
		rename
			make as class_make
		redefine
			is_valid, same_as, history_name,
			stone_signature, header, stone_cursor, x_stone_cursor
		end

	SHARED_APPLICATION_EXECUTION
	
creation
	make
	
feature {NONE} -- Initialization

	make (addr: STRING; a_name: STRING; dclass: CLASS_C) is
		require
			not_addr_void: addr /= Void
			dclass_exists: dclass /= Void
			not_name_void: a_name /= Void
		do
			class_make (dclass)
			name := a_name
			object_address := addr
			dynamic_class := dclass
		end
 
feature -- Properties

	name: STRING
			-- Name associated with address (arg, local, result)

	object_address: STRING
			-- Hector address (with an indirection)

	dynamic_class: CLASS_C
			-- Class associated with dynamic type of `Current'

feature -- Access

	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Object
		end
 
	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_object
		end
 
	stone_signature: STRING is
		do
			create Result.make (0)
			Result.append (name)
			Result.append (": ")
			Result.append (dynamic_class.name_in_upper)
			Result.append (" object at ")
			Result.append (object_address)
		end
 
	history_name: STRING is
			-- Name used in the history list
		do
			create Result.make (0)
			Result.append (name)
			Result.append (": ")
			Result.append (dynamic_class.name_in_upper)
			Result.append (" [")
			Result.append (object_address)
			Result.append ("]")
		end

	header: STRING is
		do
			Result := history_name
		end

feature -- Status setting

	set_associated_tree_item (item: EV_TREE_ITEM) is
			-- Associate `Current' with a tree item in the object tree.
		do
			tree_item := item
		end

feature -- Status report

	same_as (other: STONE): BOOLEAN is
			-- Do `Current' and `other' reference the same object?
		local
			o: like Current
		do
			o ?= other
			if object_address /= Void and then o /= Void and then
					o.object_address /= Void then
				Result := object_address.is_equal (o.object_address)
			else
				Result := object_address = Void and
					(o /= Void and then o.object_address = Void)
			end
		end

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			Result := Application.is_running and then
					Application.is_stopped and then
					Application.is_valid_object_address (object_address)
		end

	tree_item: EV_TREE_ITEM
			-- Tree item representing `Current' in the object tree.
			-- May be Void, even if `Current' is represented in the object tree.

invariant

	address_exists: object_address /= Void
	dynamic_class_exists: dynamic_class /= Void

end -- class OBJECT_STONE
