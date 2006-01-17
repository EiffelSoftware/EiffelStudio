indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_DISPLAY_PARAMETERS_DOTNET

inherit

	EB_OBJECT_DISPLAY_PARAMETERS
	
	DEBUG_VALUE_EXPORTER

create {SHARED_DEBUG}
	make, make_from_debug_value, make_from_stack_element

feature {NONE} -- Debug Value

	associated_debug_value: ABSTRACT_DEBUG_VALUE is
		require
			Application.is_dotnet
		do
			Result := internal_associated_debug_value
			if Result = Void then
				if application.imp_dotnet.know_about_kept_object (address) then
					Result := Application.imp_dotnet.kept_object_item (address)					
				end				
				internal_associated_debug_value := Result
			end
		end

	internal_associated_debug_value: like associated_debug_value

feature -- Transformation

	object_type_and_value: STRING is
			-- Full ouput representation for related object
		local
			abstract_value: ABSTRACT_DEBUG_VALUE
		do
			abstract_value := associated_debug_value
			if abstract_value /= Void then
				Result := abstract_value.dump_value.type_and_value
			else
				Result := ""
			end
		end

feature {NONE} -- Refreshing Implementation

	refreshed_sorted_children: DS_LIST [ABSTRACT_DEBUG_VALUE] is
			-- Sorted children used by refresh
			-- set `is_sorted_children_about_special' attribute
		local
			dv: ABSTRACT_DEBUG_VALUE
			conv_nat_value: EIFNET_DEBUG_NATIVE_ARRAY_VALUE
			conv_abs_spec: ABSTRACT_SPECIAL_VALUE
		do
			dv ?= associated_debug_value
			if dv /= Void then
				conv_nat_value ?= dv
				if conv_nat_value /= Void then -- NativeArray (.NET)
						--| wipe_out or create an empty list for `conv_nat_values.items'
					conv_nat_value.reset_items
					conv_nat_value.get_items (spec_lower, spec_higher)
				end

				conv_abs_spec ?= dv
				is_sorted_children_about_special := conv_abs_spec /= Void
				Result := dv.sorted_children
			end
		end


feature {NONE} -- Specific Implementation

	sorted_attributes: DS_LIST [ABSTRACT_DEBUG_VALUE] is
		local
			dv: ABSTRACT_DEBUG_VALUE
		do
			dv ?= associated_debug_value
			if dv /= Void then
				Result := dv.sorted_children
			end
		end

	fill_onces_with_list (parent: EV_TREE_NODE_LIST; a_once_list: LIST [E_FEATURE]; dv: ABSTRACT_DEBUG_VALUE) is
			-- Fill `parent' with the once functions `a_once_list'.
		local
			item: EV_TREE_ITEM
			flist: LIST [E_FEATURE]

			item_dv: ABSTRACT_DEBUG_VALUE
			dummy_dv: DUMMY_MESSAGE_DEBUG_VALUE
			l_dotnet_ref_value: EIFNET_DEBUG_REFERENCE_VALUE
			l_feat: E_FEATURE
		do
			flist := a_once_list
			if dv /= Void then
				l_dotnet_ref_value ?= dv
			else
				l_dotnet_ref_value ?= associated_debug_value
			end

			check
				dotnet_ref_value_not_void: l_dotnet_ref_value /= Void
			end
			
			--| Eiffel dotnet |--
			if not flist.is_empty then
				if l_dotnet_ref_value /= Void then
					l_dotnet_ref_value.get_object_value
				end
				from
					flist.start
				until
					flist.after
				loop
					l_feat := flist.item
					if l_dotnet_ref_value /= Void then
						item_dv := l_dotnet_ref_value.once_function_value (l_feat)
					else
						create dummy_dv.make_with_name (l_feat.name)
						dummy_dv.set_message ("Could not retrieve information")
						item_dv := dummy_dv
					end
					if item_dv /= Void then
						item := debug_value_to_item (item_dv)						
					else
						create item
						item.set_pixmap (Pixmaps.Icon_void_object)
						item.set_text (l_feat.name + ": " + Interface_names.l_Not_yet_called)
					end						
					parent.extend (item)
	
					flist.forth
				end
				if l_dotnet_ref_value /= Void then
					l_dotnet_ref_value.release_object_value
				end
			end
				-- We remove the dummy item.
			parent.start
			parent.remove
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

end -- class EB_OBJECT_DISPLAY_PARAMETERS_DOTNET
