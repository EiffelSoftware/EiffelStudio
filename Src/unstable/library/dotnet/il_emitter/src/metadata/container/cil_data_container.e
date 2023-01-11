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
	CIL_DATA_CONTAINER

inherit

	REFACTORING_HELPER

create
	make

feature {NONE} --Initialization

	make (a_name: STRING_32; a_flags: CIL_QUALIFIERS)
		do
			name := a_name
			flags := a_flags
			instantiated := False
			pe_index := 0
			create {ARRAYED_LIST [CIL_DATA_CONTAINER]} children.make (0)
			assembly_ref := False
			create {ARRAYED_LIST [CIL_CODE_CONTAINER]} methods.make (0)
			create sorted_children.make (0)
			create {ARRAYED_LIST [CIL_FIELD]} fields.make (0)
		end

feature -- Access

	children: LIST [CIL_DATA_CONTAINER]

	methods: LIST [CIL_CODE_CONTAINER]
			-- Current list of methods.

	sorted_children: STRING_TABLE [LIST [CIL_DATA_CONTAINER]]

	fields: LIST [CIL_FIELD]
			-- Current list of fields.

	parent: detachable CIL_DATA_CONTAINER
			-- The immediate parent.

	flags: CIL_QUALIFIERS
			-- the qualifiers.

	instantiated: BOOLEAN
			-- use to tell if the class has been instantiated, for example it might be used after a forward reference is resolved.

	pe_index: NATURAL_64
			-- metatable index in the PE file for this data container.

	assembly_ref: BOOLEAN

	name: STRING_32
			-- The name.

feature -- Access

	parent_namespace (a_lib: FILE_STREAM): NATURAL_64
			-- The inner namespace parent.
		local
			l_current: CIL_DATA_CONTAINER
			l_res: BOOLEAN
		do
			l_current := Current.parent
			from until l_current = Void or attached {CIL_NAMESPACE} l_current
			loop
				l_current := l_current.parent
			end
			if attached {CIL_NAMESPACE} l_current as l_current_namespace then
				if l_current.in_assembly_ref then
					l_res := l_current_namespace.pe_dump (a_lib)
				end
				Result := l_current.pe_index
			end
				-- by default Result is 0
		end

	parent_class (a_lib: FILE_STREAM): NATURAL_64
			-- The closest parent class.
		local
			l_current: CIL_DATA_CONTAINER
			l_res: BOOLEAN
		do
			l_current := parent
			if attached {CIL_CLASS} l_current as l_current_class then
				if l_current.in_assembly_ref then
					l_res := l_current_class.pe_dump (a_lib)
				end
				Result := l_current.pe_index
			end
				-- by default Result is 0
		end

	parent_assembly (a_lib: FILE_STREAM): NATURAL_64
			-- The parent assembly.
		local
			l_current: CIL_DATA_CONTAINER
		do
				-- the parent assembly is always at top of the datacontainer tree
			l_current := parent
			from until l_current /= Void and then l_current.parent = Void and then attached {CIL_ASSEMBLY_DEF} l_current
			loop
				l_current := if attached l_current then l_current.parent else Void end
			end
			if l_current /= Void then -- attached {CIL_ASSEMBLY_DEF} l_current as l_current_assembly
					-- if l_current.in_assembly_ref then
					-- TODO original leads to infinite loop: static_cast<AssemblyDef*>(current)->PEDump(peLib);
					-- l_current_assembly.pe_dum (a_lib)
					-- end
				Result := l_current.pe_index
			end

		end

feature -- Access Enumerations

		-- all classes have to extend from SOMETHING...
		-- this is enumerations for the ones we can create by default
		-- TODO extract into a once class.

	base_type_object: INTEGER = 1
			-- reference to 'System::Object'

	base_type_value: INTEGER = 2
			-- reference to 'System::Value'

	base_type_enum: INTEGER = 4
			-- reference to 'System::Enum'

	base_index_system: INTEGER = 8
			-- reference to 'System' namespace

