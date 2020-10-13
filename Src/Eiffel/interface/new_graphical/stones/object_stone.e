note
	description:
		"Stone representing an object address."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (addr: DBG_ADDRESS; a_name: STRING_32; dclass: CLASS_C)
		require
			not_addr_void: addr /= Void and then not addr.is_void
			dclass_exists: dclass /= Void
			not_name_void: a_name /= Void
		do
			class_make (dclass)
			name := a_name
			object_address := addr
			dynamic_class := dclass
		end

feature -- Properties

	name: STRING_32
			-- Name associated with address (arg, local, result)

	object_address: DBG_ADDRESS
			-- Hector address (with an indirection)

	dynamic_class: CLASS_C
			-- Class associated with dynamic type of `Current'

feature -- Access

	stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Object
		end

	x_stone_cursor: EV_POINTER_STYLE
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_object
		end

	stone_signature: STRING_32
		do
			create Result.make (0)
			Result.append (name)
			Result.append (": ")
			Result.append (dynamic_class.name_in_upper)
			Result.append (" object at ")
			Result.append (object_address.output)
		end

	history_name: STRING_32
			-- Name used in the history list
		do
			create Result.make (0)
			Result.append (name)
			Result.append (": ")
			Result.append (dynamic_class.name_in_upper)
			Result.append (" [")
			Result.append (object_address.output)
			Result.append ("]")
		end

	header: STRING_GENERAL
		do
			Result := history_name
		end

feature -- Status setting

	set_associated_ev_item (item: EV_ANY)
			-- Associate `Current' with a tree item in the object tree.
		do
			ev_item := item
		end

feature -- Status report

	same_as (other: STONE): BOOLEAN
			-- Do `Current' and `other' reference the same object?
		do
			if attached {like Current} other as o then
				if
					attached object_address as l_current_object_address and then
					attached o.object_address as l_other_object_address
				then
					Result := l_current_object_address.is_equal (l_other_object_address)
				else
					Result := object_address = Void and o.object_address = Void
				end
			end
		end

	is_valid: BOOLEAN
			-- Is `Current' a valid stone?
		do
			if
				attached debugger_manager as dbg and then
				dbg.application_is_executing
			then
				Result := attached dbg.application as app and then
						app.is_stopped and then
						app.is_valid_and_known_object_address (object_address)
			end
		end

	ev_item: EV_ANY
			-- Graphical item representing `Current'
			-- May be Void, even if `Current' is represented in an container widget.

invariant

	address_exists: object_address /= Void
	dynamic_class_exists: dynamic_class /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class OBJECT_STONE
