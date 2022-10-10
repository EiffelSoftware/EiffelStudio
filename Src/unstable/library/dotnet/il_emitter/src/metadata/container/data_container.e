note
	description: "[
						Base class that contains other data_containers or code_containers
			    		that means it can contain namespaces, classes, methods, or fields
			     		The main assemblyref which holds everything is one of these,
			     		which means it acts as the 'unnamed' namespace.
			     		when this class is overridden as something other than a namespace,
			     		it cannot contain namespaces
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	DATA_CONTAINER

create
	make

feature {NONE} --Initialization

	make (a_name: STRING_32; a_flags: QUALIFIERS)
		do
			name := a_name
			flags := a_flags
			instantiated := False
			pe_index := 0
			create {ARRAYED_LIST [DATA_CONTAINER]} children.make (0)
			assembly_ref := False
			create {ARRAYED_LIST [CODE_CONTAINER]} methods.make (0)
			create sorted_children.make(0)
			create {ARRAYED_LIST [FIELD]} fields.make (0)
		end

feature -- Access

	children: LIST [DATA_CONTAINER]

	methods: LIST [CODE_CONTAINER]

	sorted_children: STRING_TABLE [LIST[DATA_CONTAINER]]

	fields: LIST [FIELD]

	parent: detachable DATA_CONTAINER

	flags: QUALIFIERS
		-- Check the class QUALIFIERS

	instantiated: BOOLEAN
		-- use to tell if the class has been instantiated, for example it might be used after a forward reference is resolved.

	pe_index: NATURAL
		-- generic index into the table or stream.

	assembly_ref: BOOLEAN

feature -- Access

	name: STRING_32


feature -- Access Enumerations

		-- all classes have to extend from SOMETHING...
		-- this is enumerations for the ones we can create by default

	base_type_object: INTEGER = 1
			-- reference to 'System::Object'

	base_type_value: INTEGER = 2
			-- reference to 'System::Value'

	base_type_enum: INTEGER = 4
			-- reference to 'System::Enum'

	base_index_system: INTEGER = 8
			-- reference to 'System' namespace


feature --Element Change

	add (a_item: ANY)
			-- Add an `a_item` to a container
       		-- This could be a
       		--	data container
       		--	code container
       		-- 	field container
		do
			if attached {DATA_CONTAINER} a_item as l_data  then
				add_data_container (l_data)
			elseif attached {CODE_CONTAINER} a_item as l_code then
				add_code_container (l_code)
			elseif attached {FIELD} a_item as l_field then
				add_field_container (l_field)
			end
		end

	add_data_container (a_item: DATA_CONTAINER)
			-- Add another data container
			-- This could be an assemblydef, namespace, class, or enumeration.
		do
			a_item.set_parent (Current)
			children.force (a_item)
			set_sorted_children (a_item.name, a_item)
		end

	add_code_container (item: CODE_CONTAINER)
			-- Add a code container
			-- This is always a Method definition
		do
			item.set_container (Current)
			methods.force (item)
		end


	add_field_container (item: FIELD)
			-- Add a field
		do
			item.set_container (Current)
			fields.force (item)
		end


	set_parent (a_item: DATA_CONTAINER)
		do
			parent := a_item
		end

	set_sorted_children (a_name: STRING_32; a_item: DATA_CONTAINER)
		local
			l_list: ARRAYED_LIST[DATA_CONTAINER]
		do
			if attached {ARRAYED_LIST[DATA_CONTAINER]} sorted_children.at (a_name) as l_adj then
				l_adj.force (a_item)
			else
				create l_list.make (1)
				l_list.force (a_item)
				sorted_children.force (l_list, a_name)
			end
		ensure
			-- To be added.
		end

	number (n: NATURAL) : NATURAL
		do
			if attached {NAMESPACE} Current  then
				Result := n + 1
				pe_index := Result
			end
			across children as child loop
				Result := child.number (Result)
			end
		end

	set_instantiated
			-- Set instantiated to true.
		do
			instantiated := True
		ensure
			is_instantiated: instantiated = True
		end

feature -- Output

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			across fields as field loop
				Result := field.il_src_dump (a_file)
			end
			across methods as method  loop
				Result := method.il_src_dump(a_file)
			end
			across children as l_child loop
				Result := l_child.il_src_dump (a_file)
			end
		end

	adorn_generics (names: BOOLEAN): STRING_32
		do
			-- TODO to be implemented.
			create Result.make_empty
		end
end
