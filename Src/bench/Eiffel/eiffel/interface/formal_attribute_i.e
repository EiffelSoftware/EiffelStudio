indexing
	description: "[
		Representation of a formal generic parameter from the point of view of
		inheritance. Instances of FORMAL_ATTRIBUTE_I are used in CLASS_C.
		
		A class that has a formal generic parameter or that inherits one
		(i.e. class B which inherits from class A [STRING], in B it inherits
		the formal generic parameter from A even though B is not generic) will
		have or more instances of a FORMAL_ATTRIBUTE_I.

		CLASS_C takes care of merging and type analyzing of FORMAL_ATTRIBUTE_I
		object since a FORMAL_ATTRIBUTE_I object will see its `type' changed
		with the inheritance. For example taking the above example, in A, the
		`type' is a FORMAL_A, but in B it is a CL_TYPE_A representing STRING.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAL_ATTRIBUTE_I

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
				set_feature_id, set_rout_id_set, set_origin_class_id,
				set_is_origin, set_feature_name, set_written_in,
				set_origin_feature_id,
				instantiate, duplicate, new_rout_id
			redefine
			new_entry, is_formal_attribute
		end
	
feature -- Access

	type: TYPE_A
			-- Type of current formal generic parameter.
			
	position: INTEGER
			-- Position of formal the first time it introduced.

feature -- Status report

	is_formal_attribute: BOOLEAN is True
			-- Current represents a formal attribute.
			
	is_formal: BOOLEAN is
			-- Is `type' a formal generic parameter?
		local
			l_formal: FORMAL_A
		do
			l_formal ?= type
			Result := l_formal /= Void
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
			-- New formal attribute unit.
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

end -- class FORMAL_ATTRIBUTE_I
