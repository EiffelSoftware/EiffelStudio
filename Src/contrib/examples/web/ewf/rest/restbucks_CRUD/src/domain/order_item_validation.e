note
	description: "Summary description for {ORDER_ITEM_VALIDATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	ORDER_ITEM_VALIDATION

feature -- Access

	is_valid_coffee_type (a_type: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_type' a valid coffee type
		do
			Result := across coffe_types as ic some a_type.is_case_insensitive_equal (ic.item) end
		end

	Coffe_types: ARRAY [STRING]
			-- List of valid Coffee types
		once
			Result := <<"late", "cappuccino", "expresso">>
		end

	is_valid_milk_type (a_type: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_type' a valid milk type
		do
			Result := across milk_types as ic some a_type.is_case_insensitive_equal (ic.item) end
		end

	Milk_types: ARRAY [STRING]
			-- List of valid Milk types
		once
			Result := <<"skim", "semi", "whole">>
		end

	is_valid_size_option (a_option: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_option' a valid size option
		do
			Result := across size_options as ic some a_option.is_case_insensitive_equal (ic.item) end
		end

	Size_options: ARRAY [STRING]
			-- List of valid Size_options
		once
			Result := <<"small", "medium", "large">>
		end

note
	copyright: "2011-2017, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"

end
