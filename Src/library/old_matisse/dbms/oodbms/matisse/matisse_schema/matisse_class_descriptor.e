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

class MATISSE_CLASS_DESCRIPTOR

inherit
	ODB_CLASS_DESCRIPTOR
		redefine
			features
		end

	MATISSE_CONST
		export
			{NONE} all
		end

creation
	make

feature -- Initialisation
	make(mt_class:MT_CLASS) is
		require
			Class_exists: mt_class /= Void
		local
			mt_attrs:ARRAY[MT_ATTRIBUTE]
			mt_rels:ARRAY[MT_RELATIONSHIP]
			mt_classes:ARRAY[MT_CLASS]
			strings:ARRAYED_LIST[STRING]
			i:INTEGER
			eif_attr_name, mt_class_name:STRING
			mt_feat_desc:MATISSE_FEATURE_DESCRIPTOR
		do
			class_name := clone(mt_class.name)

			!!features.make(0)
			!!features_by_field_name.make(0)

			-- get attributes
			!!attributes.make(0)
			mt_attrs := mt_class.attributes
			from i := mt_attrs.lower until i > mt_attrs.upper loop
				if not mt_attrs.item(i).is_predefined_msp then
					!!mt_feat_desc.make(mt_attrs.item(i).name, mt_attrs.item(i).type)
					features.extend(mt_feat_desc)
					attributes.extend(mt_feat_desc)
					features_by_field_name.put(mt_feat_desc, mt_feat_desc.eif_name)
				end
				i := i + 1
			end

			-- get relationships
			!!relationships.make(0)
			mt_rels := mt_class.relationships
			from i := mt_rels.lower until i > mt_rels.upper loop
				!!mt_feat_desc.make(mt_rels.item(i).name, Mtrelationship_type)
				features.extend(mt_feat_desc)
				relationships.extend(mt_feat_desc)
				features_by_field_name.put(mt_feat_desc, mt_feat_desc.eif_name)
				i := i + 1
			end

			-- get descendants
			mt_classes := mt_class.subclasses
			!!descendants.make(0)
			from i := mt_classes.lower until i > mt_classes.upper loop
				mt_class_name := mt_classes.item(i).name
				mt_class_name.to_upper
				descendants.extend(mt_class_name)
				i := i + 1
			end

			-- get ancestors
			mt_classes := mt_class.superclasses
			!!ancestors.make(0)
			from i := mt_classes.lower until i > mt_classes.upper loop
				mt_class_name := mt_classes.item(i).name
				mt_class_name.to_upper
				ancestors.extend(mt_class_name)
				i := i + 1
			end

			-- get parents
			mt_classes := mt_class.parents
			!!parents.make(0)
			from i := mt_classes.lower until i > mt_classes.upper loop
				mt_class_name := mt_classes.item(i).name
				mt_class_name.to_upper
				parents.extend(mt_class_name)
				i := i + 1
			end

			-- get index names
			strings := mt_class.all_index_names
			!!index_names.make(0)
			from 
				strings.start 
				i := 1 
			until 
				strings.off 
			loop
				index_names.extend(strings.item)
				strings.forth
				i := i + 1
			end
		end

feature -- Access
	features:ARRAYED_LIST[ODB_FEATURE_DESCRIPTOR]

feature -- Status
	is_field_db_type(i:INTEGER):BOOLEAN is
			-- is the i-th field of an eiffel object of this class stored using a native db type?
		do
			Result := features_by_field_index.item(i).is_attribute
		end

feature {ODB_SCHEMA} -- Modification
	init_eif_details(obj:ANY) is
			-- initialise eiffel object field details in each feature descriptor,
			-- and the cross-reference tables 'features_by_field_index', 'features_by_field_name'
		local
			nr_fields, j:INTEGER
			fname:STRING
			found:BOOLEAN
		do
			!!features_by_field_index.make(attributes.count + relationships.count)

			from
				nr_fields := field_count (obj)
				j := 1
			until
				j > nr_fields
			loop
				fname := field_name(j, obj)
				from 
					found := False
					features.start 
				until 
					features.off or found 
				loop
					if features.item.eif_name.is_equal(fname) then
						found := True
						features.item.set_eif_details(eif_field_type(j, obj), j)
						features_by_field_index.put(features.item, j)
					end
					features.forth
				end
				j := j + 1				
			end

			eif_details_initialised := True
		end

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

