indexing
	description:
		"Abstract description of a delayed access to an Eiffel feature%
		%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class
	DELAYED_ACCESS_FEAT_AS

inherit
	ACCESS_FEAT_AS
		redefine
			is_delayed
		end

creation
	make

feature -- Initialization

	make (fname : like feature_name; params : like parameters) is
			-- Set `feature_name' to `fname', `parameters' to `params'.
		require
			name_exists : fname /= Void
		do
			feature_name := fname
			parameters := params
		ensure
			name_set : feature_name = fname
			parameters_set : parameters = params
		end

feature -- Delayed call

	is_delayed : BOOLEAN is True

end -- class DELAYED_ACCCES_FEAT_AS
