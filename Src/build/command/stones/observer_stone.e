indexing
	description: "A stone representing an observer."
	date: "$Date$"
	revision: "$Revision$"

class
	OBSERVER_STONE

inherit
	CMD_INST_STONE
		redefine
			process
		end

	REMOVABLE

creation
	make

feature -- Creation
	
	make (inst: CMD_INSTANCE; ed: COMMAND_TOOL) is
		require
			instance_not_void: inst /= Void
			editor_not_void: ed /= Void
		do
			data := inst
			associated_editor := ed
		end

feature -- Attributes

	associated_editor: COMMAND_TOOL
			-- Associated command editor from which this stone 
			-- comes from (!!This editor is the one in which the
			-- observed command is edited!!).

feature -- Command type feature

	associated_command: CMD is
			-- Command type associated with current instance.
		do
			Result := data.associated_command
		end

feature -- Command instance features

	data: CMD_INSTANCE 
			-- Associated command instance.

feature -- Removable

	remove_yourself is
			-- Remove the associated command instance from the
			-- observer list of the command instance associated
			-- with `associated_editor'.
		local
			command: CUT_OBSERVER_CMD
		do
			!! command.make (associated_editor.command_instance, data)
			command.execute (Void)
		end

feature -- Stone features

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		local
			cut_hole: CUT_HOLE
		do
			cut_hole ?= hole
			if cut_hole /= Void then
				hole.process_any (Current)  --| wastebasket
			else
				hole.process_instance (Current)
			end
		end

end -- class OBSERVER_STONE
