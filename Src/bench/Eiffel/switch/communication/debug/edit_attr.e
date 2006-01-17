indexing
	description: "Edit the content of an object attribute"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EDIT_ATTR

inherit
	EDIT_ITEM

create
	default_create

feature -- Initialisation / Creation

	set_stone(obj_stone: OBJECT_STONE) is
		do
			object := obj_stone
		end

feature {NONE} -- Implementation of deferred features

	start_feature is
			-- What to do to initialize the modification of an item.
		do
			io.put_string("EDIT AN OBJECT ATTRIBUTE%N")
			io.put_string("----------------------------%N")

			set_default_sp_bounds
			create obj.make (object.object_address,	sp_lower, sp_upper)
			item_list := obj.attributes
			is_special := obj.is_special
			set_sp_capacity (obj.max_capacity)
		end

	generic_modify_item is
			-- Send the first part of the 'modify-local' request.
		do
			send_rqst_3(Rqst_modify_attr, item.item_number, 0, hex_to_integer (object.object_address))
		end

	update_display is
			-- Update all object tools displaying the content of the modified object.
		local
			call_stack_elem: CALL_STACK_ELEMENT
			retry_clause: BOOLEAN
		do
			if not retry_clause then
					-- update the object tool form of the Project tool
				project_tool.update_object_tool

					-- update all the other object tools
				project_tool.window_manager.object_win_mgr.update

				status.reload_call_stack
				call_stack_elem := status.current_stack_element
				if call_stack_elem /= Void then
					Project_tool.display_exception_stack
				end
			else -- retry_clause, something went wrong
				if Application.is_running then
					Application.process_termination;
				end
			end
		rescue
			-- FIXME ARNAUD
			-- toTo: write a beautiful message box instead of this crappy message
			io.put_string("Error while getting Application callstack. Application will be terminated%N")
			-- END FIXME
			retry_clause := True
			retry
		end

feature {NONE} -- Private variables

	object			: OBJECT_STONE
	obj				: DEBUGGED_OBJECT
	is_special		: BOOLEAN
	stone			: CLASSC_STONE

feature {NONE} -- Implementation

	sp_lower, sp_upper: INTEGER
			-- Bounds for special object inspection
			-- A negative value for `sp_upper' stands for the
			-- upper bound of the inspected special object

	sp_capacity: INTEGER
			-- Capacity of the last special object displayed in
			-- the object window

	set_sp_bounds (l, u: INTEGER) is
			-- Set the bounds for special object inspection.
		do
			sp_lower := l
			sp_upper := u
		end

	set_sp_capacity (c: INTEGER) is
			-- Assign `c' to `sp_capacity'.
		do
			sp_capacity := c
		end

	set_default_sp_bounds is
			-- Set the default bounds for special object inspection.
		do
			sp_capacity := 0
			sp_lower := 0
			sp_upper := Application.displayed_string_size
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

end -- class EDIT_ATTR
