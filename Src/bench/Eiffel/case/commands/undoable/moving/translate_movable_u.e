indexing

	description: 
		"Undoable command to translate a figure with others%
		%in a list (movables_list).";
	date: "$Date$";
	revision: "$Revision $"

class TRANSLATE_MOVABLE_U

inherit

	MOVABLE_U;

	TRANSLATE_U
		export
			{MULTIPLE_MOVE_U} entity
		undefine
			graphical_update
		end

creation

	make

feature -- Initialization

	make (an_entity : like entity; x, y : like relative_x) is
		require
			has_entity : an_entity /= Void
		do
			entity := an_entity;
			relative_x := x;
			relative_y := y
		ensure
			entity_correctly_set : entity = an_entity;
			relative_x_correctly_set : relative_x = x;
			relative_y_correctly_set : relative_y = y
		end -- make

end -- class TRANSLATE_MOVABLE_U

	

