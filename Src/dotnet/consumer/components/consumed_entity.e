indexing
	description: ".NET entity (member or constructor) as seen by Eiffel"
	date: "$Date$"
	revision: "$Revision$"

class
	CONSUMED_ENTITY

create
	make

feature {NONE} -- Initialization

	make (en: STRING; pub: BOOLEAN; a_type: CONSUMED_REFERENCED_TYPE) is
			-- Initialize `Current' with `en', `pub' written in `a_type'.
		require
			eiffel_name_not_void: en /= Void
			valid_eiffel_name: not en.is_empty
			a_type_not_void: a_type /= Void
		do
			eiffel_name := en
			set_is_public (pub)
			declared_type := a_type
		ensure
			eiffel_name_set: eiffel_name = en
			is_public_set: is_public = pub
			declared_type_set: declared_type = a_type
		end

feature -- Access

	eiffel_name: STRING
			-- Eiffel entity name
			
	dotnet_name: STRING is
			-- Dotnet name of entity
		do
		ensure
			dotnet_name_not_void: dotnet_name /= Void
		end

	declared_type: CONSUMED_REFERENCED_TYPE
			-- Type in which feature is written/declared.
		
	arguments: ARRAY [CONSUMED_ARGUMENT] is
			-- Arguments if any.
		do
		end
		
	return_type: CONSUMED_REFERENCED_TYPE is
			-- Return type if any.
		do
		end

	is_frozen: BOOLEAN is
			-- Is .NET definition frozen?
		do
		end

	is_public: BOOLEAN is
			-- Is .NET entity public?
		do
		end
		
	is_literal: BOOLEAN is
			-- Is .NET entity a static literal?
		do
		end
	
	is_init_only: BOOLEAN is
			-- Is .NET field a constant?
		do
		end
		
	is_artificially_added: BOOLEAN is
			-- Is Current artificially added?
		do
		end

	is_property_or_event: BOOLEAN is
			-- Is entity an event or property related feature?
		do
		end
		
	is_new_slot: BOOLEAN is
			-- Is entity marked with `newslot' flag in metadata?
		do
		end
		
	is_virtual: BOOLEAN is
			-- Is entity marked with `virtual' flag in metadata?
		do
		end
		
feature -- ConsumerWrapper functions

	is_method: BOOLEAN is
			-- Is entity a .Net method?
		do
			Result := not is_property and then not is_field and then not is_event and then not is_constant
		end
		
	is_field: BOOLEAN is
			-- Is entity a .Net field?
		do
		end

	is_property: BOOLEAN is
			-- Is entity a .Net property?
		do
		end
		
	is_event: BOOLEAN is
			-- Is entity a .Net event?
		do
		end
		
	is_constant: BOOLEAN is
			-- Is entity a .Net method?
		do
			Result := is_literal or is_init_only
		end
	
	eiffelized_consumed_entities: ARRAYED_LIST [CONSUMED_ENTITY] is
			-- List of Eiffel mapped Consumed Entities relative to `Current'.
			-- For CONSUMED_PROPERTY this would be `setter' and `getter'
			-- FIXME IEK Temporary solution until better design is implemented.
		do
			create Result.make (0)
			Result.extend (Current)
		end
		
feature -- Status report

	has_arguments: BOOLEAN is
			-- Does current entity have argments?
		do
		end

	has_return_value: BOOLEAN is
			-- Does current entity returns a value?
		do
		end
		
	is_static: BOOLEAN is
			-- Is current entity static?
		do
		end
	
	is_attribute: BOOLEAN is
			-- Is current entity an attribute?
		do
		end

	is_deferred: BOOLEAN is
			-- Is current entity abstract?
		do
		end

	is_access_type: BOOLEAN is
			-- Is current entity an 'Access' type?
		do
			if 
				is_field or 
				(eiffel_name.substring (1, 4).is_equal ("get_") and arguments.is_empty)
			then
				Result := True
			end
		end	
		
	is_status_setting_type: BOOLEAN is
			-- Is current entity a 'Status Setting' type?
		do
			if
				eiffel_name.substring (1, 4).is_equal ("set_") and arguments.count = 1
			then
				Result := True
			end
		end
		
	is_query_type: BOOLEAN is
			-- Is current entity a 'Status Setting' type?
		do
			if has_return_value and then not is_access_type then
				Result := True
			end
		end
		
	is_command_type: BOOLEAN is
			-- Is current entity a 'Status Setting' type?
		do
			Result := not has_return_value and then not is_status_setting_type
		end
		
	is_event_type: BOOLEAN is
			-- Is current entity a 'Status Setting' type?
		do
			Result := is_event
		end
		
	is_hidden_type: BOOLEAN is
			-- Is current entity a 'Status Setting' type?
		do
			Result := not is_public
		end

feature -- Settings

	set_is_public (pub: like is_public) is
			-- Set `is_public' with `pub'.
		do
		ensure
			is_public_set: is_public = pub
		end
		
invariant
	non_void_eiffel_name: eiffel_name /= Void
	valid_eiffel_name: not eiffel_name.is_empty
	declared_type_not_void: declared_type /= Void

end -- class CONSUMED_ENTITY
