indexing

	description:
		"Abstract description of a reverse assignment. %
		%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class REVERSE_AS

inherit
	ASSIGN_AS
		redefine
			process,
			check_validity, byte_node
		end

create
	initialize

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_reverse_as (Current)
		end

feature -- Access

	check_validity is
			-- Check validity of the reverse assignment
		local
			target_type, source_type: TYPE_A
			vjrv1: VJRV1
			l_formal: FORMAL_A
			vjrv2: VJRV2
		do
			conversion_info := Void
			
				-- Stack managment
			source_type := context.item
			context.pop (1)
			target_type := context.item
			
			if target_type.is_expanded then
				if not System.il_generation then
					create vjrv1
					context.init_error (vjrv1)
					vjrv1.set_target_name (target.access_name)
					vjrv1.set_target_type (target_type)
					vjrv1.set_location (target.end_location)
					Error_handler.insert_error (vjrv1)
				end
			elseif target_type.is_formal then
				l_formal ?= target_type
				check
					l_formal_not_void: l_formal /= Void
				end
				if not l_formal.is_reference and not system.il_generation then
					create vjrv2
					context.init_error (vjrv2)
					vjrv2.set_target_name (target.access_name)
					vjrv2.set_target_type (target_type)
					vjrv2.set_location (target.end_location)
					Error_handler.insert_error (vjrv2)
				end
			else
					-- Target is a reference, but source is not.
				if source_type.is_expanded then
						-- Special case `ref ?= exp' where we convert
						-- `exp' to its associated reference before
						-- doing the assignment.
					if source_type.convert_to (context.current_class, target_type) then
						conversion_info := context.last_conversion_info
						if conversion_info.has_depend_unit then
							context.supplier_ids.extend (conversion_info.depend_unit)
						end
					end
				elseif source_type.is_formal then
						-- Special case `ref ?= formal' where we force 
						-- a conversion of the formal to its associated reference
						-- type when `formal' will be instantiated as an expanded
						-- type. Then after the conversion we perform the normal
						-- assignment attempt to the target which is a reference.
					l_formal ?= source_type
					if
						source_type.convert_to (context.current_class,
							context.current_class.constraint (l_formal.position))
					then
						conversion_info := context.last_conversion_info
						if conversion_info.has_depend_unit then
							context.supplier_ids.extend (conversion_info.depend_unit)
						end
					end
				end
			end
				-- Update type stack
			context.pop (1)
		end

	byte_node: REVERSE_B is
			-- Associated byte code
		local
			l_access: ACCESS_B
			l_local: LOCAL_B
			l_attribute: ATTRIBUTE_B
			l_create_info: CREATE_INFO
			l_feature_type, l_local_type: TYPE_A
		do
			create Result
			l_access := target.byte_node
			Result.set_target (l_access)
			if conversion_info /= Void then
				Result.set_source (conversion_info.byte_node (source.byte_node))
				conversion_info := Void
			else
				Result.set_source (source.byte_node)
			end
			Result.set_line_number (target.start_location.line)
			
			if l_access.is_result then
				l_feature_type ?= context.current_feature.type
				l_create_info := l_feature_type.create_info
			elseif l_access.is_local then
				l_local ?= l_access
				l_local_type := context.local_ith (l_local.position).type
				l_create_info := l_local_type.create_info
			elseif l_access.is_attribute then
				l_attribute ?= l_access
				create {CREATE_FEAT} l_create_info.make (l_attribute.attribute_id,
					l_attribute.routine_id, context.current_class)
			else
				create {CREATE_TYPE} l_create_info.make (l_access.type)
			end
			
			Result.set_info (l_create_info)
		end

end -- class REVERSE_AS

