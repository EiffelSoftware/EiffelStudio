indexing

    product: "EiffelStore"
    database: Matisse

class DB_PROC_MAT

inherit

	HANDLE_USE
		export {NONE} all
	end

	DB_PROC_I

	MATISSE_CONST
		export {NONE} all
	end

	INTERNAL
		export {NONE} all
	end

	HANDLE_STREAM
		export {NONE} all
	end

	HANDLE_USE
		export {NONE} all
	end

feature -- Access

	text: STRING is
		-- Name of stream operation
		do
			Result := Clone(name)
		end -- text

feature -- Element change

	load is
 		-- Do nothing
		do
		end -- load

	store (arg: STRING) is
		-- Do nothing : queries are built in
		do
 		end -- store
        
	execute (destination: DB_EXPRESSION) is
		-- Do selection or change
		local
			a_selection : DB_SELECTION
			a_change : DB_CHANGE
			one_class : MT_CLASS
			one_class_stream : MT_CLASS_STREAM
			one_name : STRING
			one_ep_stream : MT_ENTRYPOINT_STREAM
			one_direction : INTEGER_REF
			one_i_stream : MT_INDEX_STREAM
crit_start_array, crit_end_array:ARRAY[ANY]
			one_r_stream : MT_RELATIONSHIP_STREAM
			one_object : MT_OBJECT
			one_relationship : MT_RELATIONSHIP
			one_attribute : MT_ATTRIBUTE
			one_oa_stream : MT_OBJECT_ATT_STREAM
			one_or_stream : MT_OBJECT_REL_STREAM
			one_oir_stream : MT_OBJECT_IREL_STREAM
		do
			handle.status.set_found(0)
			a_selection ?= destination
			if a_selection/=Void then
				if name.is_equal(Ocs) then
					-- Open Class Stream : get all instances of one class
					one_class ?= destination.mapped_value(class_map)
					check one_class/= Void end
					!!one_class_stream.make(one_class.cid)
					Last_stream.put(one_class_stream)
				elseif name.is_equal(Oeps) then
					one_name ?= destination.mapped_value(name_map)
					one_attribute ?= destination.mapped_value(attribute_map)
					one_class ?= destination.mapped_value(class_map)
					check one_class/= Void and one_attribute /= Void and (one_name /= Void and then not one_name.empty)end
					!!one_ep_stream.make(one_name,one_attribute,one_class)
					Last_stream.put(one_ep_stream)
				elseif name.is_equal(Ois) then
					one_name ?= destination.mapped_value(name_map)
					one_direction ?= destination.mapped_value(direction_map)
					one_class ?= destination.mapped_value(class_map)
					check one_class/= Void and (one_direction /= Void ) and (one_name /= Void and then not one_name.empty)end
crit_start_array ?= destination.mapped_value(Index_crit_start_map)
crit_end_array ?= destination.mapped_value(Index_crit_end_map)
check crit_start_array /= Void and crit_end_array /= Void end
check Equal_counts: crit_start_array.count = crit_end_array.count end

					!!one_i_stream.make(one_name, one_class, one_direction.item,
crit_start_array, crit_end_array)
					Last_stream.put(one_i_stream)
				elseif name.is_equal(Ors) then
					-- Open Relationship Stream : In one object, get all object in one relationship
					one_object?= destination.mapped_value(object_map)
					one_relationship ?= destination.mapped_value(relationship_map)
					check one_object/= Void and one_relationship/= Void end
					!!one_r_stream.make(one_object, one_relationship)
					Last_stream.put(one_r_stream)
				elseif name.is_equal(Ooas) then
					-- Open Object Attribute Stream : 
					one_object?= destination.mapped_value(object_map)
					check one_object/= Void end
					!!one_oa_stream.make(one_object)
					Last_stream.put(one_oa_stream)
				elseif name.is_equal(Oors) then
					one_object?= destination.mapped_value(object_map)
					check one_object/= Void end
					!!one_or_stream.make(one_object)
					Last_stream.put(one_or_stream)
				elseif name.is_equal(Ooirs) then
					one_object?= destination.mapped_value(object_map)
					check one_object/= Void end
					!!one_oir_stream.make(one_object)
					Last_stream.put(one_oir_stream)
				end 
			else
				a_change ?= destination
				if a_change /=Void then
					-- Do nothing
				else
					-- Can not perform this operation
				end 
			end
		end -- execute

	drop is
 		-- Do nothing : can not drop built in procedures.
		do
		end -- drop

	change_name (new_name: STRING) is
 		-- Set `name' with `new_name'.
		do
			name := new_name
		end -- change_name

feature -- Status report

	exists: BOOLEAN is
		 -- Does current procedure exist in server?
		do
			Result := name.is_equal(Ois) or name.is_equal(Ocs) or name.is_equal(Ooas)  or name.is_equal(Oors) 
					or name.is_equal(Ooirs)  or name.is_equal(Oeps)  or name.is_equal(Ors) 
		end -- exists

feature {NONE} -- Implementation

	name : STRING

end -- class DB_PROC_MAT
