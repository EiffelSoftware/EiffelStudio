indexing
	description: "Access for the address operator. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class ACCESS_ADDRESS_AS

inherit
	ACCESS_ID_AS
		redefine
			process, feature_access_type
		end

	SHARED_TYPES

create
	make

feature

	make (s: ID_AS) is
			-- Initialization
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
		do
			feature_name := s
		ensure
			feature_name_set: feature_name = s
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_access_address_as (Current)
		end

feature -- Type check

	feature_access_type: TYPE_A is
			-- Access type for a feature
		local
			last_type, last_constrained: TYPE_A
			last_class: CLASS_C
			last_id: INTEGER
			a_feature: FEATURE_I
			access_b: ACCESS_B
			depend_unit: DEPEND_UNIT
			veen: VEEN
			vzaa1: VZAA1
		do
			last_type := context.item
			last_constrained := context.last_constrained_type
			last_class := last_constrained.associated_class
			last_id := last_class.class_id

			a_feature := last_class.feature_table.item (feature_name)

			if not valid_feature (a_feature) then
				create veen
				context.init_error (veen)
				veen.set_location (feature_name)
				veen.set_identifier (feature_name)
				Error_handler.insert_error (veen)
			else
				if a_feature.is_constant then
					create vzaa1
					context.init_error (vzaa1)
					vzaa1.set_location (feature_name)
					vzaa1.set_address_name (feature_name)
					Error_handler.insert_error (vzaa1)
				else
					if a_feature.is_attribute then
						Result ?= a_feature.type
						Result := Result.conformance_type
						Result := Result.instantiation_in (last_type, last_id).actual_type
					else
						Result := Pointer_type
					end

						-- Dependance
					create depend_unit.make_with_level (last_id, a_feature,
						context.depend_unit_level)
					context.supplier_ids.extend (depend_unit)

						-- Access managment
					access_b := a_feature.access (Result.type_i)
					context.access_line.insert (access_b)
				end
			end
			Error_handler.checksum
		end

end -- class ACCESS_ADDRESS_AS
