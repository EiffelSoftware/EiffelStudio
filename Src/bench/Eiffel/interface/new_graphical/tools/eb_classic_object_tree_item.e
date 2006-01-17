indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASSIC_OBJECT_TREE_ITEM

inherit
	EB_OBJECT_TREE_ITEM
	
	REFACTORING_HELPER
		undefine
			default_create, copy, is_equal
		end

create
	make_with_value

feature {NONE} -- Initialization

	fill_onces_with_list (a_parent: EV_TREE_NODE_LIST; a_once_list: LIST [E_FEATURE]; dv: ABSTRACT_DEBUG_VALUE) is
			-- Fill `a_parent' with the once functions `a_once_list'.
		local
			once_r: ONCE_REQUEST
			l_item: EV_TREE_ITEM
			flist: LIST [E_FEATURE]
			odv: ABSTRACT_DEBUG_VALUE
		do
			once_r := Application.debug_info.Once_request
			flist := a_once_list
			from
				flist.start
			until
				flist.after
			loop
				if once_r.already_called (flist.item) then
--					odv := once_r.once_result (flist.item)
--					l_item := debug_value_to_tree_item (odv)

					fixme ("JFIAT: update the runtime to avoid evaluate the once")
					
					if flist.item.argument_count > 0 then
						create l_item
						l_item.set_pixmap (pixmaps.icon_dbg_error)
						l_item.set_text (flist.item.name + " could not evaluate once with arguments...")
					else
						if dv /= Void then
							odv := once_r.once_eval_result (dv.address, flist.item, dv.dynamic_class)
						end
						if odv /= Void then
							l_item := debug_value_to_tree_item (odv)
						else
							create l_item
							l_item.set_pixmap (pixmaps.icon_dbg_error)
							l_item.set_text (flist.item.name + " : unable to get value !")
						end
					end						
				else
					create l_item
					l_item.set_pixmap (Pixmaps.Icon_void_object)
					l_item.set_text (flist.item.name + ": " + Interface_names.l_Not_yet_called)
				end
				a_parent.extend (l_item)
				flist.forth
			end
				-- We remove the dummy item.
			a_parent.start
			a_parent.remove
		end

	debug_value_to_tree_item (dv: ABSTRACT_DEBUG_VALUE): like Current is
			-- Convert `dv' into a tree item.
		do
			create Result.make_with_value (dv, tool)
		end
	
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

end
