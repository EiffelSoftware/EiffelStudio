indexing
	description: "Implementation of ODB_SCHEMA for Matisse database."
	keywords:    "Matisse"
	revision:    "%%A%%"
	source:      "%%P%%"
	status:      "Not yet determined; NOT FOR GENERAL DISTRIBUTION"
	author:      "Thomas Beale, Deep Thought Informatics Pty Ltd"
	copyright:   "See notice at end of class"

class MATISSE_SCHEMA

inherit
	ODB_SCHEMA
	INTERNAL
		rename
			class_name as eiffel_class_name,
			field_type as eiffel_field_type
		export
			{NONE} all
		end

creation
	make

feature -- Template

feature -- Access

feature -- Modification

feature -- Status
	is_db_implemented_type(obj:ANY; fld:INTEGER):BOOLEAN is
			-- FIXME: need to make this more efficient!
		local
			t:INTEGER
			s:STRING
	    do
			t := eiffel_field_type(fld,obj)
 			inspect t
			when Character_type, Boolean_type, Integer_type, Real_type, Double_type then
				Result := True
			when Reference_type then
				!!s.make(0)
				if obj.conforms_to(s) then
					Result := True
				else
					Result := class_descriptor(obj).is_field_db_type(fld)
				end
			when Expanded_type then
				Result := class_descriptor(obj).is_field_db_type(fld)
			else
				Result := False
			end
	    end

feature -- Status Setting

feature -- Comparison

feature -- Conversion

feature -- Factory

feature {NONE} -- Implementation
	read_schema(a_session:DB_CONTROL) is
			-- read schema of one Matisse database (= 1 session attachment)
		local
			msg:STRING
			mt_class:MT_CLASS
			class_list:ARRAYED_LIST[MT_CLASS]
			class_desc:MATISSE_CLASS_DESCRIPTOR
		do
			debug("odb-schema")
				!!msg.make(0) msg.append(generator) msg.append(".read_schema - Reading database ") msg.append(db_name)
				io.put_string(msg)
			end

			a_session.begin_version_access_latest

			!!mt_class.make("ANY")
			!!class_list.make(0)
			class_list.fill(mt_class.subclasses)

			from class_list.start until class_list.off loop
				!!class_desc.make(class_list.item)
				classes.put(class_desc, class_desc.class_name)
				class_list.forth
			end

			a_session.end_version_access
		end

end

--         +---------------------------------------------------+
--         |                                                   |
--         |                Copyright (c) 1998                 |
--         |            Deep Thought Informatics P/L           |
--         |        Australian Company Number 076 645 291      |
--         |                                                   |
--         |           email: info@deepthought.com.au          |
--         |                                                   |
--         +---------------------------------------------------+

