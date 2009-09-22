note

	description:
		"Run time value representing an expanded object."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	EXPANDED_VALUE

inherit
	REFERENCE_VALUE
		redefine
			set_hector_addr,
			type_and_value, expandable,
			children, kind, output_value, dump_value,
			debug_value_type_id
		end

create {DEBUG_VALUE_EXPORTER}
	make_attribute_of_special

feature {DEBUG_VALUE_EXPORTER}

	make_attribute_of_special (attr_name: like name; a_class: like e_class;
			type: like dynamic_type_id; a_add: like address)
		require
			not_attr_name_void: attr_name /= Void
		do
			is_expanded := True
			name := attr_name
			if a_class /= Void then
				e_class := a_class
				is_attribute := True
			end
			dynamic_type_id := type
			address := a_add
			is_null := False
			create attributes.make (10)
		end

feature -- Property

	attributes: DS_ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]
			-- Attributes of expanded object
			--| FIXME JFIAT 2004/05/27 : used to be declared SORTED_TWO_WAY_LIST
			--| should we change that back ?

feature -- Access

	dump_value: DUMP_VALUE
			-- Dump_value corresponding to `Current'.
		do
			Result := Debugger_manager.Dump_value_factory.new_expanded_object_value (address, dynamic_class)
		end

feature {NONE} -- Output

	output_value: STRING_32
			-- Return a string representing `Current'.
		once
			Result := "Expanded object"
		end

	type_and_value: STRING_32
			-- Return a string representing `Current'.
		local
			ec: CLASS_C;
		do
			ec := dynamic_class
			create Result.make (60)
			if ec /= Void then
				Result.append (ec.name_in_upper)
				Result.append (Expanded_label)
			else
				Result.append (Any_class.name_in_upper)
				Result.append (Expanded_label)
			end
		end

feature -- Output

	expandable: BOOLEAN
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)
		do
			Result :=	attributes /= Void and then
						not attributes.is_empty and then
						dynamic_class /= Void
		end

	children: DS_LIST [ABSTRACT_DEBUG_VALUE]
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			Result := attributes
		end

	kind: INTEGER
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			Result := Expanded_value
		end

feature {NONE} -- Constants

	Expanded_label: STRING = " (expanded)"

feature {NONE} -- Implementation

	set_hector_addr
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		local
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
		do
			if address /= Void and then not address.is_void then
				address := keep_object_as_hector_address (address)
			end
			from
				l_cursor := attributes.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_cursor.item.set_hector_addr
				l_cursor.forth
			end
		end

feature {DEBUGGER_TEXT_FORMATTER_VISITOR} -- Debug value type id

	debug_value_type_id: INTEGER
		do
			Result := expanded_value_id
		end

invariant

	is_attribute: is_attribute;
	attributes_exists: attributes /= Void

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class EXPANDED_VALUE
