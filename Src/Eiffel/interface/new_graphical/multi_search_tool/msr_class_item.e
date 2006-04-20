indexing
	description: "Objects that represent classes found in text or non-class section of text"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MSR_CLASS_ITEM

inherit
	MSR_ITEM
		rename
			make as make_item
		end 
		
create
	make

feature {NONE} -- Initialization
	
	make (a_name: like class_name; a_path: like path; a_text: MSR_STRING_ADAPTER) is
			-- Initialization, set `context_text_internal' and `text_internal' with "-"	
		require	
			name_attached: a_name /= Void
			not_name_is_empty: not a_name.is_empty
			path_attached: a_path /= Void
			text_attached: a_text /= Void
		do
			make_item (a_name, a_path, a_text)
		end	

feature -- Access
	
	start_index : INTEGER is
			-- 	This property in a class item takes no sense, 1 returned.
		do
			Result := 1
		ensure then
			start_index_equal_one: Result = 1
		end
			
	end_index : INTEGER is
			-- 	This property in a class item takes no sense, 0 returned. 
		do
			Result := 0
		ensure then
			end_index_equal_zero: Result = 0
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

end -- class MSR_CLASS_ITEM
