indexing

	description: 
		"Undoable command for hiding a linkable entity.";
	date: "$Date$";
	revision: "$Revision $"

class HIDE_LINKABLE_U

inherit

	LINKABLE_ABSTRACTION

creation

	make

feature {NONE} -- Initialization

	make (a_data: like linkable_data) is
		require
			valid_data: a_data /= Void
			data_not_hidden: not a_data.is_hidden
		do
			record
			linkable_data := a_data
			redo
		end

feature -- Property

	name: STRING is "Hide linkable"

feature -- Update

	redo is
		do
			hide_linkable
		end

	undo is
		do
			show_linkable
		end

end -- class HIDE_LINKABLE_U
