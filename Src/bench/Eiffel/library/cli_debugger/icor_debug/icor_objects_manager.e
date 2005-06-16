indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_OBJECTS_MANAGER

inherit
	ICOR_EXPORTER
	
create {SHARED_ICOR_OBJECTS_MANAGER}
	make

feature {NONE} -- Initialization

	make is
		do
			create modules.make (50)
			create classes.make (100)
			create functions.make (500)
		end
		
feature -- Cleaning

	clean is
			-- 
		do
			clean_modules
			clean_classes
			clean_functions
		end
	
	clean_modules is
		local
			l_module: ICOR_DEBUG_MODULE
		do
			from
				modules.start
			until
				modules.after
			loop
				l_module := modules.item_for_iteration
				l_module.clean_on_dispose
				modules.forth
			end
			modules.wipe_out
		end
		
	clean_classes is
		local
			l_class: ICOR_DEBUG_CLASS
		do
			from
				classes.start
			until
				classes.after
			loop
				l_class := classes.item_for_iteration
				l_class.clean_on_dispose
				classes.forth
			end
			classes.wipe_out
		end		

	clean_functions is
		local
			l_function: ICOR_DEBUG_FUNCTION
		do
			from
				functions.start
			until
				functions.after
			loop
				l_function := functions.item_for_iteration
				l_function.clean_on_dispose
				functions.forth
			end
			functions.wipe_out
		end		

feature {ICOR_EXPORTER} -- Access
	
	icd_module (p: POINTER): ICOR_DEBUG_MODULE is
		require
			pointer_valid: p /= default_pointer
		do
			if modules.has (p) then
				Result := modules.item (p)
			else
				create Result.make_by_pointer (p)
				Result.add_ref
				modules.force (Result, p)
			end
			if Result.item = Default_pointer then
				Result.update_item (p)
			end
		ensure
			result_not_void: Result /= Void
			result_pointer_set: Result.item = p
			result_indexed: modules.has (Result.item)
		end
		
	icd_class (p: POINTER): ICOR_DEBUG_CLASS is
		require
			pointer_valid: p /= default_pointer
		do
			if classes.has (p) then
				Result := classes.item (p)
			else
				create Result.make_by_pointer (p)
				Result.add_ref
				classes.force (Result, p)
			end
			if Result.item = Default_pointer then
				Result.update_item (p)
			end			
		ensure
			result_not_void: Result /= Void
			result_pointer_set: Result.item = p
			result_indexed: classes.has (Result.item)
		end
		
	icd_function (p: POINTER): ICOR_DEBUG_FUNCTION is
		require
			pointer_valid: p /= default_pointer
		do
			if functions.has (p) then
				Result := functions.item (p)
			else
				create Result.make_by_pointer (p)
				Result.add_ref
				functions.force (Result, p)
			end
			if Result.item = Default_pointer then
				Result.update_item (p)
			end			
		ensure
			result_not_void: Result /= Void
			result_pointer_set: Result.item = p
			result_indexed: functions.has (Result.item)
		end		

feature {NONE} -- Implementation

	modules: HASH_TABLE [ICOR_DEBUG_MODULE, POINTER]

	classes: HASH_TABLE [ICOR_DEBUG_CLASS, POINTER]

	functions: HASH_TABLE [ICOR_DEBUG_FUNCTION, POINTER]

end -- class ICOR_OBJECTS_MANAGER
