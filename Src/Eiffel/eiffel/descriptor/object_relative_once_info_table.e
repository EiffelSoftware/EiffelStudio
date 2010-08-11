note
	description: "Summary description for {OBJECT_RELATIVE_ONCE_INFO_TABLE}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	OBJECT_RELATIVE_ONCE_INFO_TABLE

inherit
	HASH_TABLE [OBJECT_RELATIVE_ONCE_INFO, INTEGER]

create
	make

feature -- Element change

	remove_item_of_rout_id_set (a_rout_id_set: ROUT_ID_SET)
			-- Info about object relative once associated with Current and an item of `a_rout_id_set'
		require
			a_rout_id_set_not_void: a_rout_id_set /= Void
		local
			i, nb: INTEGER_32
		do
			from
				i := 1
				nb := a_rout_id_set.count
			until
				i > nb
			loop
				remove (a_rout_id_set.item (i))
				i := i + 1
			end
		end

feature -- Access

	item_of_rout_id (a_once_routine_id: INTEGER): detachable OBJECT_RELATIVE_ONCE_INFO
			-- Info about object relative once associated with Current and `a_once_routine_id'
		do
			Result := item (a_once_routine_id)
		end

	item_of_rout_id_set (a_rout_id_set: ROUT_ID_SET): detachable OBJECT_RELATIVE_ONCE_INFO
			-- Info about object relative once associated with Current and an item of `a_rout_id_set'
		require
			a_rout_id_set_not_void: a_rout_id_set /= Void
		local
			i, nb: INTEGER_32
		do
			from
				i := 1
				nb := a_rout_id_set.count
			until
				i > nb or Result /= Void
			loop
				Result := item (a_rout_id_set.item (i))
				i := i + 1
			end
		end

	attribute_of_feature_id (a_feature_id: INTEGER): detachable ATTRIBUTE_I
			-- Attribute of feature id `a_feature_id'
		local
			c: like cursor
		do
			c := cursor
			from
				start
			until
				after or Result /= Void
			loop
				Result := item_for_iteration.attribute_of_feature_id (a_feature_id)
				forth
			end
			go_to (c)
		end

	attribute_of_routine_id (a_routine_id: INTEGER): detachable ATTRIBUTE_I
			-- Attribute of routine id `a_routine_id'
		local
			c: like cursor
		do
			c := cursor
			from
				start
			until
				after or Result /= Void
			loop
				Result := item_for_iteration.attribute_of_routine_id (a_routine_id)
				forth
			end
			go_to (c)
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