feature -- Status Report

	in_assembly_ref: BOOLEAN
		do
			Result := if attached parent as l_parent then l_parent.in_assembly_ref else False end
		end

	get_assembly: detachable CIL_ASSEMBLY_DEF
		do
			Result := if attached parent as l_parent then l_parent.get_assembly else Void end
		end

feature --Element Change

	add (a_item: ANY)
			-- Add an `a_item` to a container
			-- This could be a
			--	data container
			--	code container
			-- 	field container
		do
			if attached {CIL_DATA_CONTAINER} a_item as l_data then
				add_data_container (l_data)
			elseif attached {CIL_CODE_CONTAINER} a_item as l_code then
				add_code_container (l_code)
			elseif attached {CIL_FIELD} a_item as l_field then
				add_field_container (l_field)
			end
		end

	add_data_container (a_item: CIL_DATA_CONTAINER)
			-- Add another data container
			-- This could be an assemblydef, namespace, class, or enumeration.
		do
			a_item.set_parent (Current)
			children.force (a_item)
			set_sorted_children (a_item.name, a_item)
		end

	add_code_container (item: CIL_CODE_CONTAINER)
			-- Add a code container
			-- This is always a Method definition
		do
			item.set_container (Current)
			methods.force (item)
		end

	add_field_container (item: CIL_FIELD)
			-- Add a field
		do
			item.set_container (Current)
			fields.force (item)
		end

	set_parent (a_item: CIL_DATA_CONTAINER)
			-- Set `parent` with `a_item`
			--|The immediate parent
		do
			parent := a_item
		ensure
			parent_set: parent = a_item
		end

	set_sorted_children (a_name: STRING_32; a_item: CIL_DATA_CONTAINER)
		local
			l_list: ARRAYED_LIST [CIL_DATA_CONTAINER]
		do
			if attached {ARRAYED_LIST [CIL_DATA_CONTAINER]} sorted_children.at (a_name) as l_adj then
				l_adj.force (a_item)
			else
				create l_list.make (1)
				l_list.force (a_item)
				sorted_children.force (l_list, a_name)
			end
		ensure
				-- To be added.
		end

	number (n: NATURAL): NATURAL
		do
			if attached {CIL_NAMESPACE} Current then
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

	set_peindex (a_index: NATURAL_64)
			-- Set `pe_index` with `a_index`.
		do
			pe_index := a_index
		ensure
			pe_index_set: pe_index = a_index
		end

	wipe_out, clear
			-- Remove all the items of
			-- children
			-- methods
			-- sorted_children
			-- fields
		do
			fixme ("Refactor rename and only use wipe_out")
			children.wipe_out
			methods.wipe_out
			sorted_children.wipe_out
			fields.wipe_out
		ensure
			children.is_empty
			methods.is_empty
			sorted_children.is_empty
			fields.is_empty
		end

feature -- Traverse

	traverse (a_callback: CIL_CALLBACK): BOOLEAN
			-- Traverse the declaration tree.
		local
			l_exit: BOOLEAN
			l_continue: BOOLEAN
		do
			across children as child until l_exit loop
				if attached {CIL_CLASS} child as l_class then
					if not a_callback.enter_class (l_class) then
						l_continue := True
					end
					if not l_continue and then not child.traverse (a_callback) then
						Result := true
						l_exit := True
					end
					if not l_continue and then not l_exit and then
						not a_callback.exit_class (l_class) then
						Result := False
						l_exit := True
					end
				elseif attached {CIL_ENUM} child as l_enum then
					if not a_callback.enter_enum (l_enum) then
						l_continue := True
					end
					if not l_continue and then not child.traverse (a_callback) then
						Result := true
						l_exit := True
					end
					if not l_continue and then not l_exit and then
						not a_callback.exit_enum (l_enum) then
						Result := False
						l_exit := True
					end
				elseif attached {CIL_NAMESPACE} child as l_namespace then
					if not a_callback.enter_namespace (l_namespace) then
						l_continue := True
					end
					if not l_continue and then not child.traverse (a_callback) then
						Result := true
						l_exit := True
					end
					if not l_continue and then not l_exit and then
						not a_callback.exit_namespace (l_namespace) then
						Result := False
						l_exit := True
					end
				end
				l_continue := False
			end
			if not l_exit then
				across fields as field until l_exit loop
					if not a_callback.enter_field (field) then
						Result := False
						l_exit := True
					end
				end
			end
			if not l_exit then
				across methods as method until l_exit loop
					if attached {CIL_METHOD} method as l_method and then not a_callback.enter_method (l_method) then
						Result := False
						l_exit := True
					end
				end
			end
			if not l_exit then
				Result := True
			end
		end

