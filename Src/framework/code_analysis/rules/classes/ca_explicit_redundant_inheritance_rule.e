note
	description: "[
			RULE #89: Explicit redundant inheritance

			Explicitly duplicated inheritance links are redundant if there is no renaming, 
			redefining, or change of export status. One should be removed.
		]"
	author: "Paolo Antonucci"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_EXPLICIT_REDUNDANT_INHERITANCE_RULE

inherit

	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			make_with_defaults
			severity := severity_hint
		end

feature {NONE} -- Activation

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
			-- <Precursor>
		do
			a_checker.add_class_pre_action (agent process_class)
		end

feature {NONE} -- Rule checking

	process_class (a_class: CLASS_AS)
			-- Process `a_class'.
		local
			l_viol: CA_RULE_VIOLATION
			l_seen_parents: HASH_TABLE [BOOLEAN, STRING_32]
				-- STRING key: the class name. Eiffel has no namespace, thus this is a class unique identifier.
				-- BOOLEAN value: if set to true, we have already generated a violation, further violations
				-- for the same parent class will be ignored.
			l_parent_class_name: STRING_32
		do
				-- Sample violation:
				--
				-- class
				--		MY_CLASS
				--
				-- inherit
				--		PARENT_CLASS
				--		OTHER_PARENT_CLASS
				--		PARENT_CLASS
				--
				-- end

				-- Inheriting from the same class twice with different generic type parameters (e.g. LIST [STRING] and LIST [BOOLEAN])
				-- is not supported, so we don't need to worry about this.
			if attached a_class.parents as l_parents then
				create l_seen_parents.make (32)
				across
					l_parents as ic
				loop
						-- Only complain if there are no export, redefine, rename, select and undefine clauses.
					if ic.exports = Void and then ic.redefining = Void and then ic.renaming = Void and then ic.selecting = Void and then ic.undefining = Void then
						l_parent_class_name := ic.type.class_name.name_32
						if l_seen_parents.has (ic.type.class_name.name_32) and then not l_seen_parents.at (ic.type.class_name.name_32) then
							create l_viol.make_with_rule (Current)
							l_viol.set_location (ic.start_location)
							l_viol.long_description_info.extend (l_parent_class_name)
							violations.extend (l_viol)
							l_seen_parents.at (l_parent_class_name) := true
						else
							l_seen_parents.put (false, l_parent_class_name)
						end
					end
				end
			end
		end

feature -- Properties

	name: STRING = "duplicated_parent"
			-- <Precursor>

	title: STRING_32
			-- <Precursor>
		do
			Result := ca_names.explicit_redundant_inheritance_title
		end

	id: STRING_32 = "CA089"
			-- <Precursor>

	description: STRING_32
			-- <Precursor>
		do
			Result := ca_names.explicit_redundant_inheritance_description
		end

	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
			-- <Precursor>
		do
			a_formatter.add (ca_messages.explicit_redundant_inheritance_violation_1)
			a_formatter.add_class (a_violation.affected_class.original_class)
			a_formatter.add (ca_messages.explicit_redundant_inheritance_violation_2)
			check
				attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first
			end
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_class_name then
				a_formatter.add_quoted_text (l_class_name)
			end
			a_formatter.add (ca_messages.explicit_redundant_inheritance_violation_3)
		end

end
