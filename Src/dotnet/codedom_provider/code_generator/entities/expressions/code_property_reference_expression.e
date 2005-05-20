indexing 
	description: "Source code generator for property reference expressions"
	date: "$$"
	revision: "$$"

class
	CODE_PROPERTY_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

	CODE_SHARED_EIFFEL_METADATA_PROVIDER
		export
			{NONE} all
		end

	CODE_DIRECTIONS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_getter: like property_name; a_target: like target) is
			-- Initialize instance
		require
			non_void_getter: a_getter /= Void
			non_void_target: a_target /= Void
		do
			property_name := a_getter
			target := a_target
		ensure
			getter_set: property_name = a_getter
			target_set: target = a_target
		end
		
feature -- Access

	property_name: STRING
			-- Name of property to reference
			
	target: CODE_EXPRESSION
			-- Target object
	
	is_set_reference: BOOLEAN
			-- get or set reference?
			
	code: STRING is
			-- | Result := "[`target_object'.]set_`property_name'" if `is_set_reference' else
			-- | OR		:= "[`target_object'.]`property_name'"
			-- | OR		:= "feature {`target_object'}.set/get_`property_name'" if typeof `target_object' is CODE_TYPE_REFERENCE_EXPRESSION
			-- Eiffel code of property reference expression
		local
			l_type_ref_exp: CODE_TYPE_REFERENCE_EXPRESSION
			l_type: CODE_TYPE_REFERENCE
		do
			create Result.make (120)
			l_type := target.type
			if l_type /= Void then
				if not is_current_generated_type (l_type) then
					l_type_ref_exp ?= target
					if l_type_ref_exp /= Void then
						Result.append ("feature {")
						Result.append (target.code)
						Result.append ("}.")
					else
						Result.append (target.code)
						Result.append (".")
					end
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_type, ["target of expression resolving to property " + property_name])
			end
			if property_accesser /= Void then
				Result.append (property_accesser.eiffel_name)
			end
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			if is_set_reference then
				Result := None_type_reference
			else
				Result := property_type
			end
		end

feature {CODE_STATEMENT_FACTORY} -- Element Settings

	set_is_set_reference (a_is_set_reference: like is_set_reference) is
			-- Set `is_set_reference' with `a_is_set_reference'.
		do
			is_set_reference := a_is_set_reference
		ensure
			is_set_reference_set: is_set_reference = a_is_set_reference
		end

feature {NONE} -- Implementation

	property_type: CODE_TYPE_REFERENCE is
			-- Type of property
		do
			if internal_property_type = Void and property_accesser /= Void then
				if is_set_reference then
					internal_property_type := property_accesser.arguments.first.type
				else
					internal_property_type := property_accesser.result_type
				end
			end
			Result := internal_property_type
		end
		
	property_accesser: CODE_MEMBER_REFERENCE is
			-- Property getter
		local
			l_name: STRING
		do
			if not property_searched then
				property_searched := True
				if is_set_reference then
					l_name := "set_" + property_name
					internal_property_accesser := target.type.member_from_name (l_name)
					if internal_property_accesser = Void then
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_feature, [l_name, target.type.name])
					end
				else
					l_name := "get_" + property_name
					internal_property_accesser := target.type.member (l_name, Void)
					if internal_property_accesser = Void then
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_feature, [l_name, target.type.name])
					end
				end
			end
			Result := internal_property_accesser
		end
		
	internal_property_accesser: CODE_MEMBER_REFERENCE
			-- Cache for `property_accesser'

	internal_property_type: CODE_TYPE_REFERENCE
			-- Cache for `property_type'

	property_searched: BOOLEAN
			-- Was `property_getter' or `property_setter' called?

invariant
	non_void_property_name: property_name /= Void
	non_void_target: target /= Void
	
end -- class CODE_PROPERTY_REFERENCE_EXPRESSION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
