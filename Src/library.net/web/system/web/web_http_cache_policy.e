indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.HttpCachePolicy"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_HTTP_CACHE_POLICY

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_vary_by_headers: WEB_HTTP_CACHE_VARY_BY_HEADERS is
		external
			"IL signature (): System.Web.HttpCacheVaryByHeaders use System.Web.HttpCachePolicy"
		alias
			"get_VaryByHeaders"
		end

	frozen get_vary_by_params: WEB_HTTP_CACHE_VARY_BY_PARAMS is
		external
			"IL signature (): System.Web.HttpCacheVaryByParams use System.Web.HttpCachePolicy"
		alias
			"get_VaryByParams"
		end

feature -- Basic Operations

	frozen set_cacheability (cacheability: WEB_HTTP_CACHEABILITY) is
		external
			"IL signature (System.Web.HttpCacheability): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetCacheability"
		end

	frozen set_expires (date: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetExpires"
		end

	frozen set_proxy_max_age (delta: TIME_SPAN) is
		external
			"IL signature (System.TimeSpan): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetProxyMaxAge"
		end

	frozen append_cache_extension (extension: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpCachePolicy"
		alias
			"AppendCacheExtension"
		end

	frozen set_cacheability_http_cacheability_string (cacheability: WEB_HTTP_CACHEABILITY; field: SYSTEM_STRING) is
		external
			"IL signature (System.Web.HttpCacheability, System.String): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetCacheability"
		end

	frozen set_etag_from_file_dependencies is
		external
			"IL signature (): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetETagFromFileDependencies"
		end

	frozen set_no_server_caching is
		external
			"IL signature (): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetNoServerCaching"
		end

	frozen set_etag (etag: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetETag"
		end

	frozen set_max_age (delta: TIME_SPAN) is
		external
			"IL signature (System.TimeSpan): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetMaxAge"
		end

	frozen set_no_store is
		external
			"IL signature (): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetNoStore"
		end

	frozen set_sliding_expiration (slide: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetSlidingExpiration"
		end

	frozen set_no_transforms is
		external
			"IL signature (): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetNoTransforms"
		end

	frozen set_valid_until_expires (valid_until_expires: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetValidUntilExpires"
		end

	frozen set_vary_by_custom (custom: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetVaryByCustom"
		end

	frozen add_validation_callback (handler: WEB_HTTP_CACHE_VALIDATE_HANDLER; data: SYSTEM_OBJECT) is
		external
			"IL signature (System.Web.HttpCacheValidateHandler, System.Object): System.Void use System.Web.HttpCachePolicy"
		alias
			"AddValidationCallback"
		end

	frozen set_last_modified (date: SYSTEM_DATE_TIME) is
		external
			"IL signature (System.DateTime): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetLastModified"
		end

	frozen set_last_modified_from_file_dependencies is
		external
			"IL signature (): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetLastModifiedFromFileDependencies"
		end

	frozen set_revalidation (revalidation: WEB_HTTP_CACHE_REVALIDATION) is
		external
			"IL signature (System.Web.HttpCacheRevalidation): System.Void use System.Web.HttpCachePolicy"
		alias
			"SetRevalidation"
		end

end -- class WEB_HTTP_CACHE_POLICY
