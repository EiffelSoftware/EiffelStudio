indexing
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

--  Bitmap_resource -> "BITMAP" Load_and_mem filename

class BITMAP_RESOURCE

inherit
	S_BITMAP_RESOURCE
		redefine 
			pre_action, post_action
		end

	TABLE_OF_SYMBOLS
		undefine
			is_equal, copy
		end

creation
	make

feature 

	pre_action is
		local
			bitmap: TDS_BITMAP
		do     
			!! bitmap.make
			bitmap.set_id (tds.last_token)
			tds.insert_resource (bitmap)

			tds.set_current_resource (bitmap)
		end

	post_action is
		local
			bitmap: TDS_BITMAP
		do
			bitmap ?= tds.current_resource
			bitmap.set_filename (tds.last_token)
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
end -- class BITMAP_RESOURCE
