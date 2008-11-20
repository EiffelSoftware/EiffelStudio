indexing
	description: "Summary description for {AUT_SHARED_INTERPRETER_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	AUT_SHARED_INTERPRETER_INFO

feature -- Access

	system: SYSTEM_I is
			-- Sysetm
		deferred
		ensure
			result_attached: Result /= Void
		end

	compute_interpreter_root_class
			-- Try assigning `interpreter_root_class'.
		local
			l_class: CLASS_I
		do
			interpreter_root_class_cell.put (Void)
			if {l_cluster: CONF_CLUSTER} system.eifgens_cluster then
				l_class := system.universe.class_named (interpreter_root_class_name, l_cluster)
				if l_class /= Void and then l_class.is_compiled then
					interpreter_root_class_cell.put (l_class.compiled_representation)
				end
			end
		end

	interpreter_class: ?CLASS_C
			-- Compiled representation of "ITP_INTERPRETER"
		local
			l_parents: FIXED_LIST [CLASS_C]
		do
			if {l_root: CLASS_C} interpreter_root_class then
				l_parents := l_root.parents_classes
				if not l_parents.is_empty then
					Result := l_parents.first
				end
			end
		end

	interpreter_root_class: ?CLASS_C
			-- Compiled representation of "ITP_INTERPRETER_ROOT"
		do
			Result := interpreter_root_class_cell.item
		end

	interpreter_root_class_cell: CELL [?CLASS_C]
			-- Once per thread cell for `interpreter_root_class'
		once
			create Result
		end

	interpreter_class_name: STRING = "ITP_INTERPRETER"
			-- Name of interpreter class

	interpreter_root_class_name: STRING = "ITP_INTERPRETER_ROOT"
			-- Name of root lass for interpreter

	interpreter_root_feature_name: STRING = "execute"
			-- Name of root feature for interpreter

	feature_name_for_byte_code_injection: STRING = "execute_byte_code"
			-- Name of feature whose byte code is to be injected.

	feature_for_byte_code_injection: FEATURE_I is
			-- Feature whose byte-code is to be injected
		do
			Result := interpreter_root_class.feature_named (feature_name_for_byte_code_injection)
		ensure
			result_attached: Result /= Void
		end

	interpreter_related_classes: DS_HASH_SET [STRING] is
			-- List of names of classes which interpreter rely on,
			-- Make sure those classes are not tested.
			-- Fixme: Write
		once
			create Result.make (10)
			Result.set_equality_tester (
				create {AGENT_BASED_EQUALITY_TESTER [STRING]}.make (
					agent (str1, str2: STRING): BOOLEAN
						do
							Result := str1.is_equal (str2)
						end))

			Result.force_last ("ITP_INTERPRETER")
			Result.force_last ("ITP_REQUEST_PARSER")
			Result.force_last ("ITP_STORE")
			Result.force_last ("ITP_EXPRESSION")
			Result.force_last ("ITP_CONSTANT")
			Result.force_last ("ITP_EXPRESSION_PROCESSOR")
			Result.force_last ("ITP_VARIABLE")
			Result.force_last ("ERL_LIST")
		ensure
			result_attached: Result /= Void
		end

end
