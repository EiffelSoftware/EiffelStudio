indexing 
	description: "Source code generator for event reference expression"
	date: "$$"
	revision: "$$"
	
class
	ECDP_EVENT_REFERENCE_EXPRESSION

inherit
	ECDP_REFERENCE_EXPRESSION
	
	EVENT_TYPE
	
	ECDP_SHARED_CONSUMER_CONTEXT

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		do
			create arguments.make
			create event_name.make_empty
		ensure
			non_void_event_name: event_name /= Void
		end
		
feature -- Access

	event_name: STRING
			-- Event name
	
	target_object: ECDP_EXPRESSION
			-- Target object
			
	event_type: STRING
			-- Type of the event: adder, remover or raiser

	code: STRING is
			-- | Result := "`target object'.[`event_name']"
			-- In fact the `event_name' will be generate in the ECDP_ATTACH_EVENT_STATEMENT or in the ECDP_REMOVE_EVENT_STATEMENT
			-- Eiffel code of event reference expression
		do
			Check
				not_empty_event_name: not event_name.is_empty
				non_void_target_object: target_object /= Void
			end
		
			create Result.make (120)
			if new_line then
				Result.append (indent_string)
				set_new_line (False)
			end
			Result.append (target_object.code)
			Result.append (Dictionary.Dot_keyword)
			Result.append (event_name)
		end
		
feature -- Status Report

	ready: BOOLEAN is 
			-- Is expression ready to be generated?
		do
			Result := target_object /= Void and then target_object.ready and event_name /= Void and then not event_name.is_empty
		end

	type: TYPE is
			-- Type
		local
			l_dotnet_type_name: STRING
		do
			check
				valid_event_type: valid_event_type (event_type)
			end

			l_dotnet_type_name := Resolver.feature_result_type (target_object.type, event_type + event_name, arguments)
			Result := Dotnet_types.dotnet_type (l_dotnet_type_name)

			check
				non_void_result: Result /= Void
			end
		end

feature -- Status Setting

	set_event_name (a_name: like event_name) is
			-- Set `event_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			event_name := a_name
		ensure
			event_name_set: event_name.is_equal (a_name)
		end		
		
	set_target_object (an_expression: like target_object) is
			-- Set `target_object' with `an_expression'.
		require
			non_void_expression: an_expression /= Void
		do
			target_object := an_expression
		ensure
			target_object_set: target_object = an_expression
		end	
	
	set_event_type (an_event_type: like event_type) is
			-- set `event_type' with `an_event_type'.
		require
			valid_an_event_type: valid_event_type (an_event_type)
		do
			event_type := an_event_type
		ensure
			envent_type_set: event_type = an_event_type
		end
		
invariant
	non_void_event_name: event_name /= Void
		
end -- class ECDP_EVENT_REFERENCE_EXPRESSION

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