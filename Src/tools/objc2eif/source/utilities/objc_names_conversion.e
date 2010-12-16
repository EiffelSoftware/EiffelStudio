note
	description: "Utilities to convert Objective-C names to eiffel"
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_NAMES_CONVERSION

feature -- Conversion

	objc_class_name_to_eiffel_style (an_objc_class_name: STRING): STRING
			-- Convert an Objective-C class name into an Eiffel style class name
			-- Example: NSApplication is translated to NS_APPLICATION.
		require
			a_valid_objc_class_name: an_objc_class_name.count >= 4
		local
			current_character: CHARACTER
			count: INTEGER
			i: INTEGER
		do
			count := an_objc_class_name.count
			from
				Result := an_objc_class_name.substring (1, 2)
				i := 3
				if an_objc_class_name[i].is_upper and i <= count - 1 and then an_objc_class_name[i + 1].is_upper then
					Result.append ("_")
				end
			until
				i > count
			loop
				current_character := an_objc_class_name [i]
				if
					current_character.is_upper and
					((i <= count - 1 and then not an_objc_class_name [i + 1].is_upper) or an_objc_class_name [i - 1].is_lower)
				then
					Result.append ("_")
				end
				Result.append (current_character.out)
				i := i + 1
			end
			Result.to_upper
		end

	objc_identifier_to_eiffel_style (an_objc_identifier: STRING) : STRING
			-- Convert an Objective-C identifier name into an Eiffel style identifier
		local
			current_character: CHARACTER
			count: INTEGER
			i: INTEGER
		do
			count := an_objc_identifier.count
			from
				create Result.make_empty
				i := 1
			until
				i > count
			loop
				current_character := an_objc_identifier [i]
				if
					current_character.is_upper and
					((i <= count - 1 and then not an_objc_identifier [i + 1].is_upper) or (i > 1 and then an_objc_identifier [i - 1].is_lower))
				then
					Result.append ("_")
				end
				Result.append (current_character.out)
				i := i + 1
			end
			Result.to_lower
		end

	eiffel_name_for_objc_method (m: OBJC_METHOD_DECL): STRING
			-- Return an method name in Eiffel style given an Objective-C method declaration.
		do
			Result := objc_identifier_to_eiffel_style (m.selector_name.twin)
			Result.replace_substring_all (":", "__")
			if Result.ends_with ("__") then
				Result.remove_tail (1)
			end
			if
				Result.is_equal ("class") or
				Result.is_equal ("prefix") or
				Result.is_equal ("result") or
				Result.is_equal ("attribute") or
				Result.is_equal ("copy") or
				Result.is_equal ("print")
			then
				Result.append ("_objc")
			end
		end

end
