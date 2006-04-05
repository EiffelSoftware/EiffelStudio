indexing
	description: "Objects that represent the deletion of a constant."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_DELETE_CONSTANT
	
inherit
	
	GB_COMMAND
		export
			{NONE} all
		end
		
	GB_CONSTANTS
		export
			{NONE} all
		end
	
create
	make
	
feature {NONE} -- Initialization

	--| FIXME, constants are now no longer undoable.
	--| Hence the commented sections in this class.
	
	components: GB_INTERNAL_COMPONENTS

	make (constant: GB_CONSTANT; a_component: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position'.
		require
			constant_not_void: constant /= Void
		do
			components := a_component
		--	history.cut_off_at_current_position
			internal_constant := constant
		ensure
			constant_recorded: internal_constant /= Void
		end

feature -- Basic Operation

	execute is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
			editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
		do
--			if not history.command_list.has (Current) then
--				history.add_command (Current)
--			end
			editors := components.object_editors.all_editors
			from
				editors.start
			until
				editors.off
			loop
				editors.i_th (editors.index).constant_removed (internal_constant)
				editors.forth
			end
			components.constants.remove_constant (internal_constant)			
			components.commands.update
		end

	undo is
			-- Execute `Current'.
		local
--			integer_constant: GB_INTEGER_CONSTANT
--			string_constant: GB_STRING_CONSTANT
--			pixmap_constant: GB_PIXMAP_CONSTANT
--			directory_constant: GB_DIRECTORY_CONSTANT
--			editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
		do
--			if internal_constant.type.is_equal (Integer_constant_type) then
--				integer_constant ?= internal_constant
--				Constants.add_integer (integer_constant)
--			elseif internal_constant.type.is_equal (String_constant_type) then
--				string_constant ?= internal_constant
--				Constants.add_string (string_constant)
--			elseif internal_constant.type.is_equal (Pixmap_constant_type) then
--				pixmap_constant ?= internal_constant
--				Constants.add_pixmap (pixmap_constant)
--			elseif internal_constant.type.is_equal (Directory_constant_type) then
--				directory_constant ?= internal_constant
--				Constants.add_directory (directory_constant)
--			end
--			editors := all_editors
--			from
--				editors.start
--			until
--				editors.off
--			loop
--				editors.i_th (editors.index).constant_added (internal_constant)
--				editors.forth
--			end
--			command_handler.update
		end
		
	textual_representation: STRING is
			-- Text representation of command executed.
		do
		--	Result := internal_constant.type + " constant named " + internal_constant.name + " remove from project."
		end

feature {NONE} -- Implementation

	internal_constant: GB_CONSTANT;
		-- Constant which is the subject of `Current'.

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


end -- class GB_COMMAND_DELETE_CONSTANT
