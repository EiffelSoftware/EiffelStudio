indexing
	description: "Objects that ..."
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

			item_dv: ABSTRACT_DEBUG_VALUE
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
			from
				flist.start
			until
				flist.after
			loop
				l_feat := flist.item
				item_dv := l_dotnet_ref_value.once_function_value (l_feat)
				if item_dv /= Void then
					l_item := debug_value_to_tree_item (item_dv)
				else
					create l_item
					l_item.set_pixmap (Pixmaps.Icon_void_object)
					l_item.set_text (l_feat.name + Interface_names.l_Not_yet_called)
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

feature {NONE} -- Debug Value

feature {NONE} -- Debug Value

	associated_debug_value: ABSTRACT_DEBUG_VALUE is
		do
			Result := internal_associated_debug_value
			if Result = Void then
				Result ?= Application.imp_dotnet.kept_object_item (debug_value.address)
				internal_associated_debug_value := Result
			end
		end

	internal_associated_debug_value: like associated_debug_value


end
