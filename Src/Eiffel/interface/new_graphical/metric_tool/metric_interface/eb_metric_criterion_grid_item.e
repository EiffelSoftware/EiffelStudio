note
	description: "Grid item for metric critrion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_CRITERION_GRID_ITEM [G -> EB_METRIC_CRITERION]

feature -- Access

	grid_item: EV_GRID_ITEM
			-- Grid item for Current property
		deferred
		ensure
			result_attached: Result /= Void
		end

feature -- Setting

	load_criterion (a_criterion: G)
			-- Load `a_criterion' into Current.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	store_criterion (a_criterion: G)
			-- Store Current in `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	change_value_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions called if the value has been changed. A value of `Void' means the value has been unset.
		deferred
		end

end
