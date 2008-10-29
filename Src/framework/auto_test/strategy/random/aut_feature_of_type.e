indexing

	description:

		"Objects representing a feature belonging to a certain type"

	copyright: "Copyright (c) 2005, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"


class AUT_FEATURE_OF_TYPE

inherit

	HASHABLE

create

	make

feature {NONE} -- Initialization

	make (a_feature: like feature_; a_type: like type) is
			-- Create new object representing feature
			-- `a_feature' of type `a_type'.
		require
			a_feature_not_void: a_feature /= Void
			a_type_not_void: a_type /= Void
		do
			feature_ := a_feature
			type := a_type
		ensure
			feature_set: feature_ = a_feature
			type_set: type = a_type
		end

feature -- Access

	feature_: FEATURE_I
			-- Feature associated with `type'

	type: TYPE_A
			-- Type associated with `feature_'
			-- The type of target when `feature_' is called.

	hash_code: INTEGER is
		do
			Result := feature_.feature_name_id
		end

invariant

	feature_not_void: feature_ /= Void
	type_not_void: type /= Void

end
