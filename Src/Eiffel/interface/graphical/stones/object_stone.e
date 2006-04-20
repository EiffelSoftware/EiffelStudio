indexing

	description: 
		"Stone representing an object address."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class OBJECT_STONE 

inherit

	STONE
		redefine
			is_valid, synchronized_stone, same_as, history_name
		end;
	SHARED_APPLICATION_EXECUTION
	
create

	make
	
feature {NONE} -- Initialization

	make (addr: STRING; a_name: STRING; dclass: CLASS_C) is
		require
			not_addr_void: addr /= Void;
			dclass_exists: dclass /= Void;
			not_name_void: a_name /= Void
		do
			name := a_name;
			object_address := addr;
			dynamic_class := dclass
		end;
 
feature -- Properties

	name: STRING;
			-- Name associated with address (arg, local, result)

	object_address: STRING;
			-- Hector address (with an indirection)

	dynamic_class: CLASS_C;
			-- Class associated with dynamic type of `Current'

feature -- Access

	origin_text: STRING is "";

	stone_type: INTEGER is
		do
			Result := Object_type
		end;

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Object
		end;
 
	x_stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_object
		end;
 
	stone_name: STRING is
		do
			Result := Interface_names.s_Object_stone
		end;

	stone_signature: STRING is
		do
			create Result.make (0);
			Result.append (name);
			Result.append (": ");
			Result.append (dynamic_class.name_in_upper)
			Result.append (" object at ");
			Result.append (object_address)
		end;
 
	icon_name: STRING is
		do
			Result := stone_signature
		end;
 
	clickable: BOOLEAN is True;
			-- Is Current an element with recorded structures information?

	click_list: ARRAY [CLICK_STONE];

	history_name: STRING is
			-- Name used in the history list
		do
			create Result.make (0);
			Result.append (name);
			Result.append (": ");
			Result.append (dynamic_class.name_in_upper)
			Result.append (" [");
			Result.append (object_address);
			Result.append ("]");
		end;

feature -- Status report

	same_as (other: STONE): BOOLEAN is
			-- Do `Current' and `other' reference the same object?
		local
			o: like Current
		do
			o ?= other;
			if object_address /= Void and then o /= Void and then
					o.object_address /= Void then
				Result := object_address.is_equal (o.object_address)
			else
				Result := object_address = Void and
					(o /= Void and then o.object_address = Void)
			end
		end;

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			Result := Application.is_running and then
					Application.is_stopped and then
					Application.is_valid_object_address (object_address)
		end;

	synchronized_stone: OBJECT_STONE is
			-- Clone of `Current' after an execution step
			-- (May be Void if not valid anymore)
		do
			if is_valid then
				Result := clone (Current)
			end
		end;

feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			hole.process_object (Current)
		end;

invariant

	address_exists: object_address /= Void;
	dynamic_class_exists: dynamic_class /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class OBJECT_STONE