feature -- Status Report

	find_container_string (a_name: STRING_32; a_Generics: detachable LIST [CIL_TYPE]): detachable CIL_DATA_CONTAINER
			-- Find a subcontainer.
			--| Correspond to
			--| DataContainer *FindContainer(const std::string& name, std::deque<Type*>* generics = nullptr);
		local
			exit: BOOLEAN
		do
			if a_generics = Void then
				if attached {LIST [CIL_DATA_CONTAINER]} sorted_children.at (a_name) as l_items and then
					l_items.count > 0
				then
					Result := l_items.first
				end
			else
				across sorted_children as ic until exit
				loop
					if attached {CIL_CLASS} @ ic as l_class then
						if l_class.matches_generic (a_generics) then
							Result := l_class
							exit := True
						end
					end
				end
			end
		end

	find_container_collection (a_split: LIST [STRING_32]; a_generics: detachable LIST [CIL_TYPE]; a_method: BOOLEAN): TUPLE [index: INTEGER; dc: detachable CIL_DATA_CONTAINER]
			-- Find a sub container.
			--| Correspond to  ///** Find a sub- container
			--|   DataContainer *FindContainer(std::vector<std::string>& split, size_t &n,
			--|                         std::deque<Type*>* generics = nullptr, bool method = false);
		local
			n: INTEGER
			count: INTEGER
			rv, dc_current: CIL_DATA_CONTAINER
			i: INTEGER
			exit: BOOLEAN
		do
			n := 0
			count := 1
			if a_method then
				count := count + 1
			end
			dc_current := Current
			rv := dc_current
			from
				i := 1
			until
				exit or else i > a_split.count
			loop
					-- TODO check the index.
				if attached dc_current then
					dc_current := dc_current.find_container_string (a_split [i], if i = a_split.count - count then a_generics else Void end)
				end
				if dc_current = Void then
					exit := True
				else
					rv := dc_current
					i := i + 1
					n := n + 1
				end
			end
			Result := [n, rv]
		end

feature -- Operations

	base_types (a_type: CELL [INTEGER])
		do
			across methods as method loop
				method.base_types (a_type)
			end
			across children as child loop
				child.base_types (a_type)
			end
			if attached {CIL_ENUM} Current then
				a_type.put (a_type.item | base_type_enum)
			else
				if not attached {CIL_NAMESPACE} Current then
					if flags.flags & {CIL_QUALIFIERS_ENUM}.value /= 0 then
						a_type.put (a_type.item | base_type_value)
					else
						a_type.put (a_type.item | base_type_object)
					end
				end
			end
		end

	compile (a_stream: FILE_STREAM)
		do
			across methods as method loop
				method.compile (a_stream)
			end
			across children as child loop
				child.compile(a_stream)
			end
		end

	render (a_stream: FILE_STREAM)
			-- sometimes we want to traverse upwards in the tree
		do
				-- empty implementation
		end

feature -- Output

	pe_dump (a_stream: FILE_STREAM): BOOLEAN
		do
			across fields as field loop
				Result := field.pe_dump (a_stream)
			end
			across methods as method loop
				Result := method.pe_dump (a_stream)
			end
			across children as child loop
				Result := child.pe_dump (a_stream)
			end
		end

	il_src_dump (a_file: FILE_STREAM): BOOLEAN
		do
			across fields as field loop
				Result := field.il_src_dump (a_file)
			end
			across methods as method loop
				Result := method.il_src_dump (a_file)
			end
			across children as l_child loop
				Result := l_child.il_src_dump (a_file)
			end
		end

end
