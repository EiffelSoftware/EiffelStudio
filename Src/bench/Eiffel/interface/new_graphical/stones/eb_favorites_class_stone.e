indexing
	description: "Class stone containing the favorite item it stems from"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FAVORITES_CLASS_STONE

inherit
	CLASSI_STONE

create
	make_from_favorite

feature -- Initialization

	make_from_favorite (an_item: EB_FAVORITES_CLASS) is
			-- Create a class stone and save the attached favorite item
		require
			class_exists_in_universe: an_item.associated_class_stone /= Void
		do
			default_create
			make (an_item.associated_class_i)
			origin := an_item
		end
			
feature -- Access

	origin: EB_FAVORITES_CLASS

end -- class EB_FAVORITES_CLASS_STONE
