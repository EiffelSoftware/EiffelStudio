indexing
	description: "[
		Objects that allow multiple strings to be displayed
		in an EV_LIST.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ORDERED_STRING_HANDLER

create
	make_with_textable
	
feature {NONE} -- Initialization

	make_with_textable (a_list: EV_LIST) is
			-- Create current with `a_text' assigned
			-- to `text'.
		do
			internal_list := a_list
		end

feature -- Status setting

	record_string (new_string: STRING) is
			-- Add `new_string' to strings held by
			-- `Current'. If new_string does not end in "%N"
			-- then append "%N"
		require
			new_string_not_void: new_string /= Void
		local
			list_item: EV_LIST_ITEM
		do
			new_string.replace_substring_all ("%N", "   ")
			create list_item.make_with_text ("<" + (internal_list.count + 1).out + "> " + new_string)
			internal_list.extend (list_item)
			if internal_list.is_displayed then
				internal_list.ensure_item_visible (internal_list.i_th (internal_list.count))
			end
		ensure
			internal_count_increased: internal_list.count = old internal_list.count + 1
		end
		
	reset is
			-- Reset `Current'.
		do
			internal_list.wipe_out
		ensure
			internal_list.is_empty
		end
		

feature {NONE} -- Implementation

	internal_list: EV_LIST

invariant
	internal_list_not_void: internal_list /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class ORDERED_STRING_HANDLER
