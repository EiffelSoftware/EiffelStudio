indexing
	description: "[
		Representation of a feature used to represent the type of either a
		formal generic parameter or an anchored type from the point of view of
		inheritance. Instances of TYPE_FEATURE_I are used in CLASS_C.
		
		In the case of a formal generic parameter:
		Class A that has a formal generic parameter or that inherits one
		(i.e. class B which inherits from class A [STRING], in B it inherits
		the formal generic parameter from A even though B is not generic) will
		have or more instances of a TYPE_FEATURE_I.

		CLASS_C takes care of merging and type analyzing of TYPE_FEATURE_I
		object since a TYPE_FEATURE_I object will see its `type' changed
		with the inheritance. For example taking the above example, in A, the
		`type' is a FORMAL_A, but in B it is a CL_TYPE_A representing STRING.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_FEATURE_I

inherit
	FEATURE_I
		rename
			type as return_type,
			set_type as set_return_type
		export
			{NONE} all
			{ANY}
				feature_id, rout_id_set, origin_class_id, is_origin,
				feature_name, written_in, origin_feature_id,
				feature_name_id,
				set_feature_id, set_rout_id_set, set_origin_class_id,
				set_is_origin, set_feature_name, set_written_in,
				set_origin_feature_id, set_feature_name_id,
				instantiate, duplicate, new_rout_id
		redefine
			new_entry, is_type_feature, check_expanded
		end
	
feature -- Access

	type: TYPE_A
			-- Type of current.
			
	position: INTEGER
			-- Position of formal first time it introduced.

feature -- Status report

	is_type_feature: BOOLEAN is True
			-- Current represents a type feature.
			
	is_formal: BOOLEAN is
			-- Is `type' a formal generic parameter?
		local
			l_formal: FORMAL_A
		do
			l_formal ?= type
			Result := l_formal /= Void
		end

feature -- Checking

	check_expanded (class_c: CLASS_C) is
			-- Check expanded validity rules
		local
			solved_type: TYPE_A
			vtec1: VTEC1
			vtec2: VTEC2
			vlec: VLEC
		do
			if class_c.class_id = written_in then
					-- Check validity of an expanded in a formal generic parameter.

					-- `type' has been evaluated and therefore
					-- the assignment attempt is valid.
				solved_type ?= type
				check
					solved_type_not_void: solved_type /= Void
				end
				if solved_type.has_expanded then
					if solved_type.expanded_deferred then
						create vtec1
						vtec1.set_class (written_class)	
						vtec1.set_feature (Current)
						vtec1.set_entity_name (feature_name)
						Error_handler.insert_error (vtec1)
					elseif not solved_type.valid_expanded_creation (class_c) then
						create vtec2
						vtec2.set_class (written_class)	
						vtec2.set_feature (Current)
						vtec2.set_entity_name (feature_name)
						Error_handler.insert_error (vtec2)
					elseif
						solved_type.is_true_expanded and then
						solved_type.associated_class = class_c
					then
						create vlec
						vlec.set_class (solved_type.associated_class)
						vlec.set_client (class_c)
						Error_handler.insert_error (vlec)
					end
				end
				if solved_type.has_generics then
					system.expanded_checker.check_actual_type (solved_type)
				end
				if arguments /= Void then
					arguments.check_expanded (class_c, Current)
				end
			end
		end

feature -- Settings

	set_type (a_type: like type) is
			-- Set `a_type' to `type'.
		require
			a_type_not_void: a_type /= Void
		do
			type := a_type
		ensure
			type_set: a_type = type
		end
		
	set_position (a_pos: like position) is
			-- Set `a_pos' to `position'.
		require
			valid_pos: a_pos > 0
		do
			position := a_pos
		ensure
			position_set: position = a_pos
		end
		
feature -- Polymorphism

	new_entry (rout_id: INTEGER): ATTR_ENTRY is
			-- New type feature unit.
		do
			create Result
			Result.set_type_a (type.actual_type)
			Result.set_feature_id (feature_id)
		end
		
feature {NONE} -- Implementation

	new_api_feature: E_FEATURE is
			-- API feature.
			-- Cannot be called in Current context.
		do
			check
				not_called: False
			end
		end
		
feature {NONE} -- Replication

	replicated: FEATURE_I is
			-- Replicated feature.
			-- Cannot be called in Current context.
		do
			check
				not_called: False
			end
		end
		
	unselected (in: INTEGER): FEATURE_I is
			-- Unselected feature.
			-- Cannot be called in Current context.
		do
			check
				not_called: False
			end
		end

end -- class TYPE_FEATURE_I
