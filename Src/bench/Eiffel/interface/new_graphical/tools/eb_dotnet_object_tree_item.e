indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DOTNET_OBJECT_TREE_ITEM

inherit
	EB_OBJECT_TREE_ITEM

create
	make_with_value

feature {NONE} -- Initialization

	fill_onces_with_list (a_parent: EV_TREE_NODE_LIST; a_once_list: LIST [E_FEATURE]; dv: ABSTRACT_DEBUG_VALUE) is
			-- Fill `a_parent' with the once functions `a_once_list'.
		local
			l_item: EV_TREE_ITEM
			flist: LIST [E_FEATURE]

			odv: ABSTRACT_DEBUG_VALUE
			l_abs_value: ABSTRACT_DEBUG_VALUE

			l_dotnet_ref_value: EIFNET_DEBUG_REFERENCE_VALUE
			l_feat: E_FEATURE
		do
			flist := a_once_list
			if dv /= Void then
				l_abs_value := dv
			else
				l_abs_value := associated_debug_value
			end
			check
				l_abs_value /= Void
			end
			l_dotnet_ref_value ?= l_abs_value

-- FIXME jfiat 2004-07-06: Maybe we should have EIFNET_DEBUG_STRING_VALUE conform to EIFNET_DEBUG_REFERENCE_VALUE
-- in the futur, we should make this available

			if l_dotnet_ref_value /= Void and not flist.is_empty then
					--| Eiffel dotnet |--
				l_dotnet_ref_value.get_object_value
				from
					flist.start
				until
					flist.after
				loop
					l_feat := flist.item
					odv := l_dotnet_ref_value.once_function_value (l_feat)
					if odv /= Void then
						l_item := debug_value_to_tree_item (odv)
					else
						create l_item
						l_item.set_pixmap (Pixmaps.Icon_void_object)
						l_item.set_text (l_feat.name + ": " + Interface_names.l_Not_yet_called)
					end
					a_parent.extend (l_item)
	
					flist.forth
				end
				l_dotnet_ref_value.release_object_value				
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

feature {NONE} -- Debug Value

	associated_debug_value: ABSTRACT_DEBUG_VALUE is
		local
			l_addr: STRING
		do
			Result := internal_associated_debug_value
			if Result = Void then
				l_addr := debug_value.address
				if application.imp_dotnet.know_about_kept_object (l_addr) then
					Result := Application.imp_dotnet.kept_object_item (l_addr)					
				end
				internal_associated_debug_value := Result
			end
		end

	internal_associated_debug_value: like associated_debug_value;

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

end
