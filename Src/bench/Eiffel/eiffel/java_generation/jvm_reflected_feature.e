indexing
	description: "objects that represent reflected features. a reflected %
                %feature is only a placeholder for a inherited %
                %feature that has not changed. it does not contain a lot of %
                %information. The most important feature of it is %
                %that it is able to point you to it's 'precursor'"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
class
	JVM_REFLECTED_FEATURE
			
inherit
	JVM_FEATURE

	create
	make
			
feature {ANY} -- Initialisation
			
	make is
		do
		end
			
feature {ANY} -- Access
			
	written_type_id: INTEGER
			-- `type_id' of class this feature is written in
			-- use `written_type_id' and `routine_id' to locate the
			-- the written counterpart this feature referes to.
	
	written_class: JVM_CLASS is
			-- class object with type id `written_type_id'
		do
			Result := repository.item (written_type_id)
		ensure
			result_not_void: Result /= Void
		end
			
	written_feature: JVM_WRITTEN_FEATURE is
			-- retrieves the written feature
		do
			Result ?= written_class.feature_by_routine_id (routine_id)
		end

feature {ANY} -- Access
			
	set_written_type_id (i: INTEGER) is
			-- set the `writen_type_id'
		do
			written_type_id := i
		ensure
			written_type_id_set: written_type_id = i
		end
end



