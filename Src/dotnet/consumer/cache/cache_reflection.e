indexing
	description: "Provide reflection mechanisms to inspect EAC"

class
	CACHE_REFLECTION

inherit
	CACHE_READER
	
feature -- Access

	feature_name (t: TYPE; dotnet_name: STRING; args: NATIVE_ARRAY [TYPE]): STRING is
			-- Eiffel name of .NET function `dotnet_name' from type `t' with arguments `args'
		require
			non_void_type: t /= Void
			non_void_name: dotnet_name /= Void
			valid_name: not dotnet_name.is_empty
			valid_args: args /= Void implies args.get_length > 0
		local
			ct: CONSUMED_TYPE
			crt: CONSUMED_REFERENCED_TYPE
			fields: ARRAY [CONSUMED_FIELD] 
			methods: ARRAY [CONSUMED_METHOD]
			functions: ARRAY [CONSUMED_FUNCTION]
			constructors: ARRAY [CONSUMED_CONSTRUCTOR]
			found: BOOLEAN
			i, j, count: INTEGER
			ca: CONSUMED_ASSEMBLY
			cargs: ARRAY [CONSUMED_ARGUMENT]
		do
			i := t.get_hash_code
			local_cache.search (i)
			if local_cache.found then
				ct := local_cache.found_item
			else
				ct := consumed_type (t)
				if ct /= Void then
					if history.count = Max_cache_items then
						local_cache.remove (history.item)
						history.remove
					end
					history.put (i)
					local_cache.put (ct, i)
				end
			end
			if ct /= Void then
				create ca.make (t.get_assembly)
				if dotnet_name.is_equal (Constructor_name) then
					constructors := ct.constructors
					from
						i := 1
						count := constructors.count
					until
						i > count or found
					loop
						cargs := constructors.item (i).arguments
						if cargs.count = args.get_length then
							from
								j := 1
								found := True
							until
								j > cargs.count or not found
							loop
								crt := cargs.item (j).type
								found := crt.name.to_cil.equals (args.item (j - 1).get_full_name) and then
									crt.assembly.is_equal (create {CONSUMED_ASSEMBLY}.make (args.item (j - 1).get_assembly))
								j := j + 1
							end
						end
						if found then
							Result := constructors.item (i).eiffel_name
						end
						i := i + 1
					end
				elseif args /= Void then
					functions := ct.functions
					from
						i := 1
					until
						i > functions.count or found
					loop
						if functions.item (i).dotnet_name.is_equal (dotnet_name) then
							cargs := functions.item (i).arguments
							if cargs.count = args.count then
								from
									j := 1
									found := True
								until
									j > cargs.count or not found
								loop
									crt := cargs.item (j).type
									found := crt.name.to_cil.equals (args.item (j - 1).get_full_name) and then
										crt.assembly.is_equal (create {CONSUMED_ASSEMBLY}.make (args.item (j - 1).get_assembly))
									j := j + 1
								end
							end
						end
						if found then
							Result := functions.item (i).eiffel_name
						end
						i := i + 1
					end
					if not found then
						methods := ct.methods
						from
							i := 1
						until
							i > methods.count or found
						loop
							if methods.item (i).dotnet_name.is_equal (dotnet_name) then
								cargs := methods.item (i).arguments
								if cargs.count = args.count then
									from
										j := 1
										found := True
									until
										j > cargs.count or not found
									loop
										crt := cargs.item (j).type
										found := crt.name.to_cil.equals (args.item (j - 1).get_full_name) and then
											crt.assembly.is_equal (create {CONSUMED_ASSEMBLY}.make (args.item (j - 1).get_assembly))
										j := j + 1
									end
								end
							end
						end
						if found then
							Result := methods.item (i).eiffel_name
						end
						i := i + 1
					end
				else
					-- No arguments, search fields first
					fields := ct.fields
					from
						i := 1
					until
						i > fields.count or found
					loop
						found := fields.item (i).dotnet_name.is_equal (dotnet_name)
						if found then
							Result := fields.item (i).eiffel_name
						end
						i := i + 1
					end
					if not found then
						functions := ct.functions
						from
							i := 1
						until
							i > functions.count or found
						loop
							found := functions.item (i).dotnet_name.is_equal (dotnet_name)
							if found then
								Result := functions.item (i).eiffel_name
							end
							i := i + 1
						end
					end
					if not found then
						methods := ct.methods
						from
							i := 1
						until
							i > methods.count or found
						loop
							found := methods.item (i).dotnet_name.is_equal (dotnet_name)
							if found then
								Result := methods.item (i).eiffel_name
							end
							i := i + 1
						end
					end
				end
			end
		end

feature {NONE} -- Implementation

	Constructor_name: STRING is ".ctor"

	local_cache: HASH_TABLE [CONSUMED_TYPE, INTEGER] is
			-- Cache for loaded types
		once
			create Result.make (Max_cache_items)
		end
	
	history: ARRAYED_QUEUE [INTEGER] is
			-- Cache key history
		once
			create Result.make (Max_cache_items)
		end

	Max_cache_items: INTEGER is 20
			-- Maximum number of types stored in local cache

end -- class CACHE_REFLECTION
