class SHARED_USE

feature

	Use_properties: HASH_TABLE [CLUST_PROP_SD, STRING] is
			-- Table of use file description for clusters
			-- [Key is the path of a cluster]
		once
			create Result.make (10);
		end

end
