indexing
	description: "Colors displayed in edit_area"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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


end -- COLOR_CONSTANT