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

create
	make

feature -- Initialization

	make (fname : like feature_name; params : like parameters; v: like has_target) is
			-- Set `feature_name' to `fname', `parameters' to `params', `has_target' to `v'
		require
			name_exists : fname /= Void
		do
			feature_name := fname
			parameters := params
			has_target := v
		ensure
			name_set : feature_name = fname
			parameters_set : parameters = params
			has_target_set: has_target = v
		end

feature -- Delayed call

	is_delayed : BOOLEAN is True
			-- Delayed call.

	has_target: BOOLEAN
			-- Does current agent call use a target?

end -- class DELAYED_ACCCES_FEAT_AS
