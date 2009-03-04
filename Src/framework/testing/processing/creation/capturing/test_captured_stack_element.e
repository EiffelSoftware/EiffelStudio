note
	description: "[
		Objects representing a call stack element, refering to the feature called in the specific
		element and its attributes and objects.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CAPTURED_STACK_ELEMENT

create
	make

feature {NONE} -- Initialization

	make (a_feature: like called_feature; a_type: like type)
			-- Initialize `Current'.
		do
			type := a_type
			called_feature := a_feature
			if is_creation_procedure then
				create internal_operands.make (called_feature.argument_count)
			else
				create internal_operands.make (called_feature.argument_count + 1)
			end
			create internal_types.make (internal_operands.capacity)
		ensure
			called_feature_set: called_feature = a_feature
		end

feature -- Access

	called_feature: attached E_FEATURE
			-- Feature called in stack element

	type: attached STRING
			-- Dynamic type for `called_feature'

	operands: attached DS_LINEAR [attached STRING]
			-- Operands needed to invoce `called_feature'
		do
			Result := internal_operands
		end

	types: attached DS_LINEAR [attached STRING]
			-- Types for `operands'
		do
			Result := internal_types
		end

feature {NONE} -- Access

	internal_operands: attached DS_ARRAYED_LIST [attached STRING]
			-- Internal storage for `operands'

	internal_types: attached DS_ARRAYED_LIST [attached STRING]
			-- Internal storage for `types'

feature -- Status report

	are_operands_complete: BOOLEAN
			-- Does `operands' have correct amount of items to invoce `called_feature'?
		local
			l_count: INTEGER
		do
			l_count := called_feature.argument_count
			if not is_creation_procedure then
				l_count := l_count + 1
			end
			Result := internal_operands.count = l_count
		end

	is_creation_procedure: BOOLEAN
			-- Is `called_feature' a creation procedure?
		local
			l_class: CLASS_C
		do
			l_class := called_feature.associated_class
			Result := l_class.creation_feature = called_feature.associated_feature_i
			if not Result then
				Result := l_class.creators /= Void and then l_class.creators.has (called_feature.name)
			end
		end

	is_xfix: BOOLEAN
			-- Is `called_feature' a infix or a prefix feature?
		do
			Result := called_feature.is_infix or called_feature.is_prefix
		end

feature {TEST_CAPTURER} -- Element change

	add_operand (a_operand: attached STRING; a_type: attached STRING)
			-- Add `a_operand' to `operands'.
		require
			not_complete: not are_operands_complete
		do
			internal_operands.force_last (a_operand)
			internal_types.force_last (a_type)
		end

end
