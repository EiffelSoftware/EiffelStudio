indexing
	description: "represents a JVM feature (internal or external, inherited or not). this is a common heir."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	JVM_FEATURE
inherit
	SHARED_JVM_CLASS_REPOSITORY

feature {ANY} -- Access
			
	feature_id: INTEGER
			-- id for feature in current class
			-- (if this is only a reflected feature this will not be the
			-- class where it is written, but the class where it is reflected)
			
	routine_id: INTEGER
			-- id for feature in inheritance tree
			-- use this id to look up precursors or redefinitions of
			-- this feature in descendants or heirs (feature will have
			-- same `routine_id' their)
			-- `-1' means the class does not have a routine id
			
	type_id: INTEGER
			-- is for class this feature is in
			-- (if this is only a reflected feature this will not be the
			-- class where it is written, but the class where it is reflected)
			-- `-1' means the class does not have a type id
			
	class_: JVM_CLASS is
			-- the class corresponding to `type_id'
		require
			valid_type_id: type_id > 0
		do
			Result := repository.item (type_id)
		ensure
			class_not_void: class_ /= Void
		end
			
	written_feature: JVM_WRITTEN_FEATURE is
			-- Corresponding written feature
			-- May be `Current' in case this is not a reflected feature
		deferred
		ensure
			result_not_void: Result /= Void
		end
			
feature {ANY} --
			
	set_feature_id (i: INTEGER) is
			-- set the feature id
		do
			feature_id := i
		ensure
			feature_id_set: feature_id = i
		end
			
	set_routine_id (i: INTEGER) is
			-- set the routine id
		do
			routine_id := i
		ensure
			routine_id_set: routine_id = i
		end
			
	set_type_id (i: INTEGER) is
			-- set the type_id
		do
			type_id := i
		ensure
			type_id_set: type_id = i
		end
end



