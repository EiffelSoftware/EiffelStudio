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
			check_validity, byte_node, assign_symbol
		end

feature -- Access

	check_validity is
			-- Check validity of the reverse assignment
		local
			target_type: TYPE_A
			vjrv1: VJRV1
			vjrv2: VJRV2
		do
				-- Stack managment
			context.pop (1)
			
			if not System.il_generation then
				target_type := context.item
				if target_type.is_expanded then
					create vjrv1
					context.init_error (vjrv1)
					vjrv1.set_target_name (target.access_name)
					vjrv1.set_target_type (target_type)
					Error_handler.insert_error (vjrv1)
				elseif target_type.is_formal then
					create vjrv2
					context.init_error (vjrv2)
					vjrv2.set_target_name (target.access_name)
					vjrv2.set_target_type (target_type)
					Error_handler.insert_error (vjrv2)
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
			Result.set_source (source.byte_node)
			Result.set_line_number (line_number)
			
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

feature {NONE} -- Formatter
	
	assign_symbol: TEXT_ITEM is 
		do
			Result := ti_Reverse_assign
		end

end -- class REVERSE_AS

