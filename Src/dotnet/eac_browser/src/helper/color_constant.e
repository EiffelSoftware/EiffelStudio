indexing
	description: "Colors displayed in edit_area"
	author: "Julien"
	date: "$Date$"
	revision: "$Revision$"

class
	COLOR_CONSTANT

create
	default_create

feature -- Initialization


	title_color: EV_COLOR is
			-- foreground color of titles (attributes, procedures, creation routines, functions).
		once
			create Result.make_with_8_bit_rgb (0, 0, 255) 
		ensure
			result_set: Result /= Void
		end

	type_color: EV_COLOR is
			-- foreground color of types.
		once
			create Result.make_with_8_bit_rgb (125, 125, 0) 
		ensure
			result_set: Result /= Void
		end

	eiffel_feature_color: EV_COLOR is
			-- foreground color of eiffel features name.
		once
			create Result.make_with_8_bit_rgb (0, 125, 0) 
		ensure
			result_set: Result /= Void
		end
		
	dotnet_feature_color: EV_COLOR is
			-- foreground color of dotnet features name.
		once
			create Result.make_with_8_bit_rgb (170, 0, 0) 
		ensure
			result_set: Result /= Void
		end

	argument_color: EV_COLOR is
			-- foreground color of arguments.
		once
			create Result.make_with_8_bit_rgb (0, 125, 0) 
		ensure
			result_set: Result /= Void
		end

	text_color: EV_COLOR is
			-- foreground color of text.
		once
			create Result.make_with_8_bit_rgb (0, 0, 0) 
		ensure
			result_set: Result /= Void
		end

	constant_color: EV_COLOR is
			-- foreground color of constants.
		once
			create Result.make_with_8_bit_rgb (110, 0, 100) 
		ensure
			result_set: Result /= Void
		end

	selected_feature_color: EV_COLOR is
			-- background color of the selected feature.
		once
			create Result.make_with_8_bit_rgb (195, 195, 195) 
		ensure
			result_set: Result /= Void
		end
		
	non_selected_feature_color: EV_COLOR is
			-- background color of non selected features.
		once
			create Result.make_with_8_bit_rgb (255, 255, 255) 
		ensure
			result_set: Result /= Void
		end
	
	
end -- COLOR_CONSTANT