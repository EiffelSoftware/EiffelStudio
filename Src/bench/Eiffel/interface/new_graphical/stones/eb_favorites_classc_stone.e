indexing
	description: "Class c stone containing the favorite item it stems from"
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FAVORITES_CLASSC_STONE

inherit
	CLASSC_STONE
		rename
			make as old_make
		select
			classi_make
		end

	EB_FAVORITES_CLASS_STONE
		undefine
			header,
			is_valid,
			class_i,
			stone_signature,
			class_name,
			file_name,
			history_name,
			synchronized_stone,
			cluster
		redefine
			make_from_favorite
		end

create
	make_from_favorite

feature -- Initialization

	make_from_favorite (an_item: EB_FAVORITES_CLASS) is
			-- Create a class stone and save the attached favorite item
		require else
			class_exists_in_universe: an_item.associated_class_stone /= Void
			real_class_c: an_item.associated_class_c /= Void
		do
			default_create
			old_make (an_item.associated_class_c)
			origin := an_item
		end
			
end -- class EB_FAVORITES_CLASSC_STONE

