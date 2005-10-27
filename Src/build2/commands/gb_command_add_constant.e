indexing
	description: "Objects that represent the addition of a constant."
	date: "$Date$"
	revision: "$Revision$"

class
	GB_COMMAND_ADD_CONSTANT

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
		-- Access to a set of internal components for an EiffelBuild instance.

	make (constant: GB_CONSTANT; a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' with `child' to be removed from `parent' at
			-- position `position'.
		require
			constant_not_void: constant /= Void
		do
			components := a_components
		--	history.cut_off_at_current_position
			internal_constant := constant
		ensure
			constant_recorded: internal_constant /= Void
		end

feature -- Basic Operation

	execute is
			-- Execute `Current'.
		local
			integer_constant: GB_INTEGER_CONSTANT
			string_constant: GB_STRING_CONSTANT
			pixmap_constant: GB_PIXMAP_CONSTANT
			directory_constant: GB_DIRECTORY_CONSTANT
			color_constant: GB_COLOR_CONSTANT
			font_constant: GB_FONT_CONSTANT
			editors: ARRAYED_LIST [GB_OBJECT_EDITOR]
		do
			if internal_constant.type.is_equal (Integer_constant_type) then
				integer_constant ?= internal_constant
				components.constants.add_integer (integer_constant)
			elseif internal_constant.type.is_equal (String_constant_type) then
				string_constant ?= internal_constant
				components.constants.add_string (string_constant)
			elseif internal_constant.type.is_equal (Pixmap_constant_type) then
				pixmap_constant ?= internal_constant
				components.constants.add_pixmap (pixmap_constant)
			elseif internal_constant.type.is_equal (Directory_constant_type) then
				directory_constant ?= internal_constant
				components.constants.add_directory (directory_constant)
			elseif internal_constant.type.is_equal (Color_constant_type) then
				color_constant ?= internal_constant
				components.constants.add_color (color_constant)
			elseif internal_constant.type.is_equal (Font_constant_type) then
				font_constant ?= internal_constant
				components.constants.add_font (font_constant)
			end
			editors := components.object_editors.all_editors
			from
				editors.start
			until
				editors.off
			loop
				editors.i_th (editors.index).constant_added (internal_constant)
				editors.forth
			end

		--	if not history.command_list.has (Current) then
		--		history.add_command (Current)
		--	end
			components.system_status.mark_as_dirty
		end

	undo is
			-- Undo `Current'.
			-- Calling `execute' followed by `undo' must restore
			-- the system to its previous state.
		local
--				constant_context: GB_CONSTANT_CONTEXT
		do
--			Constants.remove_constant (internal_constant)
--			editors := all_editors
--			from
--				editors.start
--			until
--				editors.off
--			loop
--				editors.i_th (editors.index).constant_removed (internal_constant)
--				editors.forth
--			end
--			command_handler.update
		end

	textual_representation: STRING is
			-- Text representation of command exectuted.
		do
		--	Result := internal_constant.type + " constant named " + internal_constant.name + " added to project."
		end

feature {NONE} -- Implementation

	internal_constant: GB_CONSTANT
		-- Constant which is the subject of `Current'.

end -- class GB_COMMAND_ADD_CONSTANT
