indexing
	description: "Transition name (label), appearing in the transitions list."
	Id: "$Id $"
	date: "$Date$"
	revision: "$Revision$"

class TRAN_NAME 

inherit
	EV_LIST_ITEM

	COMPARABLE
		undefine
			is_equal
		end

creation
	make

feature -- Access

	cmd_label: CMD_LABEL
			-- Command label

	destination_name: STRING
			-- destination name of Current

	set_cmd_label (l: like cmd_label) is
			-- Set label_name to `s'
		require
			valid_l: l /= Void
		do
			cmd_label := l
		end

	set_destination_name (s: STRING) is
			-- Set destination_name to `s'
		require
			not (s = Void)
		do
			destination_name := s
		end

	update is
			-- Update the name of the transition
		do
			set_text (cmd_label.label)
			text.append (" -> ")
			text.append (destination_name)
		end

feature -- Comparable

--	is_equal (other: like Current): BOOLEAN is
--		do
--			Result := text.is_equal (other.text)
--		end

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := text < other.text
		end

end -- class TRAN_NAME

