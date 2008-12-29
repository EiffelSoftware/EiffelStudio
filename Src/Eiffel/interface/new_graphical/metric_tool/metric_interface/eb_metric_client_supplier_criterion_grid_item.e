note
	description: "Grid item for metric client/supplier criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_CLIENT_SUPPLIER_CRITERION_GRID_ITEM

inherit
	EB_METRIC_CRITERION_GRID_ITEM [EB_METRIC_SUPPLIER_CLIENT_CRITERION]
		undefine
			default_create,
			is_equal,
			copy
		end

	EB_METRIC_GRID_DOMAIN_ITEM [TUPLE [a_indirect: BOOLEAN; a_normal_reference: BOOLEAN;  a_only_syntactical_reference: BOOLEAN]]
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
			set_dialog_function (agent dialog_getter)
		end

feature -- Setting

	load_criterion (a_criterion: EB_METRIC_SUPPLIER_CLIENT_CRITERION)
			-- Load `a_criterion' into Current.
		local
			l_domain: EB_METRIC_DOMAIN
		do
			check a_criterion.domain /= Void end
			l_domain := a_criterion.domain.twin
			set_domain (l_domain)

			set_value (
				[a_criterion.indirect_referenced_class_retrieved,
				 a_criterion.normal_referenced_class_retrieved,
				 a_criterion.only_syntactically_referencedd_class_retrieved]
			)
			is_for_supplier := a_criterion.is_for_supplier

		end

	store_criterion (a_criterion: EB_METRIC_SUPPLIER_CLIENT_CRITERION)
			-- Store Current in `a_criterion'.
		local
			l_value: like value
		do
			check domain /= Void end
			a_criterion.set_domain (domain.twin)
			l_value := value
			if l_value = Void then
				l_value := [False, True, False]
			end
			a_criterion.set_indirect_referenced_class_retrieved (l_value.a_indirect)
			a_criterion.set_normal_referenced_class_retrieved (l_value.a_normal_reference)
			a_criterion.set_only_syntactically_referencedd_class_retrieved (l_value.a_only_syntactical_reference)
		end

	change_value_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions called if the value has been changed. A value of `Void' means the value has been unset.
		do
			Result := change_actions
		end

feature{NONE} -- Implementation

	is_for_supplier: BOOLEAN
			-- Is Current criterion for suppiers?

	dialog_getter: EB_METRIC_GRID_DOMAIN_ITEM_DIALOG [TUPLE [a_indirect: BOOLEAN; a_normal_reference: BOOLEAN;  a_only_syntactical_reference: BOOLEAN]]
			-- Dialog used for domain setup
		do
			if is_for_supplier then
				Result := supplier_domain_setup_dialog
			else
				Result := client_domain_setup_dialog
			end
		end

end
