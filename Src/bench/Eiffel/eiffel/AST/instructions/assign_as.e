indexing
	description: "Abstract description of an assignment. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class ASSIGN_AS

inherit
	INSTRUCTION_AS
		redefine
			byte_node
		end

feature {AST_FACTORY} -- Initialization

	initialize (t: like target; s: like source; l: TOKEN_LOCATION) is
			-- Create a new ASSIGN AST node.
		require
			t_not_void: t /= Void
			s_not_void: s /= Void
			l_not_void: l /= Void
		do
			target := t
			source := s
			location := l.twin
		ensure
			target_set: target = t
			source_set: source = s
			location_set: location.is_equal (l)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_assign_as (Current)
		end

feature -- Attributes

	target: ACCESS_AS
			-- Target of the assignment

	source: EXPR_AS
			-- Source of the assignment

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (source, other.source) and then
				equivalent (target, other.target)
		end

feature {NONE} -- Type check, byte code production, dead_code_removal

	perform_type_check is
			-- Type check an assignment
		local
			access: ACCESS_B
			ve03: VE03
		do
				-- Init type stack
			context.begin_expression
   
				-- Type check the target
			target.type_check

				-- Check if the target is not read-only mode. Remember that
				-- a failure an on access will raise an error. So here, we
				-- know that the routine `type_check' appiled on `target'
				-- didn't fail.
			access := context.access_line.access
			if  access.read_only then
					-- Read-only entity
				create ve03
				context.init_error (ve03)
				ve03.set_target (target)
				Error_handler.insert_error (ve03)
			end

				-- Type check the source
			source.type_check

				-- Check validity
			check_validity
		end

	check_validity is
			-- Check if the target type conforms to the source one
		local
			source_type, target_type: TYPE_A
			l_vjar: VJAR
			l_vncb: VNCB
		do
				-- Reset convertibility info.
			conversion_info := Void
			
				-- Stack managment
			source_type := context.item
			context.pop (1)
			target_type := context.item.actual_type

				-- Type checking
				--| If `source_type' is of type NONE_A and if `target_type' does
				--| not conform to NONE, we generate in all the cases a VJAR error,
				--| we do not try to specify what kind of error, i.e.
				--| 1- if target was a basic or an expanded type, we should generate
				--|    a VNCE error.
				--| 2- if target was a BIT type, we should generate a VNCB error.
			if not source_type.conform_to (target_type) then
				if source_type.convert_to (context.current_class, target_type) then
					conversion_info := context.last_conversion_info
					if conversion_info.has_depend_unit then
						context.supplier_ids.extend (conversion_info.depend_unit)
					end
				elseif
					source_type.is_expanded and then target_type.is_external and then
					source_type.reference_actual_type.conform_to (target_type)
				then
						-- No need for conversion, this is currently done at the code
						-- generation level to properly handle the generic case.
						-- If not done at the code generation, we would need the following
						-- line.
					-- create {BOX_CONVERSION_INFO} conversion_info.make (source_type)
				elseif
					source_type.is_expanded and then
					source_type.convert_to (context.current_class,
						source_type.reference_actual_type) and then
					source_type.reference_actual_type.conform_to (target_type)
				then
					conversion_info := context.last_conversion_info
					if conversion_info.has_depend_unit then
						context.supplier_ids.extend (conversion_info.depend_unit)
					end
				else
						-- Type does not convert neither, so we raise an error
						-- about non-conforming types.
					if source_type.is_bits then
						create l_vncb
						context.init_error (l_vncb)
						l_vncb.set_target_name (target.access_name)
						l_vncb.set_source_type (source_type)
						l_vncb.set_target_type (target_type)
						Error_handler.insert_error (l_vncb)
					else
						create l_vjar
						context.init_error (l_vjar)
						l_vjar.set_source_type (source_type)
						l_vjar.set_target_type (target_type)
						l_vjar.set_target_name (target.access_name)
						Error_handler.insert_error (l_vjar)
						
					end
				end
			end
				-- Update type stack
			context.pop (1)
		end

	byte_node: ASSIGN_B is
			-- Associated byte node
		do
			create Result
			Result.set_target (target.byte_node)
			if conversion_info /= Void then
				Result.set_source (conversion_info.byte_node (source.byte_node))
					-- We don't need the information, so let's reset it.
				conversion_info := Void
			else
				Result.set_source (source.byte_node)
			end
			Result.set_line_number (line_number)
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconsitute text.
		do
			ctxt.put_breakable
			ctxt.new_expression
			ctxt.format_ast (target)
			ctxt.put_space
			ctxt.put_text_item_without_tabs (assign_symbol)
			ctxt.put_space
			ctxt.new_expression
			ctxt.format_ast (source)
		end

feature {ASSIGN_AS} -- Formatter

	assign_symbol: TEXT_ITEM is
		do
			Result := ti_Assign
		end
		
feature {ASSIGN_AS}	-- Replication
		
	set_target (t: like target) is
		require
			valid_arg: t /= Void
		do
			target := t
		end

	set_source (s: like source) is
		require
			valid_arg: s /= Void
		do
			source := s
		end

feature {NONE} -- Convertibility

	conversion_info: CONVERSION_INFO
			-- Store information about source and target type to perform proper conversion.

end -- class ASSIGN_AS
