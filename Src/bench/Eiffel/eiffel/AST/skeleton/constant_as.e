indexing
	description:
		"Abstract description of a the content of an Eiffel %
		%constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class CONSTANT_AS

inherit
	CONTENT_AS
		redefine
			is_constant, is_unique,
			byte_node, type_check
		end

create
	make

feature {NONE} -- Initialization

	make (v: like value) is
			-- Create a new CONSTANT AST node.
		require
			v_not_void: v /= Void
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_constant_as (Current)
		end

feature -- Attributes

	value: VALUE_AS
			-- Constant value

feature -- Properties

	is_constant: BOOLEAN is True
			-- Is the current content a constant one ?

	is_unique: BOOLEAN is
			-- Is the content a unique ?
		do
			Result := value.terminal.is_unique
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (value, other.value)
		end

feature -- Access

	is_body_equiv (other: like Current): BOOLEAN is
			-- Are the values of Current and other the
			-- same?
		do
			Result := equivalent (value, other.value)
		end

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
		do
			Result := False
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this constant.
			-- Result is `0'.
		do
			Result := 0
		end

feature -- Conveniences

	value_i: VALUE_I is
			-- Interface constant value
		require
			is_constant and then not is_unique
		do
			Result := value.value_i
		end

	type_check is
		do
			value.type_check
		end

	byte_node: BYTE_CODE is
			-- Associated byte code
		do
		ensure then
			False
		end

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_space
			ctxt.put_text_item_without_tabs (ti_Is_keyword)
			ctxt.put_space
			ctxt.format_ast (value)
		end

feature {CONSTANT_AS} -- Replication

	set_value (v: like value) is
		do
			value := v
		end
		
invariant
	value_not_void: value /= Void

end -- class CONSTANT_AS
