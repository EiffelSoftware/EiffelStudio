indexing

	description:
		"Array resource with a text field.";
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

creation
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
					file.putstring ("%"%"");
				else
					file.putchar ('%"')
					txt := clone (ar.value);
					txt.replace_substring_all ("%N", "");
					file.putstring (txt)
					file.putchar ('%"')
				end
			elseif text.text.is_empty then
				file.putstring ("%"%"")
			else
				file.putchar ('%"')
				txt := text.text;
				txt.replace_substring_all ("%N", "");
				file.putchar ('%"')
			end
		end

feature -- Access

	modified_resource: CELL2 [RESOURCE, RESOURCE] is
			-- Modified resource
		local
			new_res: like associated_resource
		do
			!! new_res.make_with_values (associated_resource.name, array_from_text);
			!! Result.make (associated_resource, new_res)
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
			!! rt.make (0);
			txt := text.text;
			txt.replace_substring_all ("%N", "");
			rt.put (txt, "dummy");
			Result := rt.get_array ("dummy", <<>>)
		end;

end -- class ARRAY_PREF_RES
