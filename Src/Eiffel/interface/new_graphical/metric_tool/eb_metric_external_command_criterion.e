note
	description: "External command criterion"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_EXTERNAL_COMMAND_CRITERION

inherit
	EB_METRIC_CRITERION
		redefine
			make,
			process,
			is_external_command_criterion
		end

create
	make

feature{NONE} -- Initialization

	make (a_scope: like scope; a_name: STRING)
			-- Initialize `scope' with `a_scope' and `name' with `a_name'.
		do
			Precursor (a_scope, a_name)
			create tester.make ("")
		end

feature -- Access

	new_criterion (a_scope: QL_SCOPE): QL_CRITERION
			-- QL_CRITERION representing current criterion			
			-- `a_scope' is only used in delayed criterion.			
		do
			Result := criterion_factory_table.item (a_scope).criterion_with_name (name, [agent tester.evaluate])
			tester.set_criterion (Result)
		end

	tester: EB_METRIC_EXTERNAL_COMMAND_TESTER
			-- External command tester

feature -- Status report

	is_parameter_valid: BOOLEAN
			-- Is parameters of current criterion valid?
		do
			Result := tester.is_command_specified
		ensure then
			good_result: Result = tester.is_command_specified
		end

	is_external_command_criterion: BOOLEAN = True
			-- Is current an external command criterion?

feature -- Process

	process (a_visitor: EB_METRIC_VISITOR)
			-- Process current using `a_visitor'.
		do
			a_visitor.process_external_command_criterion (Current)
		end

invariant
	tester_attached: tester /= Void

end
