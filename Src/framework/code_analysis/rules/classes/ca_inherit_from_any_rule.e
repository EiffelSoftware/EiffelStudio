note
	description: "[
			RULE #31: Explicit inheritance from ANY
			
			Inheritance with no adaptations from the ANY class need not explicitely be defined. This should be removed.
		]"
	author: "Samuel Schmid"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_INHERIT_FROM_ANY_RULE

	-- TODO Improvements: Things like export are ignored. (Class CONSOLE getting a false violation)

inherit
	CA_STANDARD_RULE
	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make
		do
			make_with_defaults
			create renames.make (10)
		end

feature {NONE} -- Activation

	register_actions (a_checker: CA_ALL_RULES_CHECKER)
		do
			a_checker.add_class_pre_action (agent check_inheritance)
		end

feature {NONE} -- Rule checking

	check_inheritance (a_class: CLASS_AS)
		-- Checks whether `a_class' inherits explicitly from ANY or not.
		do
			if
				attached a_class.parent_with_name ("ANY") as l_any and then
				not has_adaptations_to_any (a_class)
			then
				-- Explicit inheritance from ANY found.
				-- Class has no adapations to ANY, inheritance is not needed.
				create_violation (l_any)
			end
		end

	has_adaptations_to_any (a_class: CLASS_AS): BOOLEAN
		-- Does `a_class' have any adaptations to ANY?
		do
			if attached a_class.parents as l_parents then
				if
					not a_class.is_equivalent (current_context.checking_class.ast)
					and then attached a_class.parent_with_name ("ANY") as l_any
					and then not (attached l_any.renaming
						or attached l_any.undefining
						or attached l_any.redefining)
				then
					-- This means that there is a plain inheritance to ANY which "resets" the adaptations all the parents of this class had,
					-- hence we return False.
					-- We cannot account for this case in the checking_class because otherwise we violate the rule every time we tried to reset
					-- adaptations by inheriting plainly from ANY.
					Result := False
				else
					from
						l_parents.start
					until
						Result or l_parents.after
					loop
						-- Set parameters for checking the changes to parents
						current_class := current_context.universe.class_named (l_parents.item.type.class_name.name_8, current_context.checking_class.group).compiled_class
						set_renamed_features (l_parents.item)
						Result :=
							(attached l_parents.item.renaming and then l_parents.item.renaming.there_exists (agent is_rename_written_by_any)) or
							(attached l_parents.item.undefining and then l_parents.item.undefining.there_exists (agent is_feature_written_by_any)) or
							(attached l_parents.item.redefining and then l_parents.item.redefining.there_exists (agent is_feature_written_by_any)) or
							has_adaptations_to_any (current_context.universe.class_named (l_parents.item.type.class_name.name_8, current_context.checking_class.group).compiled_class.ast)
						l_parents.forth
					end
				end
			end
		end

	is_rename_written_by_any (a_rename: RENAME_AS): BOOLEAN
		do
			Result := is_feature_written_by_any (a_rename.old_name)
		end

	is_feature_written_by_any (a_feature: FEATURE_NAME): BOOLEAN
		local
			l_feature: FEATURE_NAME
		do
			-- For renames we need to check the old name.
			if renames.has (a_feature.visual_name) then
				l_feature := renames.at (a_feature.visual_name)
			else
				l_feature := a_feature
			end

			Result := current_class.feature_named (l_feature.visual_name).written_class.name_in_upper.is_equal ("ANY")
		end

	create_violation (a_parent: PARENT_AS)
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_INHERIT_FROM_ANY_FIX
		do
			create l_violation.make_with_rule (Current)
			l_violation.set_location (a_parent.start_location)
			l_violation.long_description_info.extend (current_context.checking_class.name_in_upper)

			create l_fix.make_with_class (current_context.checking_class)
			l_violation.fixes.extend (l_fix)

			violations.extend (l_violation)
		end

	set_renamed_features (a_parent: PARENT_AS)
		do
			renames.wipe_out
			if attached a_parent.renaming as l_renamings then
				across l_renamings as l_rename loop
					renames.extend (l_rename.old_name, l_rename.new_name.visual_name)
				end
			end
		end

	renames: HASH_TABLE [FEATURE_NAME, STRING]

feature -- Properties

	name: STRING = "inheritance_from_any"
			-- <Precursor>

	current_class: CLASS_C

	title: STRING_32
		do
			Result := ca_names.inherit_from_any_title
		end

	id: STRING_32 = "CA031"

	description: STRING_32
		do
			Result := ca_names.inherit_from_any_description
		end


	format_violation_description (a_violation: CA_RULE_VIOLATION; a_formatter: TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.inherit_from_any_violation_1)
			check
				attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first
			end
			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_class_name then
				a_formatter.add (l_class_name)
			end
			a_formatter.add (ca_messages.inherit_from_any_violation_2)
		end

end
