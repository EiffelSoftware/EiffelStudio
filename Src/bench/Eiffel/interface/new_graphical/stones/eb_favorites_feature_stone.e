indexing
	description: "Feature stone containing the favorite item it stems from"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FAVORITES_FEATURE_STONE

inherit
	FEATURE_STONE

create
	make_from_favorite

feature -- Initialization

	make_from_favorite (an_item: EB_FAVORITES_FEATURE) is
			-- Create a feature stone and save the attached favorite item
		require
			feature_exists_in_universe: an_item.associated_e_feature /= Void
		do
			default_create
			make (an_item.associated_e_feature)
			origin := an_item
		end
			
feature -- Access

	origin: EB_FAVORITES_FEATURE

end -- class EB_FAVORITES_FEATURE_STONE

