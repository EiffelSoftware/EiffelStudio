note
	description: "TODO"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	E2B_CUSTOM_NESTED_HANDLER

inherit

	E2B_SHARED_CONTEXT
		export {NONE} all end

	IV_SHARED_TYPES

	IV_SHARED_FACTORY

	INTERNAL_COMPILER_STRING_EXPORTER

feature -- Status report

	is_handling_nested (a_nested: NESTED_B): BOOLEAN
			-- Is this handler handling the call?
		deferred
		end

feature -- Basic operations

	handle_nested_in_body (a_translator: E2B_BODY_EXPRESSION_TRANSLATOR; a_nested: NESTED_B)
			-- Handle nested node in body.
		deferred
		end

	handle_nested_in_contract (a_translator: E2B_CONTRACT_EXPRESSION_TRANSLATOR; a_nested: NESTED_B)
			-- Handle nested node in contract.
		deferred
		end

end
