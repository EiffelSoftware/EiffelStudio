indexing
	description: "Objects that is a common base class for bon figures."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BON_FIGURE
	
inherit
	BON_CONSTANTS

feature -- Status report

	is_high_quality: BOOLEAN
			-- Is `Current' rendered with high quality?

feature -- Status settings

	enable_high_quality is
			-- Enable high quality.
		do
			set_is_high_quality (True)
		ensure
			high_quality: is_high_quality
		end
		
	disable_high_quality is
			-- Disable high quality.
		do
			set_is_high_quality (False)
		ensure
			low_quality: not is_high_quality
		end
		
feature {NONE} -- Implementation

	is_storable: BOOLEAN is
			-- 
		do
			Result := model.is_needed_on_diagram
		end

	model: ES_ITEM is
			-- Model for `Current'.
		deferred
		end

	is_needed_on_diagram_string: STRING is "IS_NEEDED_ON_DIAGRAM"

	set_is_high_quality (a_high_quality: like is_high_quality) is
			-- Set `is_high_quality' to `a_high_quality'.
		deferred
		ensure
			is_high_quality_assigned: is_high_quality = a_high_quality
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

end -- class BON_FIGURE
