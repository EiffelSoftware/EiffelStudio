indexing

	description:
		"Array resource with a text field."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class ARRAY_PREF_RES

inherit
	STRING_PREF_RES
		rename
			init as string_init
		redefine
			associated_resource, validate, text,
			modified_resource, reset, save_value
		end
	STRING_PREF_RES
		redefine
			associated_resource, validate, text, init,
			modified_resource, reset, save_value
		select
			init
		end

create
	make

feature -- Validation

	validate is
			-- Validate Current's new value.
		do
			is_resource_valid := (text /= Void and then
				associated_resource.is_valid (text.text)) or else
				text = Void
			if not is_resource_valid then
				raise_warner ("an array")
			end
		end

feature -- Element change

	reset is
		do
			text.set_text (associated_resource.value);
		end;

feature -- Output

	save_value (file: PLAIN_TEXT_FILE) is
			-- Save Current.
		local
			ar: like associated_resource;
			txt: STRING
		do
			ar := associated_resource
			if text = Void or else equal (ar.value, (text.text)) then
					--| text /= Void means text has been displayed
					--| and thus the user could have changed the value.
				if ar.value = Void or else ar.value.is_empty then
					file.put_string ("%"%"");
				else
					file.put_character ('%"')
					txt := clone (ar.value);
					txt.replace_substring_all ("%N", "");
					file.put_string (txt)
					file.put_character ('%"')
				end
			elseif text.text.is_empty then
				file.put_string ("%"%"")
			else
				file.put_character ('%"')
				txt := text.text;
				txt.replace_substring_all ("%N", "");
				file.put_character ('%"')
			end
		end

feature -- Access

	modified_resource: CELL2 [RESOURCE, RESOURCE] is
			-- Modified resource
		local
			new_res: like associated_resource
		do
			create new_res.make_with_values (associated_resource.name, array_from_text);
			create Result.make (associated_resource, new_res)
		end;

feature {PREFRENCE_CATEGORY} -- Output

	init (a_parent: COMPOSITE) is
			-- Display Current
		do
			string_init (a_parent);
			text.set_rows (6);
			text.set_width (150);
		end

feature {NONE} -- Properties

	text: SCROLLED_T;

	associated_resource: ARRAY_RESOURCE
			-- Resource Current represents

	array_from_text: ARRAY [STRING] is
			-- Array from the text field
		require
			valid_text: text /= Void
		local
			rt: RESOURCE_TABLE ;
			txt: STRING
		do
			create rt.make (0);
			txt := text.text;
			txt.replace_substring_all ("%N", "");
			rt.put (txt, "dummy");
			Result := rt.get_array ("dummy", <<>>)
		end;

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

end -- class ARRAY_PREF_RES
