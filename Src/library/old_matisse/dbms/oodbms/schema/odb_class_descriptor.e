indexing
	description: "Description of a class as known in an object database. This is normally %
                   %a subset of the Eiffel version of the class, since it includes only %
                   %attributes, and generally only a subset of those."
	keywords:    "metaschema odb object database"
	revision:    "%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

deferred class ODB_CLASS_DESCRIPTOR

inherit
	SHARED_METHOD_DISPATCHER
	INTERNAL
		rename
			class_name as eif_class_name,
			field_type as eif_field_type
		export
			{NONE} all
		end

feature {ODB_SCHEMA, ARCHETYPE} -- Access
	class_name:STRING
			-- Eiffel name of this class

	features:ARRAYED_LIST[ODB_FEATURE_DESCRIPTOR]
			-- list of all attribute & relationship features of this class known on the database

	parents:ARRAYED_LIST[STRING]
			-- list of all direct parent classes known in ODB schema (not necessarily same as in Eiffel model)

	ancestors:ARRAYED_LIST[STRING]
			-- list of all ancestor classes known in ODB schema (not necessarily same as in Eiffel model)

	descendants:ARRAYED_LIST[STRING]
			-- list of all descendant classes known in ODB schema (not necessarily same as in Eiffel model)

	index_names:ARRAYED_LIST[STRING]
			-- names of all indexes in which objects of this class can be found

feature {ODB_SCHEMA, ODB_CLASS_DESCRIPTOR} -- Reference Tables
	attributes:ARRAYED_LIST[ODB_FEATURE_DESCRIPTOR]
			-- reference list of attribute features of this class known on the database 
			-- (generally a subset of Eiffel class's attributes)

	relationships:ARRAYED_LIST[ODB_FEATURE_DESCRIPTOR]
			-- reference list of relationship features of this class known on the database 
			-- (generally a subset of Eiffel class's attributes)

feature {ODB_SCHEMA, ODB_CLASS_DESCRIPTOR, STORER, RETRIEVER} -- Reference Tables
	features_by_field_index:HASH_TABLE[ODB_FEATURE_DESCRIPTOR, INTEGER]
			-- reference table of feature descriptors keyed by eiffel field position. 
			-- Enables fast object storage by STORER classes, since the keys are the _only_ eiffel object fields 
			-- which are to be stored on the database.

	features_by_field_name:HASH_TABLE[ODB_FEATURE_DESCRIPTOR, STRING]
			-- table of feature descriptors keyed by eiffel field name

feature -- Access
	db_field_type(i:INTEGER):INTEGER is
			-- get the Database type for the i-th field of an eiffel object
			-- returns 0 if not found
		do
			Result := features_by_field_index.item(i).db_type
		end

	db_field_name(a_field:STRING):STRING is
			-- get the Database name for the eiffel field name 'a_field' or Void if none
		require
			Field_exists: a_field /= Void and then not a_field.empty
		do
			Result := features_by_field_name.item(a_field).db_name
		end

feature -- Status
	is_field_db_type(i:INTEGER):BOOLEAN is
			-- is the i-th field of an eiffel object of this class stored using a native db type?
		deferred
		end

	eif_details_initialised:BOOLEAN

feature {ODB_SCHEMA} -- Modification
	init_eif_details(obj:ANY) is
			-- set up the eiffel attributes hash table so that its contents are the names of eiffel object
			-- fields being stored (may be a subset of all fields on eiffel object), keyed by field number
		require
			Object_matches_class_desc: obj /= Void and then class_name.is_equal(obj.generator)
		deferred
		ensure
			Target_exists: features_by_field_index /= Void and features_by_field_name /= Void
			Flagged: eif_details_initialised
		end

feature -- Conversion
	as_string:STRING is
		local
			i:INTEGER
		do
			!!Result.make(0)
			Result.append(class_name) Result.append(": %N")

			if not parents.empty then
				Result.append("%TPARENTS: ")
				from parents.start until parents.off loop
					if not parents.isfirst then
						Result.append(", ") 
					end
					Result.append(parents.item)
					parents.forth
				end
 				Result.append("%N")
			end

			if not index_names.empty then
				Result.append("%TINDEXES: ")
				from index_names.start until index_names.off loop
					if not index_names.isfirst then
						Result.append(", ") 
					end
					Result.append(index_names.item)
					index_names.forth
				end
 				Result.append("%N")
			end

			if not attributes.empty then
				Result.append("%TATTRIBUTES:%N")
				from 
					attributes.start
				until 
					attributes.off 
				loop
					Result.append("%T%T") Result.append(attributes.item.as_string) 
					Result.append("%N")
					attributes.forth
				end
			end

			if not relationships.empty then
				Result.append("%TRELATIONSHIPS:%N")
				from 
					relationships.start 
				until 
					relationships.off 
				loop
					Result.append("%T%T") Result.append(relationships.item.as_string) 
					Result.append("%N")
					relationships.forth
				end
			end
		end

invariant
	Name_exists: class_name /= Void and then not class_name.empty
	Features_exists: features /= Void
	Attributes_exists: attributes /= Void
	Relationships_exists: relationships /= Void
	Ancestors_exists: ancestors /= Void
	Descendants_exists: descendants /= Void
	Index_names_exists: index_names /= Void

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         |          support: info@deepthought.com.au         |
--         |                                                   |
--         +---------------------------------------------------+

