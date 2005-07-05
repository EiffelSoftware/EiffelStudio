indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGED_OBJECT_MANAGER

inherit
	SHARED_APPLICATION_EXECUTION

create {SHARED_DEBUGGED_OBJECT_MANAGER}
	make

feature {NONE}-- Creation

	make is
		do
			is_dotnet := Application.is_dotnet
		end

	is_dotnet: BOOLEAN

feature -- Reset

	reset is
		do
			last_debugged_object := Void
		end

feature -- Query

	class_type_at_address (addr: STRING): CLASS_TYPE is
		require
			address_not_void: addr /= Void
		local
			dobj: DEBUGGED_OBJECT
		do
			dobj := debugged_object (addr, 0, 0)
			Result := dobj.class_type
		end

	class_c_at_address (addr: STRING): CLASS_C is
		require
			address_not_void: addr /= Void
		local
			dobj: DEBUGGED_OBJECT
		do
			dobj := debugged_object (addr, 0, 0)
			Result := dobj.dtype
		end

	attributes_at_address (addr: STRING; sp_lower, sp_upper: INTEGER): DS_LIST [ABSTRACT_DEBUG_VALUE] is
		require
			address_not_void: addr /= Void
		local
			dobj: DEBUGGED_OBJECT
		do
			dobj := debugged_object (addr, sp_lower, sp_upper)
			Result := dobj.attributes
		end

	sorted_attributes_at_address (addr: STRING; sp_lower, sp_upper: INTEGER): DS_LIST [ABSTRACT_DEBUG_VALUE] is
		require
			address_not_void: addr /= Void
		local
			dobj: DEBUGGED_OBJECT
		do
			dobj := debugged_object (addr, sp_lower, sp_upper)
			Result := dobj.sorted_attributes
		end

	object_at_address_is_special (addr: STRING): BOOLEAN is
		require
			address_not_void: addr /= Void
		local
			dobj: DEBUGGED_OBJECT
		do
			dobj := debugged_object (addr, 0, 0)
			Result := dobj.is_special
		end

	object_at_address_has_attributes (addr: STRING): BOOLEAN is
		require
			address_not_void: addr /= Void
		local
			dobj: DEBUGGED_OBJECT
			lst: DS_LIST [ABSTRACT_DEBUG_VALUE]
		do
			dobj := debugged_object (addr, 0, 0)
			lst := dobj.sorted_attributes
			Result := lst /= Void and then not lst.is_empty
		end

	special_object_capacity_at_address (addr: STRING): INTEGER is
		require
			address_not_void: addr /= Void
		local
			dobj: DEBUGGED_OBJECT
		do
			dobj := debugged_object (addr, 0, 0)
			Result := dobj.capacity
		end

feature -- Last debugged object

	last_debugged_object: DEBUGGED_OBJECT

	last_sp_lower, last_sp_upper: INTEGER

feature -- debugged object creation

	classic_debugged_object_with_class (addr: STRING; a_compiled_class: CLASS_C): DEBUGGED_OBJECT_CLASSIC is
		require
			Application.is_classic
		do
			create Result.make_with_class (addr, a_compiled_class)
		end

	fakedebugged_object (addr: STRING; sp_lower, sp_upper: INTEGER): DEBUGGED_OBJECT is
		require
			non_void_addr: addr /= Void
			valid_addr: application.is_valid_object_address (addr)
			valid_bounds: sp_lower >= 0 and (sp_upper >= sp_lower or else sp_upper = -1)
		do
			if is_dotnet then
				create {DEBUGGED_OBJECT_DOTNET} Result.make (addr, sp_lower, sp_upper)
			else
				create {DEBUGGED_OBJECT_CLASSIC} Result.make (addr, sp_lower, sp_upper)
			end
			last_debugged_object := Result
			last_sp_lower := sp_lower
			last_sp_upper := sp_upper		
		end
		
	caching_enabled: BOOLEAN is True

	debugged_object (addr: STRING; sp_lower, sp_upper: INTEGER): DEBUGGED_OBJECT is
		require
			non_void_addr: addr /= Void
			valid_addr: application.is_valid_object_address (addr)
			valid_bounds: sp_lower >= 0 and (sp_upper >= sp_lower or else sp_upper = -1)
		do
			debug ("debugger_caching")
				print (generator + " : debugged_object for " + addr + " [" + sp_lower.out + ":" + sp_upper.out + "]%N")
			end
			if
				caching_enabled and then 
				last_debugged_object /= Void 
				and then last_debugged_object.object_address.is_equal (addr)
			then
				debug ("debugger_caching")
					print (generator + " : reused last debugged_object %N")
				end

				Result := last_debugged_object
				if last_sp_lower < sp_lower or last_sp_upper > sp_upper then
					debug ("debugger_caching")
						print (generator + " : but with slices ")
						print ("[" + sp_lower.out + ", " + sp_upper.out + "]" )
						print (" instead of ")
						print ("[" + last_sp_lower.out + ", " + last_sp_upper.out + "]" )
						print ("%N")
					end
					Result.refresh (sp_lower, sp_upper)
					debug ("debugger_caching")
						print (generator + " => capacity:" + Result.capacity.out + ", att_count:" + Result.attributes.count.out + " %N")
					end
				elseif last_sp_lower /= sp_lower or last_sp_upper /= sp_upper then
					debug ("debugger_caching")
						print (generator + " : slices already included into reused debugged object %N")
						print (generator + " : [" 
								+ sp_lower.out + ":" + sp_upper.out 
								+ "] included into ["
								+ last_sp_lower.out + ":" + last_sp_upper.out
								+"] %N")
					end
				end
			else
				debug ("debugger_caching")
					print (generator + " : new debugged_object %N")
				end
				if is_dotnet then
					create {DEBUGGED_OBJECT_DOTNET} Result.make (addr, sp_lower, sp_upper)
				else
					create {DEBUGGED_OBJECT_CLASSIC} Result.make (addr, sp_lower, sp_upper)
				end
			end
			last_debugged_object := Result
			last_sp_lower := sp_lower
			last_sp_upper := sp_upper
		ensure
			Result /= Void
		end

end
