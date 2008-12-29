note
	description: "Grid item for metric normal criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_NORMAL_CRITERION_GRID_ITEM

inherit
	EB_METRIC_CRITERION_GRID_ITEM [EB_METRIC_NORMAL_CRITERION]
		undefine
			default_create
		end

	EV_GRID_LABEL_ITEM
		undefine
			is_equal,
			copy
		end

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize.
		do
			default_create
			create change_value_actions
		end

feature -- Access

	grid_item: EV_GRID_ITEM
			-- Grid item for Current property
		do
			Result := Current
		end

	change_value_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions called if the value has been changed. A value of `Void' means the value has been unset.

feature -- Setting

	load_criterion (a_criterion: EB_METRIC_NORMAL_CRITERION)
			-- Load `a_criterion' into Current.
		do
		end

	store_criterion (a_criterion: EB_METRIC_NORMAL_CRITERION)
			-- Store Current in `a_criterion'.
		do
		end

end
