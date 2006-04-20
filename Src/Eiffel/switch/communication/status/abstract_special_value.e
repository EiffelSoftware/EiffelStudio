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
		redefine
			append_to, address, sorted_children
		end

	SHARED_DEBUG
		export
			{NONE} all
		undefine
			is_equal
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
		ensure
			not items_computed
		end

feature -- Properties

	is_null: BOOLEAN
			-- Is Current represents Void object
			-- equivalent to `(address = Void)'

	address: STRING;
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

feature -- Output

	append_to (st: TEXT_FORMATTER; indent: INTEGER) is
			-- Append `Current' to `st' with `indent' tabs the left margin.
		local
			status: APPLICATION_STATUS
			is_special_of_char: BOOLEAN
			char_value: CHARACTER_VALUE
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
		do
			append_tabs (st, indent);
			st.add_feature_name (name, e_class);
			st.add_string (": ");
			dynamic_class.append_name (st);
			st.add_string (Left_address_delim);
			status := Application.status;
			if status /= Void and status.is_stopped then
				st.add_address (address, name, dynamic_class)
			else
				st.add_string (address)
			end
			st.add_string (Right_address_delim);
			st.add_new_line;
			append_tabs (st, indent + 1);
			st.add_string ("-- begin special object --");
			st.add_new_line;
			if sp_lower > 0 then
				append_tabs (st, indent + 2);
				st.add_string ("... Items skipped ...");
				st.add_new_line
			end

			l_cursor := items.new_cursor
			if items.count /= 0 then
				l_cursor.start
				char_value ?= l_cursor.item
				is_special_of_char := char_value /= Void
			end
			if not is_special_of_char then
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					l_cursor.item.append_to (st, indent + 2);
					l_cursor.forth
				end;
			else
				st.add_string ("%"")
				from
					l_cursor.start
				until
					l_cursor.after
				loop
					char_value ?= l_cursor.item
					check
						valid_character_element: char_value /= Void
					end
					st.add_char (char_value.value)
					l_cursor.forth
				end;
				st.add_string ("%"")
				st.add_new_line
			end
			if 0 <= sp_upper and sp_upper < capacity - 1 then
				append_tabs (st, indent + 2);
				st.add_string ("... More items ...");
				st.add_new_line
			end;
			append_tabs (st, indent + 1);
			st.add_string ("-- end special object --");
			st.add_new_line
		end;

feature {NONE} -- Output

	output_value: STRING is
			-- Return a string representing `Current'.
		local
			str: STRING
		do
			if address = Void then
				Result := NONE_representation
			else
				Result := Left_address_delim + address + Right_address_delim
				str := string_value
				if str /= Void then
					Result.append (Equal_sign_str)
					Result.append (str)
				end
			end
		end

	type_and_value: STRING is
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

	string_value: STRING is
		deferred
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
