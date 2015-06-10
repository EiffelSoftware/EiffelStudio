note
	description: "Summary description for {ITEM_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ITEM_CONSTANTS
feature -- Access
	is_valid_coffee_type (a_type: STRING) : BOOLEAN
		--is `a_type' a valid coffee type
		do
			a_type.to_lower
			coffe_types.compare_objects
			Result := coffe_types.has (a_type)
		end

    Coffe_types : ARRAY[STRING]
		-- List of valid Coffee types
		once
			Result := <<"late","cappuccino", "expresso">>
		end

	is_valid_milk_type (a_type: STRING) : BOOLEAN
		--is `a_type' a valid milk type
		do
			a_type.to_lower
			milk_types.compare_objects
			Result := milk_types.has (a_type)
		end

	Milk_types : ARRAY[STRING]
		-- List of valid Milk types
		once
			Result := <<"skim","semi", "whole">>
		end

	is_valid_size_option (an_option: STRING) : BOOLEAN
		--is `an_option' a valid size option
		do
			an_option.to_lower
			size_options.compare_objects
			Result := size_options.has (an_option)
		end

	Size_options :	ARRAY[STRING]
		-- List of valid Size_options
		once
			Result := <<"small","mediumn", "large">>
		end
note
	copyright: "2011-2012, Javier Velilla and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
