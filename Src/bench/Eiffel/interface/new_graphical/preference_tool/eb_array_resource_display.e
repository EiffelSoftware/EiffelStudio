indexing

	description:
		"Array resource with a text field."
	date: "$Date$"
	revision: "$Revision$"

class EB_ARRAY_RESOURCE_DISPLAY

inherit
	EB_LINE_RESOURCE_DISPLAY
		redefine
			resource,
			make_with_resource
		end

creation
	make_with_resource

feature {NONE} -- Initialization

	make_with_resource (a_parent: EV_CONTAINER; a_resource: like resource) is
			-- Display Current
		local
			s: STRING
				-- used for appending `" : "'
		do
			Precursor (a_parent, a_resource)
--			set_minimum_height (130)
			set_expand (true)
				
		-- expand devrait etre a false, mais cela produit
		-- un bug d'affichage dans certaines conditions

			s := clone (a_resource.visual_name)
			s.append (" : ")
			Create name_label.make_with_text (Current, s)
			name_label.set_minimum_width (100)

			Create text.make_with_text (Current, resource.value)
			text.set_minimum_width (100)
--			text.add_activate_command (Current, Void)
			end

feature -- Validation

	validate is
			-- Validate Current's new value.
		do
			is_resource_valid := ((text = Void) or else
				(resource.is_valid (text.text)))
			if not is_resource_valid then
				raise_warner ("an array")
			end
		end

feature -- Element change

	reset is
		local
			s: STRING
		do
			s := text.text
			text.set_text (resource.value)
			s := text.text
		end

feature -- Output

    save_value (file: PLAIN_TEXT_FILE) is
            -- Save Current.
        local
            ar: like resource
			txt: STRING
        do
            ar := resource
            if text = Void or else equal (ar.value, (text.text)) then
                    --| text /= Void means text has been displayed
                    --| and thus the user could have changed the value.
                if ar.value = Void or else ar.value.empty then
                    file.putstring ("%"%"")
                else
                    if ar.value @ 1 /= '%"' then
                        file.putchar ('%"')
                    end
					txt := clone (ar.value)
					txt.replace_substring_all ("%N", "")
                    file.putstring (txt)
                    if ar.value @ ar.value.count /= '%"' then
                        file.putchar ('%"')
                    end
                end
            elseif text.text.empty then
                file.putstring ("%"%"")
            else
                if text.text @ 1 /= '%"' then
                    file.putchar ('%"')
                end
				txt := text.text
				txt.replace_substring_all ("%N", "")
				if text.text @ text.text.count /= '%"' then
					file.putchar ('%"')
				end
			end
		end

feature -- Access

	is_changed: BOOLEAN is
			-- Is Current changed by the user?
		do
			if text /= Void and then not equal (resource.value, text.text) then
				Result := True
			end
		end

	modified_resource: CELL2 [EB_RESOURCE, EB_RESOURCE] is
			-- Modified resource
		local
			new_res: like resource
		do
			!! new_res.make_with_values (resource.name, array_from_text)
			!! Result.make (resource, new_res)
		end

feature {NONE} -- Properties

	text: EV_TEXT

	resource: EB_ARRAY_RESOURCE
			-- Resource Current represents

	array_from_text: ARRAY [STRING] is
			-- Array from the text field
		require
			valid_text: text /= Void
		local
			rt: RESOURCE_TABLE
			txt: STRING
		do
			!! rt.make (0)
			txt := text.text
			txt.replace_substring_all ("%N", "")
			rt.put (txt, "dummy")
			Result := rt.get_array ("dummy", <<>>)
		end

end -- class EB_ARRAY_RESOURCE_DISPLAY
