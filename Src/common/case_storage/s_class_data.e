indexing

	description: "Data representing class information";
	date: "$Date$";
	revision: "$Revision $"

class S_CLASS_DATA

inherit

	S_LINKABLE_DATA
		rename
			make as old_make
		undefine
			is_equal
		redefine
			chart, set_chart
		end;
	S_CASE_INFO;
	HASHABLE
		rename
			hash_code as view_id
		end

creation

	make

feature

	remove_file (storage_path: STRING) is
			-- Remove file associated with Current.
		require
			valid_storage_path: storage_path /= Void
		local
			internal_file: RAW_FILE;
		do
			!! internal_file.make (file_path (storage_path, view_id, False));
			if internal_file.exists then
				internal_file.delete
			end
		end;

feature {NONE} -- Specification

	make (a_name: STRING) is
		do
			old_make (a_name);
			!! disk_content.make;
		end;

feature -- Properties

	id: INTEGER;
			-- Id of Current

	feature_number: INTEGER;
			-- Number of created features

	generics: FIXED_LIST [S_GENERIC_DATA];
			-- Number of generic parameters

	is_deferred: BOOLEAN;
			-- Is the current class deferred?

	is_effective: BOOLEAN;
			-- Is the current class an effecting a deferred class ?

	is_interfaced: BOOLEAN
			-- Is the current class interfaced with externals ?

	is_persistent: BOOLEAN;
			-- Does the current class have persistant instances ?

	is_reused: BOOLEAN;
			-- Is the current class already implemented
			-- in a previous project and reused in the current one.

	is_root: BOOLEAN;
			-- Is the current class the root of
			-- the system ?

	public_features: ARRAYED_LIST [S_FEATURE_DATA] is
			-- Exported features 
		local
			f_clause: S_FEATURE_CLAUSE
		do
			!! Result.make (20);
			from
				feature_clause_list.start
			until
				feature_clause_list.after
			loop
				f_clause := feature_clause_list.item;
				if f_clause.export_i.is_all then
					Result.append (f_clause.features);
				end;
				feature_clause_list.forth
			end
		ensure
			valid_result: Result /= Void
		end;

	private_features: ARRAYED_LIST [S_FEATURE_DATA] is
			-- Private features 
		local
			f_clause: S_FEATURE_CLAUSE
		do
			!! Result.make (20);
			from
				feature_clause_list.start
			until
				feature_clause_list.after
			loop
				f_clause := feature_clause_list.item;
				if f_clause.export_i.is_none then
					Result.append (f_clause.features);
				end;
				feature_clause_list.forth
			end
		ensure
			valid_result: Result /= Void
		end;

	features: ARRAYED_LIST [S_FEATURE_DATA] is
			-- All features 
		do
			!! Result.make (20);
			from
				feature_clause_list.start
			until
				feature_clause_list.after
			loop
				Result.append (feature_clause_list.item.features);
				feature_clause_list.forth
			end
		end; 

	feature_clause_list: ARRAYED_LIST [S_FEATURE_CLAUSE] is
			-- Features of class
		do
			Result := disk_content.feature_clause_list
		end;

	invariants: FIXED_LIST [S_TAG_DATA] is
			-- Invariants of the current class
		do
			Result := disk_content.invariants
		end;

	chart: S_CLASS_CHART is
			-- Informal description of Current class
		do
			Result := disk_content.chart
		end;

	creation_features	: LINKED_LIST	[ STRING	]

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is Current's name before or after other's name?
		do
			Result := view_id < other.view_id
		end;

