indexing
	description: "Minimum model of an object suitable for storing in a REP_CLIENT. The %
		       %features are: %
		       %uname - primary identification feature, unique wrt others in collections; %
		       %infix %"<%" and key - for indexing; %
		       %string_to_key and to_string to enable browsing; %
		       %external_key for recording key on system of origin (should eventually be obsolete."
	keywords:    "database, cursor"
	revision:    "%%A%%"
	source:      "%%P%%"
	copyright:   "See notice at end of class"

deferred class REP_ITEM
 
inherit
	COMPOSED_OBJECT
		undefine
			is_equal
		redefine
			pre_store_action
		end

	COMPARABLE

	SHARED_ACCESS
	    undefine
	        is_equal
	    end

feature -- Initialisation
	make_default is
		do
			co_make
		end

feature -- External Data Source
	external_key: STRING
			-- key value from external database system; globally unique

	set_external_key(a_key:STRING) is
		require
			Args_valid: a_key /= Void and then not a_key.empty
		do
			external_key := clone(a_key)
			co_mark_for_store
		end

feature -- Database Indexing
	key:STRING is
			-- stringified key attributes of this object; unique in scope of class
		deferred
		ensure
			Key_exists: Result /= Void
		end

	frozen global_key: STRING is
			-- globally unique form of key: "class_name::key"
		do
			!!Result.make(0)
			Result.append(generator)
			Result.append(Key_classname_separator)
			Result.append(key)
		ensure
			Key_exists: Result /= Void
		end

	frozen Key_classname_separator:STRING is "::"
			-- the separator used between the classname and uname in the 'default_key'

	Key_item_separator:STRING is "~"
			-- separator parts in multi-part keys

	infix "<" (other:like Current):BOOLEAN is
		do
			Result := key < other.key
		end

feature {TRAVERSAL_ACTION} -- Database Indexing
	pre_store_action is
		do
			stored_key := key
		end

	stored_key:STRING
			-- stored version of key for dbs which can't index on relationship values


feature -- Archetype
	rep_client_name:STRING is
		do
			if arch_unit.is_subtype then
				Result := arch_unit.parent_type.description
			else
				Result := arch_unit.description
			end
		ensure
			Result_exists: Result /= Void and then not Result.empty
		end

feature {REP_ITEM} -- Archetype
	arch_unit:ARCH_REP_UNIT is
		require
			Valid_type: archetype.has_type(generator)
		do
			Result := archetype.rep_unit(generator)
		ensure
			Result_exists: Result /= Void
		end

invariant
	Indexable: key /= Void

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                 Copyright (c) 1998                |
--         |           Deep Thought Informatics Pty Ltd        |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         | Duplication,  modification  and/or  distribution  |
--         | permitted with this notice  intact.  Please send  |
--         | modifications  and suggestions to  Deep  Thought  |
--         | Informatics, in  the  interests  of  maintenance  |
--         | and improvement.                                  |
--         |                                                   |
--         | Use of this software is on the understanding that |
--         | the  author(s)  accept no  liability of any kind. |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+

