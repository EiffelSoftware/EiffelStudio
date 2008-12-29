note
	description: "Grid item for metric domain criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_DOMAIN_CRITERION_GRID_ITEM

inherit
	EB_METRIC_CRITERION_GRID_ITEM [EB_METRIC_DOMAIN_CRITERION]
		undefine
			default_create,
			copy,
			is_equal
		end

	EB_METRIC_INTERFACE_PROVIDER
		undefine
			default_create,
			copy,
			is_equal
		end

	EB_METRIC_GRID_DOMAIN_ITEM [ANY]
		rename
			make as old_make
		end

create
	make

feature{NONE} -- Initialization

	make
			-- Initialize.
		do
			old_make (create {EB_METRIC_DOMAIN}.make)
			pointer_button_press_actions.force_extend (agent activate_grid_item (?, ?, ?, ?, ?, ?, ?, ?, Current))
			dialog_ok_actions.extend (agent change_actions.call (Void))
			set_tooltip (metric_names.f_pick_and_drop_items)
			set_dialog_function (agent plain_domain_setup_dialog)
		end

feature -- Setting

	load_criterion (a_criterion: EB_METRIC_DOMAIN_CRITERION)
			-- Load `a_criterion' into Current.
		local
			l_domain: EB_METRIC_DOMAIN
		do
			check a_criterion.domain /= Void end
			l_domain := a_criterion.domain.twin
			set_domain (l_domain)
		end

	store_criterion (a_criterion: EB_METRIC_DOMAIN_CRITERION)
			-- Store Current in `a_criterion'.
		do
			check domain /= Void end
			a_criterion.set_domain (domain.twin)
		end

	change_value_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions called if the value has been changed
		do
			Result := change_actions
		ensure then
			good_result: Result = change_actions
		end

end
