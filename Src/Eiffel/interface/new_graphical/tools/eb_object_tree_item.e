indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	EB_OBJECT_TREE_ITEM
	
inherit
	EV_TREE_ITEM
		export
			{NONE} make_with_text
		end
	
	VALUE_TYPES
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end
	
	EB_CONSTANTS
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		undefine
			is_equal, copy, default_create
		end

feature {NONE} -- Initialization

	make_with_value (dv: ABSTRACT_DEBUG_VALUE; ot: EB_OBJECT_TOOL) is
			-- 
		do
			default_create
			tool := ot
			set_debug_value (dv)
		end
		
	tool: EB_OBJECT_TOOL

feature -- Properties

	debug_value: ABSTRACT_DEBUG_VALUE is
		do
			Result ?= data
		end	

feature -- Change

	set_debug_value (dv: ABSTRACT_DEBUG_VALUE) is
		local
			ost: OBJECT_STONE
			dmdv: DUMMY_MESSAGE_DEBUG_VALUE
		do
			if dv.is_dummy_value then
				last_dump_value := Void
				dmdv ?= dv
				set_text (dv.name + ": " + dmdv.display_message)
				set_pixmap (icons @ (dv.kind))
				set_data (dv)
			else
				last_dump_value := dv.dump_value
				set_text (dv.name + ": " + last_dump_value.type_and_value)
				set_pixmap (icons @ (dv.kind))
				set_data (dv)
			
				if dv.expandable then
					extend (create {EV_TREE_ITEM}.make_with_text ("Bug"))
					expand_actions.extend (agent fill_item (Current))
				end
				if dv.address /= Void then
						--| For now we don't support this for external type
					create ost.make (dv.address, dv.name, dv.dynamic_class)
					ost.set_associated_ev_item (Current)
					set_pebble (ost)
					set_accept_cursor (ost.stone_cursor)
					set_deny_cursor (ost.X_stone_cursor)
				end				
			end
			update
		end

feature -- Updating

	last_dump_value: DUMP_VALUE

	update is
		local
			l_dmp: DUMP_VALUE
			l_text: STRING
			l_pos: INTEGER
			l_integer32_value: INTEGER
			l_integer64_value: INTEGER_64
			l_natural32_value: NATURAL_32
			l_natural64_value: NATURAL_64			
		do
			l_dmp := last_dump_value
			if l_dmp /= Void then
				inspect l_dmp.type 
						-- NOTA: we should factorize this .. maybe having to_hex_string, in NUMERIC would help
					when {DUMP_VALUE_CONSTANTS}.Type_integer_32 then
						l_text := text
						l_pos := l_text.index_of ('=', 1) + 1
						check
							has_space: l_text.item (l_pos) = ' '
						end
						l_integer32_value := l_dmp.value_integer_32
						l_text :=  l_text.substring (1, l_pos)
						if hexa_mode_enabled then
							l_text.append_string ("0x" + l_integer32_value.to_hex_string)
						else
							l_text.append_string (l_integer32_value.out)
						end
						set_text (l_text)
					when {DUMP_VALUE_CONSTANTS}.Type_integer_64 then
						l_text := text
						l_pos := l_text.index_of ('=', 1) + 1
						check
							has_space: l_text.item (l_pos) = ' '
						end
						l_integer64_value := l_dmp.value_integer_64
						l_text :=  l_text.substring (1, l_pos)
						if hexa_mode_enabled then
							l_text.append_string ("0x" + l_integer64_value.to_hex_string)
						else
							l_text.append_string (l_integer64_value.out)
						end
						set_text (l_text)				
					when {DUMP_VALUE_CONSTANTS}.Type_natural_32 then
						l_text := text
						l_pos := l_text.index_of ('=', 1) + 1
						check
							has_space: l_text.item (l_pos) = ' '
						end
						l_natural32_value := l_dmp.value_natural_32
						l_text :=  l_text.substring (1, l_pos)
						if hexa_mode_enabled then
							l_text.append_string ("0x" + l_natural32_value.to_hex_string)
						else
							l_text.append_string (l_natural32_value.out)
						end
						set_text (l_text)
					when {DUMP_VALUE_CONSTANTS}.Type_natural_64 then
						l_text := text
						l_pos := l_text.index_of ('=', 1) + 1
						check
							has_space: l_text.item (l_pos) = ' '
						end
						l_natural64_value := l_dmp.value_natural_64
						l_text :=  l_text.substring (1, l_pos)
						if hexa_mode_enabled then
							l_text.append_string ("0x" + l_natural64_value.to_hex_string)
						else
							l_text.append_string (l_natural64_value.out)
						end
						set_text (l_text)
					else
						-- Skip
				end
			end
		end

