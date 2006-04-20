indexing

	description:
		"A String resource with an edit field."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class STRING_PREF_RES

inherit
	PREFERENCE_RESOURCE
		redefine
			associated_resource, validate
		end

create
	make

feature -- Validation

	validate is
			-- Validate Current's new value.
		do
			if text /= Void then
				if not text.text.is_empty then
					is_resource_valid := associated_resource.is_valid (text.text)
				else
					is_resource_valid := True
				end
			else
				is_resource_valid := True
			end
			if not is_resource_valid then
				raise_warner ("a string")
			end
		end

feature -- Element change

	reset is
			-- Reset the text field.
		local
			txt: STRING
		do
			txt := associated_resource.value;
			if txt /= Void then
				text.set_text (txt);
			end;
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

			text.set_width (250)
			text.add_activate_action (Current, Void);
		end

feature {PREFERENCE_CATEGORY} -- Access

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current.
		local
			ar: like associated_resource
		do
			ar := associated_resource
			if text = Void or else equal (ar.value, (text.text)) then
					--| text /= Void means text has been displayed
					--| and thus the user could have changed the value.
				if ar.value = Void or else ar.value.is_empty then
					file.put_string ("%"%"");
				else
					file.put_character ('%"')
					file_putstring (file, ar.value)
					file.put_character ('%"')
				end
			elseif text.text.is_empty then
				file.put_string ("%"%"")
			else
				file.put_character ('%"')
				file_putstring (file, text.text)
				file.put_character ('%"')
			end
		end;

	file_putstring (file: PLAIN_TEXT_FILE; s: STRING) is
		local
			index: INTEGER
			temp: STRING
			finished: BOOLEAN
		do
			if s.has ('%"') then
				from
					temp := clone (s)
					index := temp.index_of ('%"', 1)
				until
					index = 0 or finished
				loop
					temp.insert ("%%", index)
					index := index + 2
					if index < temp.count then
						index := temp.index_of ('%"', index)
					else
						finished := true
					end
				end

				file.put_string (temp)
			else
				file.put_string (s)
			end
		end;

	is_changed: BOOLEAN is
			-- Is Current changed by the user?
		do
			if text /= Void and then not equal (associated_resource.value, text.text) then
				Result := True
			end
		end;

	modified_resource: CELL2 [RESOURCE, RESOURCE] is
			-- Modified resource
		local
			new_res: like associated_resource
		do
			create new_res.make_with_values (associated_resource.name, text.text);
			create Result.make (associated_resource, new_res)
		end

feature {NONE} -- Properties

	associated_resource: STRING_RESOURCE;
			-- Resource Current represnts

	text: TEXT_FIELD;
			-- Edit box to represent Current's value

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
