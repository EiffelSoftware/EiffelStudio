note
	description: "[
		EiffelStudio's user interface resource recycler, used to free allocated resources after a piece of
		the UI is considered no longer usable.
			
		Object recycler for explicit recycling of active objects enabling
		disconnection between objects/agents that the GC is unable to recognize.
		
		Note: Class provides automatic recycling of referring objects by explict use of `auto_recycle'
		      and `delay_auto_recycle'.
		      Registration to action sequences can be performed though `register_action' and will be
		      automatically removed upon recycling.
		      
		      After recycling and all referring recyclable objects have been recycled all attributes
		      are automatically detached.
		      
		Special Note: EiffelVision2 objects that are recyclable (inheriting {EB_RECYCLABLE} are
		              automatically destroyed if you do not destroy them! This is true for all
		              automatically recycled referring objects. Saying that, it's better to be explicit
		              about destroying EiffelVision2 objects.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_RECYCLABLE

inherit
	EB_RECYCLABLE

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
