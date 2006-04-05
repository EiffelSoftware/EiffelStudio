indexing
	description: 
		"Stone representating a breakable point."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class
	CALL_STACK_STONE 

inherit
	FEATURE_STONE
		rename
			make as feature_make,
			is_valid as fvalid
		redefine
			stone_cursor,
			X_stone_cursor,
			synchronized_stone,
			same_as
		select
			class_stone_make
		end

	OBJECT_STONE
		rename
			make as obj_make
		undefine
			file_name,
			header,
			stone_signature,
			origin_text,
			history_name
		redefine
			stone_cursor,
			X_stone_cursor,
			synchronized_stone,
			is_valid,
			same_as
		select
			is_valid
		end

	SHARED_APPLICATION_EXECUTION

create
	make
	
feature {NONE} -- Initialization

	make (level_num: INTEGER) is
			-- Initialize `level_number' to `level_num'.
		require
			level_num: level_num > 0
		local
			elem: EIFFEL_CALL_STACK_ELEMENT
			curr_cs: EIFFEL_CALL_STACK
		do
			level_number := level_num
			curr_cs := Application.status.current_call_stack
			if curr_cs /= Void then
				elem ?= curr_cs.i_th (level_num)
				if elem /= Void then
					obj_make (elem.object_address, " ", elem.dynamic_class)
					feature_make (elem.routine)
				end
			end
		end
 
feature -- Access

	same_as (other: STONE): BOOLEAN is
		local
			conv: CALL_STACK_STONE
		do
			conv ?= other
			if conv /= Void then
				Result := Precursor {OBJECT_STONE} (other) and then
						Precursor {FEATURE_STONE} (other)
			end
		end

	level_number: INTEGER
			-- Level number of call stack

	stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is compatible with Current stone
		do
			Result := Cursors.cur_Setstop
		end

	x_stone_cursor: EV_CURSOR is
			-- Cursor associated with Current stone during transport
			-- when widget at cursor position is not compatible with Current stone
		do
			Result := Cursors.cur_X_setstop
		end

	synchronized_stone: CLASSI_STONE is
		do
			if is_valid then
				Result := twin
			else
				Result := Precursor {FEATURE_STONE}
			end
		end

	is_valid: BOOLEAN is
		local
			ecs: EIFFEL_CALL_STACK
			cs: CALL_STACK_ELEMENT
		do
			Result := fvalid and then Precursor {OBJECT_STONE}
					and then Application.status.current_call_stack.count >= level_number
			if Result then
				ecs := Application.status.current_call_stack
				if ecs /= Void then
					cs := ecs.i_th (level_number)
				end
				Result := cs /= Void and then cs.is_eiffel_call_stack_element
			end
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

end -- class BREAKABLE_STONE
