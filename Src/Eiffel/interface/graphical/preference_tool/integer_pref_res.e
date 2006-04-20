indexing

	description:
		"An Integer resource with an edit field."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class INTEGER_PREF_RES

inherit
	PREFERENCE_RESOURCE
		redefine
			associated_resource
		end

create
	make

feature -- Validation

	validate is
			-- Validate Current's new value.
		local
			str: STRING
		do
			if text /= Void then
				str := text.text;
				if not str.is_equal (associated_resource.value) then
					if not str.is_integer then
						is_resource_valid := False;
						raise_warner ("an integer");
					else
						is_resource_valid := True
					end
				else
					is_resource_valid := True
				end
			else
				is_resource_valid := True
			end
		end

feature -- Element change

	reset is
			-- Reset the text field.
		do
			text.set_text (associated_resource.value);
		end;

feature {PREFERENCE_CATEGORY} -- User Interface

	init (a_parent: COMPOSITE) is
			-- Display Current
		do
			form_make ("", a_parent);

			create name_label.make (associated_resource.visual_name, Current);
			create text.make ("", Current);

			attach_top (name_label, 1);
			attach_bottom (name_label, 1);
			attach_left (name_label, 1);

			attach_top (text, 1);
			attach_bottom (text, 1);
			attach_left_widget (name_label, text, 5);
			attach_right (text, 1)
			text.add_activate_action (Current, Void);
			text.set_width (250);
		end

feature {PREFERENCE_CATEGORY} -- Access

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current to `file'.
		local
			ar: like associated_resource
		do
			ar := associated_resource
			if text = Void or else ar.value.is_equal (text.text) then
					--| text /= Void means: text has been displayed
					--| and thus the user could have changed the value.
				file.put_string (ar.value)
			else
				file.put_string (text.text)
			end;
		end

	is_changed: BOOLEAN is
			-- Is Current changed by the user?
		do
			if text /= Void and then not associated_resource.value.is_equal (text.text) then
				Result := True
			end
		end;

	modified_resource: CELL2 [RESOURCE, RESOURCE] is
			-- Modified resource
		local
			new_res: like associated_resource
		do
			create new_res.make_with_values (associated_resource.name, text.text.to_integer);
			create Result.make (associated_resource, new_res)
		end

feature {NONE} -- Properties

	associated_resource: INTEGER_RESOURCE;
			-- Resource Current represnts

	text: TEXT_FIELD;
			-- Text field to represent Current's value

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

end -- class STRING_PREF_RES
