indexing

	description: 
		"Undoable command for moving a link. This command%
		%primary purpose is to update link in the workarea.%
		%Specify undoable actions to move a link with several%
		%figures in a list (movables_list).";
	date: "$Date$";
	revision: "$Revision $"

class LINK_MOVABLE_U

inherit

	MOVABLE_U

creation

	make

feature -- Initialization

	make (an_entity : like entity) is
			-- Move 'an_entity'
		require
			has_entity : an_entity /= Void
		do
			entity := an_entity;
		ensure
			entity_correctly_set : entity = an_entity
		end -- make

feature {MULTIPLE_MOVE_U} -- Implementation

	entity: RELATION_DATA
			-- entity moved

feature {NONE} -- Implementation 

	move_figure is
		do
			-- NO ACTION DURING MOVING (no coordinates for a link)
		end; -- move_figure

	unmove_figure is
		do
			-- NO ACTION DURING MOVING (no coordinates for a link)
		end -- unmove_figures

end -- class LINK_MOVABLE_U