feature -- Setting

	set_booleans (is_d, is_e, is_i, is_p, is_re, is_ro: BOOLEAN) is
			-- Set all booleans for Current.
		do
			is_deferred := is_d;
			is_effective := is_e;
			is_interfaced := is_i;
			is_persistent := is_p;
			is_reused := is_re;
			is_root := is_ro;
		ensure
			booleans_are_set: is_deferred = is_d and then
								is_effective = is_e and then
								is_interfaced = is_i and then
								is_persistent = is_p and then
								is_reused = is_re and then
								is_root = is_ro;
		end;

	set_id (i: INTEGER) is
			-- Set id to `i'.
		require
			valid_i: i > 0
		do
			id := i
		ensure
			id_set: id = i
		end;

	set_is_effective is
			-- Set is_effective to `true'.
		do
			is_effective := True
		ensure
			is_effective: is_effective
		end;

	set_generics (l: like generics) is
			-- Set generics to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
		do
			generics := l
		ensure
			generics_set: generics = l
		end;

	set_feature_number (i: INTEGER) is
			-- Set feature_number to `i'.
		do
			feature_number := i
		end;

	set_feature_clause_list (l: like feature_clause_list) is
			-- Set features to `l'.
			--| Allow empty features to be stored
			--| to disk (because of bench).
		require
			valid_l: l /= Void;
		do
			disk_content.set_feature_clause_list (l)
		ensure
			features_set: feature_clause_list = l
		end;

	set_invariants (l: like invariants) is
			-- Set invariants to `l'.
		require
			valid_l: l /= Void;
			l_not_empty: not l.empty;
			not_have_void: not l.has (Void)
		do
			disk_content.set_invariants (l)
		ensure
			invariants_set: invariants = l
		end;

	set_chart (ch: like chart) is
			-- Set chart to `ch'.
		do
			disk_content.set_chart (ch);
		end;

       set_creation_features (l: like creation_features) is
			   -- Set creation_features to `l'.
               require
                       valid_l: l /= Void
               do
                       creation_features := l
               ensure
                       creation_features_set: creation_features = l
               end

feature -- Storage

	directory_path (p: STRING; i: INTEGER): STRING is
		local
			d_name: DIRECTORY_NAME
			temp: STRING
		do
			!!d_name.make_from_string (p);
			!!temp.make (0);
			temp.append_integer (directory_number (view_id))
			d_name.extend (temp)
			Result := d_name
		end

	file_path (p: STRING; i: INTEGER; tmp: BOOLEAN): STRING is
		local
			temp: STRING;
			f_name: FILE_NAME
		do
			!!f_name.make_from_string (p);
			!!temp.make (0);
			temp.append_integer (directory_number (view_id));
			f_name.extend (temp);
			!!temp.make (0);
			temp.append_integer (i);
			f_name.set_file_name (temp);
			if tmp then
				f_name.add_extension (Tmp_file_name_ext)
			end;
			Result := f_name
		end

	save_information (storage_path: STRING) is
			-- Save information to disk.
			--| (Rename tmp file to normal file name);
		require
			valid_path: storage_path /= Void;
		local
			internal_file: RAW_FILE;
		do
			!! internal_file.make (file_path (storage_path, view_id, True));
			internal_file.change_name (file_path (storage_path, view_id, False));
		end;

	tmp_store_to_disk (storage_path: STRING) is
			-- Store internal information to disk tmp.
		require
			valid_path: storage_path /= Void;
			valid_view_id: view_id > 0
		local
			internal_file: RAW_FILE;
			dir: DIRECTORY;
		do
			!! dir.make (directory_path (storage_path, view_id));
			if not dir.exists then
				dir.create_dir
			end;

			!! internal_file.make (file_path (storage_path, view_id, True));
			if (internal_file.exists and then 
				internal_file.is_writable) 
			or else
				(not internal_file.exists and then 
				internal_file.is_creatable) 
			then
				internal_file.open_write;
				disk_content.independent_store (internal_file);
				internal_file.close;
			else
				io.error.putstring ("Error: cannot write to ");
				io.error.putstring (internal_file.name);
				io.error.putstring (". Please check permissions.%N");
			end;
			disk_content := Void;
		ensure
			disk_content_is_void: disk_content = Void
		end;

	remove_tmp_file (storage_path: STRING) is
			-- Remove temporary file.
		require
			valid_storage_path: storage_path /= Void
		local
			internal_file: RAW_FILE;
		do
			!! internal_file.make (file_path (storage_path, view_id, True));
			if internal_file.exists then
				internal_file.delete
			end
		end;

	retrieve_from_disk (p: STRING; is_tmp: BOOLEAN) is
			-- Retrieve internal information from disk.
			-- Look for temporary file if `is_tmp'.
		require
			valid_path: p /= Void;
			valid_view_id: view_id > 0
		local
			internal_file: RAW_FILE;
			path: STRING;
			storable: STORABLE
		do
			!! internal_file.make (file_path (p, view_id, is_tmp));
			if internal_file.exists and then internal_file.is_readable then
				internal_file.open_read;
				!! storable;	
				disk_content ?= storable.retrieved (internal_file);
				check
					valid_disk_content: disk_content /= Void
				end;
				internal_file.close;
			else
				io.error.putstring ("Error in retrieving file %N");
				io.error.putstring (p);
				io.error.new_line
			end
		end;

	wipe_out_information is
			-- Wipe out information that is not needed.
		do
			disk_content := Void
		ensure
			disk_content_is_void: disk_content = Void
		end;

	is_valid: BOOLEAN is
			-- Is Current valid after the retrieve ?
		do
			Result := disk_content /= Void
		end

feature -- Reverse engineering details

	is_new_since_last_re: BOOLEAN is
			-- Is Current class new since
			-- last reverse engineering ?
		do
		end;

	is_reversed_engineered: BOOLEAN is
			-- Is Current class reversed engineered?
		do
		end;

	set_reversed_engineered is
			-- Set `is_reversed_engineered' to True.
		do
		ensure
			is_reversed_engineered: is_reversed_engineered
		end

feature {CLASS_DATA, CLASS_CONTENT_SERVER, RESCUE_INFO,SYSTEM_DATA} -- Implementation

	disk_content: S_CLASS_CONTENT;
			-- Information stored to disk

	set_content (cont: like disk_content) is
			-- Set `disk_content' to cont.
		require
			valid_cont: cont /= Void
		do
			disk_content := cont
		end;

feature {CASE_RECORD_INHERIT_INFO}

	add_feature (s_feature_data: S_FEATURE_DATA; exp: EXPORT_I) is
			-- Add feature `s_feature_data' to a feature clause with
			-- export `exp'.
			--| This is for renamed features. In BON, the renamed
			--| feature is displayed in the Specification text.
		require
			is_valid: is_valid;
			valid_data: s_feature_data /= void;
		local
			export_i: S_EXPORT_I;
			f_clause: S_FEATURE_CLAUSE;
			feats: ARRAYED_LIST [S_FEATURE_DATA];
			comment: S_FREE_TEXT_DATA
		do
			if exp = Void then
				! S_EXPORT_ALL_I ! export_i
			else
				export_i := exp.storage_info
			end;
			from
				feature_clause_list.start
			until
				feature_clause_list.after or else
				feature_clause_list.item.same_export (export_i)
			loop
				feature_clause_list.forth
			end;
			if feature_clause_list.after then
					-- Not found then create clause
				!! feats.make (1);
				feats.extend (s_feature_data);
				!! comment.make (0);
				!! f_clause.make (feats, export_i, comment); 
				feature_clause_list.extend (f_clause)
			else
				feature_clause_list.item.features.extend (s_feature_data)
			end
		end;

end -- class S_CLASS_DATA
