indexing
	description:
		"Abstract description of an Eiffel function pointer. %
		%Version for Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	ADDRESS_AS

inherit
	EXPR_AS
		redefine
			type_check, byte_node
		end

	SHARED_TYPES
		export
			{NONE} all
		end
		
	SHARED_INSTANTIATOR
		export
			{NONE} all
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like feature_name) is
			-- Create a new ADDRESS AST node.
		require
			f_not_void: f /= Void
		do
			feature_name := f
		ensure
			feature_name_set: feature_name = f
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_address_as (Current)
		end

feature -- Attribute

	feature_name: FEATURE_NAME
			-- Feature name to address

feature -- Location

	start_location: LOCATION_AS is
			-- Starting point for current construct.
		do
			Result := feature_name.start_location
		end
		
	end_location: LOCATION_AS is
			-- Ending point for current construct.
		do
			Result := feature_name.end_location
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (feature_name, other.feature_name)
		end

feature -- Type check, byte code and dead code removal

	type_check is
			-- Type check an address access.
		local
			internal_name: ID_AS
			access_b: ACCESS_B
			access_address: ACCESS_ADDRESS_AS
			id_type: TYPE_A
			l_typed_ptr: TYPED_POINTER_A
			not_supported: NOT_SUPPORTED
		do
				-- Initialization of the type stack
			context.begin_expression

			internal_name := feature_name.internal_name

			create access_address.make (internal_name)
			id_type := access_address.access_type

			access_b := context.access_line.access

			if not access_b.is_feature then
				create l_typed_ptr.make_typed (id_type)
				id_type := l_typed_ptr
				Instantiator.dispatch (l_typed_ptr, Context.current_class)
				Context.typed_pointer_line.insert (id_type)
			else
				Instantiator.dispatch (pointer_type, Context.current_class)
			end

			if access_b.is_external then
				create not_supported
				context.init_error (not_supported)
				not_supported.set_message ("The $ operator is not supported on external features")
				not_supported.set_location (feature_name.start_location)
				Error_handler.insert_error (not_supported)
				Error_handler.raise_error
			end

				-- Update the type stack
			context.replace (id_type)
		end

	byte_node: EXPR_B is
			-- Associated byte code.
		local
			access_line: ACCESS_LINE
			access: ACCESS_B
			address: ADDRESS_B
			hector: HECTOR_B
			a_feature: FEATURE_I
		do
			access_line := context.access_line
			access := access_line.access
			access_line.forth

			if access.is_feature then
				a_feature := context.feature_table.item(feature_name.internal_name)
				create address.make (context.current_class.class_id, a_feature)
				Result := address
			else
				create hector.make_with_type (access, context.typed_pointer_line.item.type_i)
				Context.typed_pointer_line.forth
				Result := hector
			end
		end

end -- class ADDRESS_AS
