note
	description: "Grid item for metric caller/callee criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_CALLER_CALLEE_CRITERION_GRID_ITEM

inherit
	EB_METRIC_CRITERION_GRID_ITEM [EB_METRIC_CALLER_CALLEE_CRITERION]
		undefine
			default_create,
			is_equal,
			copy
		end

	EB_METRIC_GRID_DOMAIN_ITEM [TUPLE [a_only_current_version: BOOLEAN]]
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
			set_dialog_function (agent caller_callee_domain_setup_dialog)
		end

feature -- Setting

	load_criterion (a_criterion: EB_METRIC_CALLER_CALLEE_CRITERION)
			-- Load `a_criterion' into Current.
		local
			l_domain: EB_METRIC_DOMAIN
		do
			check a_criterion.domain /= Void end
			l_domain := a_criterion.domain.twin
			set_domain (l_domain)
			set_value ([a_criterion.only_current_version])
		end

	store_criterion (a_criterion: EB_METRIC_CALLER_CALLEE_CRITERION)
			-- Store Current in `a_criterion'.
		local
			l_value: like value
		do
			check domain /= Void end
			a_criterion.set_domain (domain.twin)
			l_value := value
			if l_value = Void then
				l_value := [True]
			end
			if l_value.a_only_current_version then
				a_criterion.enable_only_current_version
			else
				a_criterion.disable_only_current_version
			end
		end

	change_value_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions called if the value has been changed. A value of `Void' means the value has been unset.
		do
			Result := change_actions
		end

end
