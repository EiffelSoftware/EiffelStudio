indexing

	description: 
		"Specify undoable action which translate one figure.";
	date: "$Date$";
	revision: "$Revision $"

class TRANSLATE_FIGURE_U

inherit

	TRANSLATE_U

creation

	make

feature -- Initialization

	make (figure: like entity; x, y: like relative_x) is
			-- Translate a 'figure'
		require
			has_figure: figure /= Void
		do
			record;
			entity := figure;
			relative_x := x;
			relative_y := y;
			redo
		ensure
			entity_correctly_set: entity = figure
		end

feature -- Property

	name: STRING is "Move figure"

end -- class TRANSLATE_FIGURE_U
