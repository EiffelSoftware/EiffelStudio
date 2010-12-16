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

end
