indexing
	description: "Grid item for metric value criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_VALUE_CRITERION_GRID_ITEM

inherit
	EB_METRIC_CRITERION_GRID_ITEM [EB_METRIC_VALUE_CRITERION]
		undefine
			copy,
			default_create,
			is_equal
		end

	EB_METRIC_GRID_DOMAIN_ITEM [TUPLE [a_metric_name: STRING; a_parent_used: BOOLEAN; a_tester: EB_METRIC_VALUE_TESTER]]
		rename
			make as old_make
		redefine
			prepare_components,
			is_pebble_droppable,
			drop_pebble
		end

	EB_SHARED_WRITER
		undefine
			copy,
			default_create
		end

create
	make,
	make_with_setting

feature{NONE} -- Initialization

	make is
			-- Initialize.
			-- `a_for_archive' indicates whether current item is for archive node.
		do
			value := ["", False, create {EB_METRIC_VALUE_TESTER}.make]
			old_make (create {EB_METRIC_DOMAIN}.make)
			pointer_button_press_actions.force_extend (agent activate_grid_item (?, ?, ?, ?, ?, ?, ?, ?, Current))
			dialog_ok_actions.extend (agent change_actions.call (Void))
			set_tooltip (metric_names.f_pick_and_drop_metric_and_items)
			set_dialog_function (agent value_criterion_dialog)
			set_is_empty_tester_displayed (True)
		end

	make_with_setting (a_domain: like domain; a_for_archive: BOOLEAN) is
			-- Initialize `domain' with `a_domain' and `is_for_archive' with `a_for_archive'.
		require
			a_domain_attached: a_domain /= Void
		do
			make
			set_domain (a_domain)
			set_is_for_archive (a_for_archive)
		end

feature -- Access

	change_value_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions called if the value has been changed. A value of `Void' means the value has been unset.
		do
			Result := change_actions
		end

feature -- Status report

	is_pebble_droppable (a_pebble: ANY): BOOLEAN is
			-- Can `a_pebble' be dropped on Current?
		local
			l_metric: EB_METRIC
		do
			Result := Precursor (a_pebble)
			if not Result then
				l_metric ?= a_pebble
				Result := l_metric /= Void
			end
		end

	is_for_archive: BOOLEAN
			-- Is Current item for archive node?

	is_empty_tester_displayed: BOOLEAN
			-- Should some message be displayed when no value tester is specified?
			-- Default: True

feature -- Setting

	load_criterion (a_criterion: EB_METRIC_VALUE_CRITERION) is
			-- Load `a_criterion' into Current.
		local
			l_domain: EB_METRIC_DOMAIN
		do
			check a_criterion.domain /= Void end
			l_domain := a_criterion.domain.twin
			set_domain (l_domain)
			set_value ([a_criterion.metric_name, a_criterion.should_delayed_domain_from_parent_be_used, a_criterion.value_tester])
		end

	store_criterion (a_criterion: EB_METRIC_VALUE_CRITERION) is
			-- Store Current in `a_criterion'.
		local
			l_value: TUPLE [a_metric_name: STRING; a_parent_used: BOOLEAN; a_tester: EB_METRIC_VALUE_TESTER]
			l_tester: EB_METRIC_VALUE_TESTER
			l_metric_name: STRING
		do
			check domain /= Void end
			a_criterion.set_domain (domain.twin)

			l_value := value
			if l_value = Void then
				l_value := ["", False, create {EB_METRIC_VALUE_TESTER}.make]
			end
			l_metric_name := l_value.a_metric_name
			if l_metric_name = Void then
				l_metric_name := ""
			end
			l_tester := l_value.a_tester
			if l_tester = Void then
				create l_tester.make
			end
			a_criterion.set_metric_name (l_metric_name)
			a_criterion.set_value_tester (l_tester)
			a_criterion.set_should_delayed_domain_from_parent_be_used (l_value.a_parent_used)
		end

	set_is_for_archive (b: BOOLEAN) is
			-- Set `is_for_archive' with `b'.
		do
			is_for_archive := b
		ensure
			is_for_archive_set: is_for_archive = b
		end

	set_is_empty_tester_displayed (b: BOOLEAN) is
			-- Set `is_empty_tester_displayed' with `b'.
		do
			is_empty_tester_displayed := b
		ensure
			is_empty_tester_displayed_set: is_empty_tester_displayed = b
		end

feature -- Drop

	drop_pebble (a_pebble: ANY) is
			-- Drop `a_pebble' into Current.
		local
			l_metric: EB_METRIC
			l_value: like value
		do
			l_metric ?= a_pebble
			if l_metric /= Void then
				l_value := value
				if l_value = Void then
					l_value := [l_metric.name, False, create {EB_METRIC_VALUE_TESTER}.make]
				else
					l_value.put (l_metric.name, 1)
				end
				set_value (l_value)
			else
				Precursor (a_pebble)
			end
		end

feature{NONE} -- Implementation

	prepare_components is
			-- Prepare components for display.
		local
			l_tester: EB_METRIC_VALUE_TESTER
			l_metric_name: STRING
			l_tokens: LINKED_LIST [EDITOR_TOKEN]
			l_value: like value
			l_writer: like token_writer
			l_component: EB_GRID_EDITOR_TOKEN_COMPONENT
		do
			create l_tokens.make
			l_writer := token_writer
			l_writer.set_context_group (Void)
			l_value := value
			l_metric_name ?= l_value.item (1)
			if l_metric_name = Void then
				l_metric_name := ""
			end
			l_tester ?= l_value.item (3)
			if l_tester = Void then
				create l_tester.make
			end

				-- Prepare the value tester part			
			editor_token_output.wipe_out
			if is_empty_tester_displayed or else not l_tester.criteria.is_empty then
				expression_generator.generate_output (l_tester)
			end
			l_tokens.append (editor_token_output.generated_output)
			if is_for_archive then
				create l_component.make (l_tokens, 2)
				l_component.set_overriden_fonts (label_font_table, label_font_height)
				append_component (l_component)
			else
					-- Prepare metric part
				l_writer.new_line
				if not l_tokens.is_empty then
					l_writer.add (ti_comma)
					l_writer.add (ti_space)
				end
				if metric_manager.is_metric_calculatable (l_metric_name) then
					l_writer.add (ti_double_quote + l_metric_name + ti_double_quote)
				elseif l_metric_name.is_empty then
				l_writer.add_error (create {SYNTAX_ERROR}.make (1, 1, "", ""), metric_names.te_no_metric)
				else
					l_writer.add_error (create {SYNTAX_ERROR}.make (1, 1, "", ""), ti_double_quote + l_metric_name + ti_double_quote)
				end
				if not domain.is_empty then
					l_writer.add (ti_comma)
				end
				l_tokens.append (l_writer.last_line.content)
				create l_component.make (l_tokens, 2)
				l_component.set_overriden_fonts (label_font_table, label_font_height)
				append_component (l_component)

					-- Prepare input domain part.
				if not domain.is_empty then
					components_for_domain.do_all (agent append_component)
				end
			end
		end

	expression_generator: EB_METRIC_EXPRESSION_GENERATOR is
			-- Expression generator to generate editor editor output for current item
		once
			create Result.make (editor_token_output)
		ensure
			result_attached: Result /= Void
		end

	editor_token_output: EB_METRIC_EXPRESSION_EDITOR_TOKEN_OUTPUT is
			-- Output from `expression_generator'
		once
			create Result.make (token_writer)
		ensure
			result_attached: Result /= Void
		end

end
