indexing
	description: "Application editor window."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class CMD_LABEL

inherit
	PND_DATA
		redefine
			is_equal
		end

	EB_HASHABLE
		redefine
			is_equal
		end

creation
	make
	
feature {NONE} -- Initialization

	make (s: STRING) is
		do
			label := s
		end

	help_file_name: STRING is
		do
			Result := Help_const.label_help_fn
		end

feature {NONE} -- Hashable

	hash_code: INTEGER is
		do
			Result := label.hash_code
		end

feature {NEW_LABEL_BOX, LABEL_BOX} -- Comparison

	same (other: CMD_LABEL): BOOLEAN is
		do
			Result := not (other = Void) and then
				(label.is_equal (other.label))
		end
	
feature -- Data

	symbol: EV_PIXMAP is
		once
			Result := Pixmaps.label_pixmap
		end

	label: STRING

	is_equal (other: like Current): BOOLEAN is
		do
			Result := label.is_equal (other.label)
		end

feature -- Access

	parent_type: CMD
		-- Command which defines
		-- Current label if
		-- introduced by inheritance

	set_parent (c: CMD) is
		do
			parent_type := c
		end

	inherited: BOOLEAN is
		do
			Result := parent_type /= Void
		end

end -- class CMD_LABEL