feature {NONE} -- Implementation

	icons: ARRAY [EV_PIXMAP] is
			-- List of available icons for objects.
		once
			create Result.make (Immediate_value, Error_message_value)
			
			Result.put (Pixmaps.Icon_immediate_value, Immediate_value)
			Result.put (Pixmaps.Icon_void_object, Void_value)
			Result.put (Pixmaps.Icon_object_symbol, Reference_value)
			Result.put (Pixmaps.Icon_expanded_object, Expanded_value)
			Result.put (Pixmaps.Icon_object_symbol, Special_value)
			Result.put (Pixmaps.Icon_external_symbol, External_reference_value)			
			Result.put (Pixmaps.Icon_static_external_symbol, Static_external_reference_value)
			Result.put (Pixmaps.Icon_static_object_symbol, Static_reference_value)
			Result.put (Pixmaps.Icon_dbg_error, Error_message_value)
		end

	hexa_mode_enabled: BOOLEAN is
		do
			Result := tool.hexa_mode_enabled
		end

feature {NONE} -- Filling Implementation

	fill_item (a_item: EV_TREE_ITEM) is
			-- If a tree item was expandable, fill it with its children. (Not the onces)
		local
			conv_abs_spec: ABSTRACT_SPECIAL_VALUE
			dv: ABSTRACT_DEBUG_VALUE
			folder_item: EV_TREE_ITEM
			new_item: EV_TREE_ITEM
			list: DS_LIST [ABSTRACT_DEBUG_VALUE]
			list_cursor: DS_LINEAR_CURSOR [ABSTRACT_DEBUG_VALUE]
			flist: LIST [E_FEATURE]
		do
			a_item.expand_actions.wipe_out
			dv ?= a_item.data
			if dv /= Void then
				list := dv.sorted_children
				if list /= Void and then not list.is_empty then
					create folder_item.make_with_text (Interface_names.l_Object_attributes)
					folder_item.set_pixmap (Pixmaps.Icon_attributes)
					a_item.extend (folder_item)

					from
						list_cursor := list.new_cursor
						list_cursor.start
					until
						list_cursor.after
					loop
						folder_item.extend (debug_value_to_tree_item (list_cursor.item))
						list_cursor.forth
					end
					conv_abs_spec ?= dv
					if conv_abs_spec /= Void then
						if conv_abs_spec.sp_lower > 0 then
							folder_item.put_front (create {EV_TREE_ITEM}.make_with_text (
								Interface_names.l_More_items))
						end
						if 0 <= conv_abs_spec.sp_upper and then conv_abs_spec.sp_upper < conv_abs_spec.capacity - 1 then
							folder_item.extend (create {EV_TREE_ITEM}.make_with_text (
								Interface_names.l_More_items))
						end
						folder_item.expand
					else
						folder_item.expand
					end
				end
				if dv.dynamic_class = Void then
					--| Q: Why do we have Void dynamic_class ?
					--| ANSWER : because of external class in dotnet system
					--| Should be fixed now by using SYSTEM_OBJECT for unknown type
				else
					flist := dv.dynamic_class.once_functions
					if not flist.is_empty then
						create folder_item.make_with_text (Interface_names.l_Once_functions)
						folder_item.set_pixmap (Pixmaps.Icon_once_objects)
						a_item.extend (folder_item)
						create new_item.make_with_text (Interface_names.l_Dummy)
							--| Add expand actions.
						folder_item.extend (new_item)
						folder_item.set_data (dv)
						folder_item.expand_actions.extend (agent fill_onces (folder_item))
					end
				end
			end
				-- We remove the dummy item.
			a_item.start
			a_item.remove
		end

	fill_onces (a_parent: EV_TREE_ITEM) is
			-- Fill `a_parent' with the once functions of the debug_value it is in.
		local
			flist: LIST [E_FEATURE]
			dv: ABSTRACT_DEBUG_VALUE
		do
			dv ?= a_parent.data
			a_parent.expand_actions.wipe_out
			if dv /= Void then
				flist := dv.dynamic_class.once_functions
				fill_onces_with_list (a_parent, flist, dv)
			end
		end

	fill_onces_with_list (a_parent: EV_TREE_NODE_LIST; a_once_list: LIST [E_FEATURE]; dv: ABSTRACT_DEBUG_VALUE) is
			-- Fill `a_parent' with the once functions of the debug_value it is in.
		deferred
		end

	debug_value_to_tree_item (dv: ABSTRACT_DEBUG_VALUE): EB_OBJECT_TREE_ITEM is
			-- Convert `dv' into a tree item.
		deferred
--			create Result.make_with_value (dv, tool)
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

end -- class EB_OBJECT_TREE_ITEM
