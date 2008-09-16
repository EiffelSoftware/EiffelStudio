indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ABSTRACT_SPECIAL_VALUE

inherit

	ABSTRACT_DEBUG_VALUE
		rename
			reset_children as reset_items
		redefine
			address, sorted_children,
			debug_value_type_id,
			reset_items
		end

feature -- Items

	items_computed: BOOLEAN
			-- `items' already computed in this context ?

	get_items (a_min, a_max: INTEGER) is
		require
			items_not_void: items /= Void
		deferred
		ensure
			items_computed
		end

	reset_items is
		do
			if items /= Void then
				items.wipe_out
			else
				create items.make (0)
			end
			items_computed := False
		ensure then
			not items_computed
		end

feature -- Properties

	is_null: BOOLEAN
			-- Is Current represents Void object
			-- equivalent to `(address = Void)'

	address: DBG_ADDRESS
			-- Address of object
			--| In Classic, because the socket is already busy we cannot ask the
			--| application for the hector address during the object
			--| inspection. This should be done latter with `set_hector_addr'.)

	items: DS_ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]
			-- List of SPECIAL items

	capacity: INTEGER
			-- Number of items that SPECIAL object may hold

	sp_lower, sp_upper: INTEGER
			-- Bounds for special object inspection

feature -- Output

	sorted_children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- Return items as childrens.
		do
			Result := children
		end

	expandable: BOOLEAN is
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)
		do
			Result := not is_null
		end

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			if is_null then
				Result := Void_value
			else
				Result := Special_value
			end
		end

feature {DEBUG_VALUE_EXPORTER} -- Output

	output_value: STRING_32 is
			-- Return a string representing `Current'.
		local
			str: STRING_32
		do
			if address = Void then
				Result := NONE_representation
			else
				Result := Left_address_delim + address.output + Right_address_delim
				str := string_value.as_string_8
				if str /= Void then
					Result.append (Equal_sign_str)
					Result.append (str)
				end
			end
		end

	type_and_value: STRING_32 is
			-- Return a string representing `Current'.
		local
			ec: CLASS_C;
		do
			if address = Void then
				Result := NONE_representation
			else
				ec := dynamic_class;
				if ec /= Void then
					create Result.make (60)
					Result.append (ec.name_in_upper)
					Result.append (output_value)
				else
					create Result.make (15)
					Result.append (Any_class.name_in_upper)
					Result.append (Is_unknown)
				end
			end
		end

feature -- Change

	set_sp_bounds (l, u: INTEGER) is
			-- Set the bounds for special object inspection.
		do
			sp_lower := l
			sp_upper := u
		end

feature -- Access

	string_value: STRING_GENERAL is
		deferred
		end

feature {DEBUGGER_TEXT_FORMATTER_VISITOR} -- Debug value type id

	debug_value_type_id: INTEGER is
		do
			Result := abstract_special_value_id
		end

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

end -- class ABSTRACT_SPECIAL_VALUE
