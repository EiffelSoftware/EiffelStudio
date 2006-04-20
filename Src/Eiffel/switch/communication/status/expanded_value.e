indexing

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
		rename
			make_attribute as ref_make_attribute
		redefine
			set_hector_addr, append_to,
			append_type_and_value,
			type_and_value, expandable,
			children, kind, append_value,
			output_value, dump_value
		end

create {DEBUG_VALUE_EXPORTER}

	make_attribute

feature {DEBUG_VALUE_EXPORTER}

	make_attribute (attr_name: like name; a_class: like e_class;
			type: like dynamic_type_id) is
		require
			not_attr_name_void: attr_name /= Void
		do
			name := attr_name;
			dynamic_type_id := type;
			if a_class /= Void then
				e_class := a_class;
				is_attribute := True;
			end;
			create attributes.make (10)
		end;

feature -- Property

	attributes: DS_ARRAYED_LIST [ABSTRACT_DEBUG_VALUE]
			-- Attributes of expanded object
			--| FIXME JFIAT 2004/05/27 : used to be declared SORTED_TWO_WAY_LIST
			--| should we change that back ?

feature -- Output

	append_to (st: TEXT_FORMATTER; indent: INTEGER) is
			-- Append `Current' to `st' with `indent' tabs the left margin.
		local
			ec: CLASS_C;
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
		do
			append_tabs (st, indent);
			st.add_feature_name (name, e_class)
			st.add_string (": expanded ");
			ec := dynamic_class;
			if ec /= Void then
				ec.append_name (st);
				st.add_new_line;
				append_tabs (st, indent + 1);
				st.add_string ("-- begin sub-object --");
				st.add_new_line;
				from
					l_cursor := attributes.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					l_cursor.item.append_to (st, indent + 2);
					l_cursor.forth
				end;
				append_tabs (st, indent + 1);
				st.add_string ("-- end sub-object --");
				st.add_new_line
			else
				Any_class.append_name (st);
				st.add_string (" = Unknown")
			end
		end;

feature -- Access

	dump_value: DUMP_VALUE is
			-- Dump_value corresponding to `Current'.
		do
			create Result.make_expanded_object (dynamic_class)
		end

feature {ABSTRACT_DEBUG_VALUE} -- Output

	append_type_and_value (st: TEXT_FORMATTER) is
		local
			ec: CLASS_C;
		do
			ec := dynamic_class
			if ec /= Void then
				ec.append_name (st)
			end
		end;

feature {NONE} -- Output

	append_value (st: TEXT_FORMATTER) is
			-- Append value of `Current' to `st' with `indent' tabs the left margin.
		local
			ec: CLASS_C
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
		do
			ec := dynamic_class;
			if ec /= Void then
				st.add_string ("-- begin sub-object --");
				st.add_new_line;
				from
					l_cursor := attributes.new_cursor
					l_cursor.start
				until
					l_cursor.after
				loop
					l_cursor.item.append_to (st, 2);
					l_cursor.forth
				end;
				append_tabs (st, 1);
				st.add_string ("-- end sub-object --");
				st.add_new_line
			else
				Any_class.append_name (st);
				st.add_string (" = Unknown")
			end
		end;

	output_value: STRING is "Expanded object"
			-- Return a string representing `Current'.

	type_and_value: STRING is
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

	expandable: BOOLEAN is
			-- Does `Current' have sub-items? (Is it a non void reference, a special object, ...)
		do
			Result :=	attributes /= Void and then
						not attributes.is_empty and then
						dynamic_class /= Void
		end

	children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- List of all sub-items of `Current'. May be void if there are no children.
			-- Generated on demand.
		do
			Result := attributes
		end

	kind: INTEGER is
			-- Actual type of `Current'. cf possible codes underneath.
			-- Used to display the corresponding icon.
		do
			Result := Expanded_value
		end

feature {NONE} -- Constants

	Expanded_label: STRING is " (expanded)"

feature {NONE} -- Implementation

	set_hector_addr is
			-- Convert the physical addresses received from the application
			-- to hector addresses. (should be called only once just after
			-- all the information has been received from the application.)
		local
			l_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
		do
			from
				l_cursor := attributes.new_cursor
				l_cursor.start
			until
				l_cursor.after
			loop
				l_cursor.item.set_hector_addr;
				l_cursor.forth
			end;
		end;

invariant

	is_attribute: is_attribute;
	attributes_exists: attributes /= Void

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

end -- class EXPANDED_VALUE
