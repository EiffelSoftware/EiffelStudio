indexing
	description: "Schema of an object database. For systems which support the idea of 'databases' %
                    %as separate repositories, each with their own schema, this abstraction represents %
                    %one of those repositories. One ODB_SCHEMA object is thus required for each physical %
                    %database repository. %
                    % %
                    %The only reason to do this is to allow each repository to have different definitions %
                    %of the same classes, e.g. the Eiffel Base classes such as ARRAY. While in a system %
                    %designed from the ground up, this should not occur, it could easily occur in a %
                    %system containing some legacy and some new repositories. In any case, there is no %
                    %technical reason not to store an object such as an ARRAY differently on two repositories %
                    %if that is what the schemas dictate."
	keywords:    ""
	revision:    "%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

deferred class ODB_SCHEMA

feature -- Initialisation
	make(a_db_name:STRING; a_db_session:DB_CONTROL) is
			-- create the schema representation of 'a_db_name' database repository (= 1 session attachment)
		require
			Db_name_exists: a_db_name /= Void and then not a_db_name.empty
			Session_exists: a_db_session /= Void
		local
			msg:STRING
		do
			!!classes.make(0)

			db_name := a_db_name

			read_schema(a_db_session)
		end

feature -- Access
	db_name:STRING
		-- logical database name

	class_descriptor(obj:ANY):ODB_CLASS_DESCRIPTOR is
		require
			Has_type: has_type(obj.generator)
		local
			msg:STRING
		do
			Result := class_descriptor_by_name(obj.generator)

			-- set up eiffel attributes if never done before
			if not Result.eif_details_initialised then
				Result.init_eif_details(obj)
			end
		ensure
			Result_exists: Result /= Void
		rescue
			!!msg.make(0) msg.append("(FATAL) DATABASE Schema does not know of type: ") msg.append(obj.generator)
			io.put_string(msg)
			io.new_line
		end

	class_descriptor_by_name(a_name:STRING):ODB_CLASS_DESCRIPTOR is
		require
			Has_type: has_type(a_name)
		local
			msg:STRING
		do
			Result := classes.item(a_name)
		ensure
			Result_exists: Result /= Void
		rescue
			!!msg.make(0) msg.append("(FATAL) DATABASE Schema does not know of type: ") msg.append(a_name)
			io.put_string(msg)
			io.new_line
		end

feature -- Status
	has_type(a_type:STRING):BOOLEAN is
		require
			Type_exists: a_type /= Void and then not a_type.empty
		local
			type_str:STRING
		do
			type_str := clone(a_type)
			type_str.to_upper
			Result := classes.has(type_str)
		end

	is_valid:BOOLEAN is
			-- report schema validity; 
			-- fail for: odb attributes not found in eiffel objects
		do
		end

	is_db_implemented_type(obj:ANY; fld:INTEGER):BOOLEAN is
			-- find out if an eiffel type has a native database equivalent
		deferred
	    end

feature -- Iteration

	classes_start is
		do
			classes.start
		end

	classes_off:BOOLEAN is
		do
			Result := classes.off
		end

	classes_forth is
		do
			classes.forth
		end

	classes_item:ODB_CLASS_DESCRIPTOR is
			-- class descriptor at iteration position
		do
			Result := classes.item_for_iteration
		end

	classes_key:STRING is
			-- name of class to which classes_item corresponds
		do
			Result := classes.key_for_iteration
		end


feature -- Factory

	create_by_type(a_type, a_name:STRING): REP_ITEM is
		require
			Valid_type: a_type /= Void and then has_type(a_type)
			Name_exists: a_name /= Void and then not a_name.empty
		local
			class_desc_csr: ODB_REP_ITEM_DESCRIPTOR
			type_str, name_str:STRING
		do
			type_str := clone(a_type)
			type_str.to_upper
			name_str := clone(a_name)
			name_str.to_upper

	--		class_desc_csr := domain_classes.item(type_str)
			if class_desc_csr /= Void then
				Result := class_desc_csr.create_item
			end
		ensure
			Result_exists: Result /= Void
		end

feature -- Conversion
	as_string:STRING is
		do
			!!Result.make(0) 
			Result.append(generator) Result.append("%N")
			from classes.start until classes.off loop
				Result.append("%N")
				Result.append(classes.item_for_iteration.as_string)
				classes.forth
			end
		end

feature {NONE} -- Implementation
	classes:HASH_TABLE[ODB_CLASS_DESCRIPTOR, STRING]
			-- list of class descriptors for all persistent classes in this system

	read_schema(a_session:DB_CONTROL) is
		deferred
		end

invariant
	classes_exists: classes /= Void

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |            Deep Thought Informatics P/L           |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         |          support: info@deepthought.com.au         |
--         |                                                   |
--         +---------------------------------------------------+

